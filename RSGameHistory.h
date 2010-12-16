//
//  RSGameHistory.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-12.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameSummary.h"


@interface RSGameHistory : NSObject {
	
	// Summaries
	NSMutableArray *summaries;
	
	// Info
	NSString   *gamertag;
	NSString   *variant;
	NSUInteger firstSummary;
	NSUInteger lastSummary;
	NSUInteger count;
	NSUInteger nextPage;
	
	// More
	BOOL hasMore;
	
}

@property (nonatomic,retain) NSMutableArray *summaries;
@property (nonatomic,copy) NSString *variant;
@property (nonatomic,copy) NSString *gamertag;
@property (nonatomic) NSUInteger firstSummary;
@property (nonatomic) NSUInteger lastSummary;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger nextPage;
@property (nonatomic) BOOL hasMore;

- (id)initWithSummaries:(NSArray *)s gamertag:(NSString *)g variant:(NSString *)v count:(NSUInteger)c page:(NSUInteger)p hasMore:(BOOL)m;
+ (RSGameHistory *)gameHistoryWithSummaries:(NSArray *)s gamertag:(NSString *)g variant:(NSString *)v count:(NSUInteger)c page:(NSUInteger)p hasMore:(BOOL)m;

- (void)addSummary:(RSGameSummary*)summary;
- (NSArray *)getNext;
- (NSArray*)getNewer;

@end
