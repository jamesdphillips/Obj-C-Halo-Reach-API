//
//  RSMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMetadataRequest.h"
#import "ReachStatsService.h"

/**
 * Class to get metadata for given method
 */
@implementation RSMetadataRequest

/**
 * API method
 */
@synthesize method;

/**
 * Max age of the cached data
 */
@synthesize maxAge;

/**
 * Initialize with method and delegate
 */
- (id)initWithMethod:(NSString *)_method delegate:(id)_delegate {
	if ( self = [super initWithDelegate:_delegate] ) {
		[self setMethod:_method];
		[self setMaxAge:120];
	}
	return self;
}

/**
 * Initialize with method
 */
- (id)initWithMethod:(NSString *)_method {
	return [self initWithMethod:_method delegate:nil];
}

/**
 * Get metadata synchronously
 */
+ (NSDictionary*)get {
	RSMetadataRequest *r = [[[self class] alloc] init];
	[r startSynchronous];
	id re = [r response];
	[r release];
	return re;
}

/**
 * Get metadata synchronously using method name
 */
+ (NSDictionary*)getWithMethod:(NSString*)_method {
	RSMetadataRequest *r = [[[self class] alloc] initWithMethod:_method delegate:nil];
	[r startSynchronous];
	id re = [r response];
	[r release];
	return re;
}

- (void)createHTTPRequest {
	[super createHTTPRequest];
	[self.httpRequest setCachePolicy:ASIIgnoreCachePolicy];
}

/**
 * Set Metadata type to return
 */
- (void)setMethod:(NSString*)_method {
	method = [_method copy];
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com:8124/metadata/%@",_method]];
}

/**
 * Get cache path
 */
- (NSString*)getSavedPath {
	return [[ReachStatsService applicationDocumentsDirectory] stringByAppendingFormat:@"/reach.api.cache.metadata.v2.%@",self.method];
}

/**
 * If saved pull from the filesystem
 */
- (NSDictionary*)getSaved {
	return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getSavedPath]];
}

- (id)startSynchronous {
	
	// Grab cached
	NSDictionary *saved = [self getSaved];
	
	// If not expired
	if ( [NSDate timeIntervalSinceReferenceDate] - maxAge < [[saved objectForKey:@"modified"] doubleValue] ) {
		self.response = [saved objectForKey:@"data"];
	}
	
	// If too old check
	else {
	
		// If saved send etag
		if (saved)
		[self.httpRequest addRequestHeader:@"if-none-match" value:[saved objectForKey:@"hash"]];
		
		// Send
		[self.httpRequest startSynchronous];
		
		// Check if new
		if ( [self.httpRequest responseStatusCode] == 200 ) {
			
			[self handleResponse:self.jsonParser.root];
			NSDictionary *file = [NSDictionary
								  dictionaryWithObjects:
								  [NSArray arrayWithObjects:
								   [[self.httpRequest responseHeaders] objectForKey:@"Etag"],
								   response,
								   [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]],
								   nil]
								  forKeys:
								  [NSArray arrayWithObjects:
								   @"hash",
								   @"data",
								   @"modified",
								   nil]];
			[NSKeyedArchiver archiveRootObject:file toFile:[self getSavedPath]];
		}
		
		// If the content hasn't changed update the last-modified
		else {
			NSMutableDictionary *file = [saved mutableCopy];
			[file setObject:[NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]] forKey:@"modified"];
			[NSKeyedArchiver archiveRootObject:file toFile:[self getSavedPath]];
			self.response = [saved objectForKey:@"data"];
			[file release];
		}
	}
	return [self response];
}

- (void)startAsynchronous {
	
	// Grab cached
	NSDictionary *saved = [self getSaved];
	
	// If saved send etag
	if (saved) {
		[self.httpRequest addRequestHeader:@"if-none-match" value:[saved objectForKey:@"hash"]];
		self.response = [saved objectForKey:@"data"];
	}
	
	// Send
	[super startAsynchronous];
}

- (void)apiRequestFailed:(ASIHTTPRequest *)request {
	if ( self.response ) {
		[self.delegate performSelector:@selector(requestCompletedWithResponse:)
							withObject:self.response];
	} else {
		[self.delegate performSelector:@selector(requestFailedWithError:)
							withObject:@"Unable to contact API"];
	}
}

- (void)apiRequestFinished:(ASIHTTPRequest *)request {
	if ( [self.httpRequest responseStatusCode] == 200 ) {
		[self handleResponse:[self.jsonParser root]];
		NSDictionary *file = [NSDictionary
							   dictionaryWithObjects:
							   [NSArray arrayWithObjects:
								[[request responseHeaders] objectForKey:@"Etag"],
								self.response,
								nil]
							   forKeys:
							   [NSArray arrayWithObjects:
								@"hash",
								@"data",
								nil]];
		[NSKeyedArchiver archiveRootObject:file toFile:[self getSavedPath]];
	}
	if ( self.response ) {
		[self.delegate performSelector:@selector(requestCompletedWithResponse:)
							withObject:self.response];
	} else {
		[self.delegate performSelector:@selector(requestFailedWithError:)
							withObject:@"Unable to contact API"];
	}
}

- (void)dealloc {
	[self.method release];
	[super dealloc];
}

@end
