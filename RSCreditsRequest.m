//
//  RSCreditsRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-23.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCreditsRequest.h"
#import "ReachStatsService.h"


@implementation RSCreditsRequest

@synthesize gamertag;
@synthesize cachedResponseIfYoungerThan;
@synthesize lastModified;

- (id)initWithDelegate:(id)_delegate gamertag:(NSString*)tag age:(NSUInteger)age lastModified:(NSTimeInterval)last {
	if ( self = [super initWithDelegate:_delegate] ) {
		[self setGamertag:tag];
		self.cachedResponseIfYoungerThan = age;
		self.lastModified = last;
	}
	return self;
}

- (void)setGamertag:(NSString *)tag {
	gamertag = [tag copy];
	NSString *gtag = [tag stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	[self setURL:[@"http://api.reachservicerecord.com:8124/credits/" stringByAppendingString:gtag]];
}

- (NSString*)savedPath {
	NSString *tag = [self.gamertag stringByReplacingOccurrencesOfString:@" " withString:@"."];
	return [NSString stringWithFormat:@"%@/api.reach.cache.%@.credits",
			[ReachStatsService applicationDocumentsDirectory],
			tag];
}

- (NSDictionary*)getSaved {
	return [NSDictionary dictionaryWithContentsOfFile:[self savedPath]]; 
}

- (void)cacheData:(NSDictionary*)data {
	NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
															  [NSNumber numberWithFloat:[NSDate timeIntervalSinceReferenceDate]],
															  data,
															  nil]
													 forKeys:[NSArray arrayWithObjects:
															  @"lastModified",
															  @"data",
															  nil]];
	[dict writeToFile:[self savedPath]
		   atomically:YES];
}

- (NSDictionary*)grabIfSaved {
	NSDictionary *saved = [self getSaved];
	if ( saved ) {
		NSTimeInterval savedTime = [[saved objectForKey:@"lastModified"] floatValue];
		if (self.cachedResponseIfYoungerThan) {
			NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate] - (NSTimeInterval)self.cachedResponseIfYoungerThan;
			NSLog(@"time: %f\nlast modified: %f",time,savedTime);
			if ( time < savedTime )
				return [self handleResponse:[saved objectForKey:@"data"]];
		} 
		if (self.lastModified) {
			if ( self.lastModified < savedTime )
				return [self handleResponse:[saved objectForKey:@"data"]];
		}
	}
	return nil;
}

- (id)startSynchronous {
	
	// If cached
	NSDictionary *saved =  [self grabIfSaved];
	if ( saved )
		return saved;
	
	// Send request
	[self.httpRequest startSynchronous];
	
	// If sucess save and return
	if ( [self.httpRequest responseStatusCode] == 200 || [self.httpRequest didUseCachedResponse] ) {
		NSLog(@"saving");
		NSDictionary *data = [self.jsonParser root];
		[self cacheData:data];
		return [self handleResponse:data];
	}
	return nil;
}

- (void)inBackground {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	// If cached
	NSDictionary *saved =  [self grabIfSaved];
	if ( saved )
		[self.delegate performSelector:@selector(requestCompletedWithResponse:) withObject:saved];
	
	// Send request
	[self.httpRequest startAsynchronous];	
	
	[pool release];
}

- (void)apiRequestFinished:(ASIHTTPRequest *)request {
	// If sucess save and return
	if ( [self.httpRequest responseStatusCode] == 200 || [self.httpRequest didUseCachedResponse] ) {
		
		NSDictionary *data = [self.jsonParser root];
		[self cacheData:data];
		[self.delegate performSelector:@selector(requestCompletedWithResponse:)
							withObject:[self handleResponse:data]];
	}
	[self.delegate performSelector:@selector(requestFailedWithError:)
						withObject:@"Unable to contact the API."];
}

- (void)startAsynchronous {
	[self performSelectorInBackground:@selector(inBackground) withObject:nil];
}

@end