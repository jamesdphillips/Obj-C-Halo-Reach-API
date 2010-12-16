//
//  RSCommendation.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendationMetadata.h"

typedef enum {
	RSCommendationRankNone,
	RSCommendationRankIron,
	RSCommendationRankBronze,
	RSCommendationRankSilver,
	RSCommendationRankGold,
	RSCommendationRankOnyx,
	RSCommendationRankMax
} RSCommendationRank;


@interface RSCommendation : RSCommendationMetadata <NSCoding> {
	
	NSUInteger total;
	RSCommendationRank rank;
}

@property (nonatomic) NSUInteger total;
@property (nonatomic) RSCommendationRank rank;

- (id)initWithAPIData:(NSDictionary *)data metadata:(RSCommendationMetadata*)metadata;
- (id)initWithAPIData:(NSDictionary *)data;

- (RSCommendationRank)getRankFromTotal:(NSUInteger)t;
+ (NSString*)rankStringWithRank:(RSCommendationRank)r;
- (NSString*)rankString;
- (NSUInteger)rankTotalWithRank:(RSCommendationRank)r;
- (NSUInteger)nextRankTotal;
- (NSUInteger)nextRankReal;
- (NSURL*)rankImage;
- (CGFloat)percentCompletion;
- (CGFloat)percentCompleteToNextRank;

- (NSString*)gametype;

+ (NSUInteger)totalCreditsWithComendations:(NSArray*)commendations;
+ (NSUInteger)totalCreditsWithComendations:(NSArray *)commendations creditsMetadata:(NSDictionary*)cMetadata;

+ (NSArray*)sortCommendations:(NSArray*)commendations withSelector:(SEL)key;
+ (NSArray*)sortCommendations:(NSArray*)commendations;
+ (NSDictionary*)sortCommendationsByGametype:(NSArray*)commendations;
+ (NSArray*)sortCommendations:(NSArray*)commendations withGametype:(NSString*)gametype;
+ (NSDictionary*)categorizeCommendationsByRank:(NSArray *)commendations;
+ (NSArray*)sortCommendationsByRank:(NSArray *)commendations;
+ (NSArray*)sortCommendationsByNextRankCompletion:(id)commendations;

@end
