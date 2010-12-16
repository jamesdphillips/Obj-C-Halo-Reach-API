//
//  RSGameHistoryRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-19.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"
#import "RSGameHistory.h"


extern NSString * const rsGameHistoryPath;


@interface RSGameHistoryRequest : ReachStatsRequest { }

- (RSGameHistory*)response;
- (NSString *)gamertag;
- (void)setGamertag:(NSString*)gamertag;
- (NSString *)gametype;
- (void)setGametype:(NSString*)gametype;
- (NSUInteger)count;
- (void)setCount:(NSUInteger)count;
- (NSUInteger)startPage;
- (void)setStartPage:(NSUInteger)startPage;
- (BOOL)hasMore;
- (void)setHasMore:(BOOL)hasMore;
- (NSUInteger)summariesBeforeGID;
- (void)setSummariesBeforeGID:(NSUInteger)gid;
- (NSUInteger)summariesAfterGID;
- (void)setSummariesAfterGID:(NSUInteger)gid;
- (NSMutableArray*)summaries;

- (id)initWithGamertag:(NSString *)_gamertag gametype:(NSString *)_gametype summariesBeforeGID:(NSUInteger)_beforeGID summariesAfterGID:(NSUInteger)_afterGID startPage:(NSUInteger)_pageNum count:(NSUInteger)_count delegate:(id)_delegate;
- (id)initWithGamertag:(NSString *)_gamertag gametype:(NSString*)_gametype;
- (id)initWithGamertag:(NSString *)_gamertag;
+ (RSGameHistory *)historyWithGamertag:(NSString *)_gamertag gametype:(NSString *)_gametype summariesBeforeGID:(NSUInteger)_gameID startPage:(NSUInteger)_pageNum count:(NSUInteger)_count;
+ (RSGameHistory *)historyWithGamertag:(NSString *)_gamertag gametype:(NSString *)_gametype summariesAfterGID:(NSUInteger)_gameID startPage:(NSUInteger)_pageNum count:(NSUInteger)_count;
+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag gametype:(NSString *)gametype count:(NSUInteger)count;
+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag gametype:(NSString *)gametype;
+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag count:(NSUInteger)count;
+ (RSGameHistory *)historyWithGamertag:(NSString *)gamertag;
+ (NSArray *)allHistoryWithGamertag:(NSString *)gamertag;
+ (NSArray *)allHistoryWithGamertag:(NSString *)gamertag variant:(NSString *)variant;

@end
