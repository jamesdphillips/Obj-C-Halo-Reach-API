//
//  RSGameHistoryRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-19.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameHistoryRequest.h"
#import "ReachStatsService.h"

/**
 GameHistory API Path
 **/
NSString * const rsGameHistoryPath = @"player/gamehistory/";

/**
 Reach Stats Game History Request.
 Interface to acquire game history for a given gamterag
 **/
@implementation RSGameHistoryRequest


/**
 Initialize with information
 **/
- (id)initWithGamertag:(NSString *)_gamertag gametype:(NSString *)_gametype summariesBeforeGID:(NSUInteger)_beforeGID summariesAfterGID:(NSUInteger)_afterGID startPage:(NSUInteger)_pageNum count:(NSUInteger)_count delegate:(id)_delegate {
	
	if ( self = [super initWithDelegate:_delegate] ) {
		
		// Gametype
		if ( !_gametype )
			_gametype = @"Unknown";
		
		// Summaries After GID
		if ( _afterGID < 1 ) {
			_afterGID = NSUIntegerMax;
		}
		
		// Count
		if ( _count == 0 )
			_count = 25;
		
		self.response = [[[RSGameHistory alloc] initWithSummaries:[NSMutableArray array] gamertag:_gamertag variant:_gametype count:_count page:_pageNum hasMore:YES] autorelease];
		[self.response setFirstSummary:_beforeGID];
		[self.response setLastSummary:_afterGID];
	}
	return self;
}


/**
 Initialize with gamertag and gametype
 **/
- (id)initWithGamertag:(NSString *)_gamertag gametype:(NSString*)_gametype {
	return [self initWithGamertag:_gamertag gametype:_gametype summariesBeforeGID:0 summariesAfterGID:0 startPage:0 count:0 delegate:nil];
}


/**
 Initialize with gamertag
 **/
- (id)initWithGamertag:(NSString *)_gamertag {
	return [self initWithGamertag:_gamertag gametype:nil summariesBeforeGID:0 summariesAfterGID:0 startPage:0 count:0 delegate:nil];
}


/**
 API Response
 **/
- (RSGameHistory*)response {
	return response;
}


/**
 Gamertag
 **/
- (NSString *)gamertag {
	return [[self response] gamertag];
}


/**
 Set gamertag
 **/
- (void)setGamertag:(NSString*)gamertag {
	[[self response] setGamertag:gamertag];
}


/**
 Gametype requested
 **/
- (NSString *)gametype {
	return [[self response] variant];
}


/**
 Set gametype
 **/
- (void)setGametype:(NSString*)gametype {
	[[self response] setVariant:gametype];
}


/**
 Amount of games requested
 **/
- (NSUInteger)count {
	return [[self response] count];
}

/**
 Set count
 **/
- (void)setCount:(NSUInteger)count {
	[[self response] setCount:count];
}


/**
 Page to start request on
 **/
- (NSUInteger)startPage {
	return [[self response] nextPage];
}


/**
 Set Page
 **/
- (void)setStartPage:(NSUInteger)startPage {
	[[self response] setNextPage:startPage];
}


/**
 Internal: if the api has more games to return
 **/
- (BOOL)hasMore {
	return [[self response] hasMore];
}


/**
 Has More
 **/
- (void)setHasMore:(BOOL)hasMore {
	[[self response] setHasMore:hasMore];
}


/**
 The summary to stop at
 **/
- (NSUInteger)summariesBeforeGID {
	return [[self response] firstSummary];
}


/**
 Set Summaries Before Game ID
 **/
- (void)setSummariesBeforeGID:(NSUInteger)gid {
	[[self response] setFirstSummary:gid];
}


/**
 The game ID to start at
 **/
- (NSUInteger)summariesAfterGID {
	return [[self response] lastSummary];
}


/**
 Set the summaries after game ID
 **/
- (void)setSummariesAfterGID:(NSUInteger)gid {
	[[self response] setLastSummary:gid];
}


/**
 Return summaries
 **/
- (NSMutableArray*)summaries {
	return [[self response] summaries];
}


/**
 Add a summary
 **/
- (void)addSummary:(RSGameSummary*)summary {
	[[self response] addSummary:summary];
}


/**
 Build URL
 **/
