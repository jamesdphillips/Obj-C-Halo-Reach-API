//
//  RSGameDetailsRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-15.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameDetailsRequest.h"
#import "ReachStatsService.h"

/**
 Game details path
 **/
NSString * const rsGameDetailsPath = @"game/details/";

/**
 Class to get game details from the API
 **/
@implementation RSGameDetailsRequest
@synthesize filePath;


/**
 Initialize with the Game ID
 **/
- (id)initWithGameID:(NSUInteger)GID {
	if ( self = [self init] ) {
		[self setGameID:GID];
	}
	return self;
}

/**
 Set the game ID to use in the request
 **/
- (void)setGameID:(NSUInteger)gameID {
	[self setURL:[NSString stringWithFormat:@"%@%@%@/%d",
				  rsBaseURI,
				  rsGameDetailsPath,
				  rsAPIKey,
				  gameID]];
	[self setFilePath:[[ReachStatsService applicationDocumentsDirectory] stringByAppendingFormat:@"/reach.api.cache.game.details.%d.raf",gameID]];
}

- (void)inBackground {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	self.response = [self checkForSavedCopy];
	if (self.response)
		[self.delegate performSelector:@selector(requestCompletedWithResponse:) withObject:self];
	else
		[super startAsynchronous];
	
	[pool release];
}

- (RSGameDetails*)checkForSavedCopy {
	return [[NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]] retain];
}

- (id)handleResponse:(id)dict {
	RSGameDetails *details = [RSGameDetails gameDetailsWithAPIData:[dict objectForKey:@"GameDetails"]];
	[NSKeyedArchiver archiveRootObject:details toFile:self.filePath];
	return [super handleResponse:details];
}

- (id)startSynchronous {
	RSGameDetails *details = [[self checkForSavedCopy] autorelease];
	if (!details)  details = [super startSynchronous];
	return details;
}

- (void)startAsynchronous {
	[self performSelectorInBackground:@selector(inBackground) withObject:nil];
}

/**
 Returns the game details for the given Game ID.
 */
+ (RSGameDetails *)gameDetailsWithGID:(NSUInteger)GID {
	
	RSGameDetailsRequest *request = [[RSGameDetailsRequest alloc] initWithGameID:GID];
	RSGameDetails *rsp = [request startSynchronous];
	[request release];
	
	return rsp;
}

- (void)dealloc {
	[self.filePath release];
	[super dealloc];
}

@end
