//
//  RSGameHistory.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-12.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameHistoryRequest.h"


@implementation RSGameHistory

@synthesize summaries;
@synthesize gamertag, variant, firstSummary, lastSummary, count, nextPage;
@synthesize hasMore;

/**
 Initialize with summaries
 **/
- (id)initWithSummaries:(NSArray *)s gamertag:(NSString *)g variant:(NSString *)v count:(NSUInteger)c page:(NSUInteger)p hasMore:(BOOL)m {
	
	if ( (self = [super init]) ) {
		
		// Info
		self.gamertag = g;
		self.variant = v;
		self.count = c;
		self.nextPage = p;
		self.hasMore = m;
		
		// Summaries 
		self.summaries = [[s mutableCopy] autorelease];
		
		// set first last
		if ( [self.summaries count] > 0 ) {
			
			self.firstSummary = [[self.summaries objectAtIndex:0] ID];
			self.lastSummary = [[self.summaries lastObject] ID];
		}
		
		// If no summaries 
		else {
			
			self.firstSummary = 0;
			self.lastSummary = NSUIntegerMax;
		}
		
	}
	
	return self;
}

- (id)init {
	if ( (self = [super init]) ) {
		self.summaries = [NSMutableArray array];
	}
	return self;
}

+ (RSGameHistory *)gameHistoryWithSummaries:(NSArray *)s gamertag:(NSString *)g variant:(NSString *)v count:(NSUInteger)c page:(NSUInteger)p hasMore:(BOOL)m {
	return [[[RSGameHistory alloc] initWithSummaries:s gamertag:g variant:(NSString *)v count:c page:p hasMore:m] autorelease];
}

- (void)dealloc {
	 self.summaries = nil;
	[self.gamertag release];
	[self.variant release];
	[super dealloc];
}

- (void)addSummary:(RSGameSummary*)summary {
	[self.summaries addObject:summary];
}

- (NSUInteger)lastSummary {
	if ( lastSummary < 1 ) {
		NSUInteger highestID = 0;
		for ( RSGameSummary *summary in self.summaries ) {
			NSUInteger summaryID = [summary ID];
			if ( summaryID > highestID )
				highestID = summaryID;
		}
		self.lastSummary = highestID;
	}
	return lastSummary;
}

- (NSUInteger)firstSummary {
	if ( !firstSummary ) {
		if ( [self.summaries count] > 0 )
			self.firstSummary = [[self.summaries objectAtIndex:0] ID];
	}
	return firstSummary;
}

/**
 Use this function to get the next set of games
 **/
- (NSArray *)getNext {
	
	// If there are more games to display
	if ( self.hasMore ) {
		
		// Get next set of game summaries
		RSGameHistory *gh = [RSGameHistoryRequest historyWithGamertag:self.gamertag
															 gametype:self.variant
													summariesAfterGID:self.lastSummary
															startPage:self.nextPage
																count:self.count];
		
		// Update Summaries
		[self.summaries addObjectsFromArray:gh.summaries];
		
		// Check if there are more entries
		self.hasMore = gh.hasMore;
		
		// Update info
		self.lastSummary = gh.lastSummary;
		self.nextPage = gh.nextPage;
		
		// Return summaries
		return gh.summaries;
	}
	
	return [NSArray array];
}

/**
 Use this to request newer games then those currently found in this object.
 **/
- (NSArray*)getNewer {
	
	RSGameHistory *gh = nil;
	if ( [self.summaries count] > 0 ) {
#ifdef DEBUG
		NSLog(@"first summary: %d",self.firstSummary);
#endif
		gh = [RSGameHistoryRequest historyWithGamertag:self.gamertag
															 gametype:self.variant
													summariesBeforeGID:self.firstSummary
															startPage:0
																count:NSUIntegerMax];
		if ( [gh.summaries count] > 0 ) {
			for ( int i = 0; i > [gh.summaries count]; i++ )
			[[self summaries] insertObject:[gh.summaries objectAtIndex:i] atIndex:i];
			[self setFirstSummary:[[self.summaries objectAtIndex:0] ID]];
		}
	} else {
		gh = [RSGameHistoryRequest historyWithGamertag:self.gamertag
															 gametype:self.variant
													summariesAfterGID:0
															startPage:0
																count:self.count];
		// Update Summaries
		[self.summaries addObjectsFromArray:gh.summaries];
		
		// Check if there are more entries
		self.hasMore = gh.hasMore;
		
		// Update info
		self.lastSummary = gh.lastSummary;
		self.nextPage = gh.nextPage;
	}
	
	return [gh summaries];
}
 

@end
