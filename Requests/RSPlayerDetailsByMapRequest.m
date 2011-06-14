//
//  RSPlayerDetailsByMapRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-24.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayerDetailsByMapRequest.h"
#import "ReachStatsService.h"
#import "RFC3875+NSString.h"


@implementation RSPlayerDetailsByMapRequest

/**
 Request
 **/
- (void)createHTTPRequest {
    [super createHTTPRequest];
    [self.httpRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
}

/**
 Set gamertag
 **/
- (void)setGamertag:(NSString*)_gamertag {
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com/bymap/%@",
				  [_gamertag stringByAddingRFC3875PercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

/**
 * Get cached object
 */
- (NSDictionary *)getCachedObject {
	return [NSKeyedUnarchiver unarchiveObjectWithFile:[self cacheFileLocation]];
}

/**
 * Save the objec to the disk
 */
- (void)saveObjectToCache:(NSDictionary *)data {
    NSString *fileLocation  = [data objectForKey:@"fileLocation"];
    RSPlayerDetails *detail = [data objectForKey:@"details"];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSDictionary *cacheFile = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
																   detail,
																   [NSNumber numberWithInt:[[detail lastPlayedDate] timeIntervalSince1970]],
																   nil]
														  forKeys:[NSArray arrayWithObjects:
																   @"object",
																   @"last-modified",
																   nil]];
	[NSKeyedArchiver archiveRootObject:cacheFile toFile:fileLocation];
	[pool release];
}

/**
 * Start synchronous
 */
- (id)startSynchronous {
	
	// Get cached object
	NSDictionary *cachedObject = [self getCachedObject];
	
	// If exits
	if ( [[cachedObject objectForKey:@"object"] isKindOfClass:[RSPlayerDetails class]] )
		[self.httpRequest setValue:[[cachedObject objectForKey:@"last-modified"] stringValue] forHTTPHeaderField:@"if-modified-since"];
	
	// Start
    NSHTTPURLResponse *r = nil;
    NSData *rd = [NSURLConnection sendSynchronousRequest:self.httpRequest returningResponse:&r error:nil];
    
    // Parse response
    self.httpResponse = r;
    [self parseJSON:rd];
	
	// 200 response
	if ( [self.httpResponse statusCode] == 200 ) {
		
		NSDictionary *r = [self.jsonParser root];
		if ( [r isKindOfClass:[NSDictionary class]] ) {
			if ( ![ReachStatsRequest checkResponseForErrors:r request:self.httpResponse] ) {
				[self handleResponse:r];
				[self performSelectorInBackground:@selector(saveObjectToCache:)
                                       withObject:[NSDictionary dictionaryWithObjectsAndKeys:self.response,@"details",[self cacheFileLocation],@"fileLocation",nil]];
				return self.response;
			}
		}
	}
	
	// Use cached response
	else if ( cachedObject ) {
		
		self.response = [cachedObject objectForKey:@"object"];
	}
	
	return self.response;
}

@end
