//
//  RSPlayerDetailsByMapRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-24.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayerDetailsByMapRequest.h"
#import "ReachStatsService.h"


@implementation RSPlayerDetailsByMapRequest

/**
 Set gamertag
 **/
- (void)setGamertag:(NSString*)_gamertag {
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com:8124/bymap/%@",
				  [_gamertag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
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
- (void)saveObjectToCache {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSDictionary *cacheFile = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
																   self.response,
																   [NSNumber numberWithInt:[[(RSPlayerDetails*)self.response lastPlayedDate] timeIntervalSince1970]],
																   nil]
														  forKeys:[NSArray arrayWithObjects:
																   @"object",
																   @"last-modified",
																   nil]];
	[NSKeyedArchiver archiveRootObject:cacheFile toFile:[self cacheFileLocation]];
	[pool release];
}

/**
 * Start synchronous
 */
- (id)startSynchronous {
	
	// Get cached object
	NSDictionary *cachedObject = [self getCachedObject];
	
	// If exits
	if ( cachedObject )
		[self.httpRequest addRequestHeader:@"if-modified-since"
									 value:[[cachedObject objectForKey:@"last-modified"] stringValue]];
	
	// Start
	[self.httpRequest startSynchronous];
	
	// 200 response
	if ( self.httpRequest.responseStatusCode == 200 ) {
		
		NSDictionary *r = [self.jsonParser root];
		if ( [r isKindOfClass:[NSDictionary class]] ) {
			if ( ![ReachStatsRequest checkResponseForErrors:r request:self.httpRequest] ) {
				[self handleResponse:r];
				[self performSelectorInBackground:@selector(saveObjectToCache) withObject:nil];
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