- (void)buildURL {
	NSString *urlString =
	[NSString stringWithFormat:@"%@%@%@/%@/%@/%d",
	 rsBaseURI,
	 rsGameHistoryPath,
	 rsAPIKey,
	 [[self gamertag] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
	 [self gametype],
	 [self startPage]];
	[self setURL:urlString];
}


/**
 Start request synchronously
 **/
- (id)startSynchronous {
	
	while ( 1 ) {
		
		// Build Request
		[self createHTTPRequest];
		[self createJSONParser];
		[self buildURL];
		
		// Start
		[self.httpRequest startSynchronous];
		
		// Check
		NSDictionary *apiData = [self checkResponse:[self.jsonParser root]];
		NSString *error = [[self class] checkResponseForErrors:apiData request:self.httpRequest];
		if (error)
			return nil;
		
		// Get Game Data
		NSArray *gamesAry = [apiData objectForKey:@"RecentGames"];
		
		// Has more
		self.hasMore = [[apiData objectForKey:@"HasMorePages"] boolValue];
		
		// Close loop if nothing was returned
		if ( [gamesAry count] < 1 )
			break;
		
		// Add new games to games array
		int i;
		for (i = 0; i < [gamesAry count] && [self.summaries count] < self.count; i++) {
			NSDictionary *game = [gamesAry objectAtIndex:i];
			NSUInteger lastGID = [[game objectForKey:@"GameId"] intValue];
			if ( lastGID == self.summariesBeforeGID  ) {
				if ( [[self.response summaries] count] > 0 )
					[self setSummariesBeforeGID:[(RSGameSummary*)[[self.response summaries] objectAtIndex:0] ID]];
				return self.response;
			} else if ( lastGID > self.summariesBeforeGID ) {
				RSGameSummary *gameSummary = [[[RSGameSummary alloc] initWithAPIData:game gamertag:self.gamertag] autorelease];
				[self.summaries insertObject:gameSummary atIndex:0];
				//[self setSummariesBeforeGID:lastGID];
			} else if ( lastGID < self.summariesAfterGID ) {
				RSGameSummary *gameSummary = [[[RSGameSummary alloc] initWithAPIData:game gamertag:self.gamertag] autorelease];
				[self.response addSummary:gameSummary];
				[self setSummariesAfterGID:lastGID];
			}
		}
		
		// Increment and continue
		if ( ([self.summaries count] < self.count) && self.hasMore )
			self.startPage++;
		
		// Increment (if needed) and end
		else {
			self.startPage = (i == [gamesAry count]) ? (self.startPage + 1) : self.startPage;
			break;
		}
	}
	
	return self.response;	
}


/**
 Start request aynchronously
 **/
- (void)startAsynchronous {
	[self  createHTTPRequest];
	[self  createJSONParser];
	[self  buildURL];
	self.httpRequest.delegate = self;
	[super startAsynchronous];
}

- (void)apiRequestFinished:(ASIHTTPRequest *)request {
	
	// Check
	NSDictionary *apiData = [self checkResponse:[self.jsonParser root]];
	NSString *error = [[self class] checkResponseForErrors:apiData request:self.httpRequest];
	
	if (error)
		[self.delegate performSelector:@selector(requestFailedWithError:) withObject:error];
	
	// Get Game Data
	NSArray *gamesAry = [apiData objectForKey:@"RecentGames"];
	
	// Has more
	self.hasMore = [[apiData objectForKey:@"HasMorePages"] boolValue];
	
	// Add new games
	if ( [gamesAry count] > 1 ) {
		
		// Add new games to games array
		int i;
		for (i = 0; i < [gamesAry count] && [self.summaries count] < self.count; i++) {
			NSDictionary *game = [gamesAry objectAtIndex:i];
			NSUInteger lastGID = [[game objectForKey:@"GameId"] intValue];
			if ( lastGID == self.summariesBeforeGID  ) {
				[self.delegate performSelector:@selector(requestCompletedWithResponse:) withObject:self];
			} else if ( lastGID < self.summariesAfterGID ) {
				RSGameSummary *gameSummary = [[[RSGameSummary alloc] initWithAPIData:game gamertag:self.gamertag] autorelease];
				[self.response addSummary:gameSummary];
			}
		}
		
		// Increment and continue
		if ( ([self.summaries count] < self.count) && self.hasMore ) {
			self.startPage++;
			[self performSelectorOnMainThread:@selector(startAsynchronous) withObject:nil waitUntilDone:NO];
		}
		
		// Increment (if needed) and end
		else {
			self.startPage = (i == [gamesAry count]) ? (self.startPage + 1) : self.startPage;
		}
	}
	
	[self.delegate performSelector:@selector(requestCompletedWithResponse:) withObject:self];
}

+ (RSGameHistory *)historyWithGamertag:(NSString *)_gamertag gametype:(NSString *)_gametype summariesBeforeGID:(NSUInteger)_gameID startPage:(NSUInteger)_pageNum count:(NSUInteger)_count {
	
	RSGameHistoryRequest *request = [[RSGameHistoryRequest alloc] initWithGamertag:_gamertag gametype:_gametype summariesBeforeGID:_gameID summariesAfterGID:NSUIntegerMax startPage:_pageNum count:_count delegate:nil];
	RSGameHistory *gameHistory = [request startSynchronous];
	[request release];
	return gameHistory;
}

+ (RSGameHistory *)historyWithGamertag:(NSString *)_gamertag gametype:(NSString *)_gametype summariesAfterGID:(NSUInteger)_gameID startPage:(NSUInteger)_pageNum count:(NSUInteger)_count {
	
	RSGameHistoryRequest *request = [[RSGameHistoryRequest alloc] initWithGamertag:_gamertag gametype:_gametype summariesBeforeGID:0 summariesAfterGID:_gameID startPage:_pageNum count:_count delegate:nil];
	RSGameHistory *gameHistory = [request startSynchronous];
	[request release];
	return gameHistory;
}

+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag gametype:(NSString *)gametype count:(NSUInteger)count {
	return [RSGameHistoryRequest historyWithGamertag:gamertag gametype:gametype summariesAfterGID:0 startPage:0 count:count];
}

+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag gametype:(NSString *)gametype {
	return [RSGameHistoryRequest historyWithGamertag:gamertag gametype:gametype summariesAfterGID:0 startPage:0 count:25];
}

+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag count:(NSUInteger)count {
	return [RSGameHistoryRequest historyWithGamertag:gamertag gametype:@"Unknown" summariesAfterGID:0 startPage:0 count:count];
}

+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag {
	return [RSGameHistoryRequest historyWithGamertag:gamertag gametype:@"Unknown" summariesAfterGID:0 startPage:0 count:25];
}

+ (NSArray *)allHistoryWithGamertag:(NSString *)gamertag {
	return [RSGameHistoryRequest historyWithGamertag:gamertag gametype:@"Unknown" summariesAfterGID:0 startPage:0 count:NSUIntegerMax].summaries;
}

+ (NSArray *)allHistoryWithGamertag:(NSString *)gamertag variant:(NSString *)variant {
	return [RSGameHistoryRequest historyWithGamertag:gamertag gametype:variant summariesAfterGID:0 startPage:0 count:NSUIntegerMax].summaries;
}

@end
