//
//  RSGroupedStats.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-23.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSGroupedStats : NSObject <NSCoding> {
	
	NSDictionary *deathsByDamageType;
	NSDictionary *killsByDamageType;
	NSDictionary *medalCountsByType;
	
	NSInteger  mapID;
	NSUInteger hopperID;
	NSInteger  seasonID;
	NSUInteger variantID;
	
	NSUInteger gameCount;
	NSUInteger highScore;
	NSUInteger wins;
	NSUInteger score;
	NSUInteger kills;
	NSUInteger deaths;
	NSUInteger assists;
	NSUInteger betrayals;
	NSUInteger firstPlace;
	NSUInteger placedTopHalf;
	NSUInteger placedTopThird;
	NSUInteger totalWins;
	
	NSUInteger playtime;
	
	NSUInteger totalMedals;
	float medalChestCompletion;
}

@property (nonatomic,copy) NSDictionary *deathsByDamageType;
@property (nonatomic,copy) NSDictionary *killsByDamageType;
@property (nonatomic,copy) NSDictionary *medalCountsByType;
@property (nonatomic) NSInteger  mapID;
@property (nonatomic) NSUInteger hopperID;
@property (nonatomic) NSInteger seasonID;
@property (nonatomic) NSUInteger variantID;
@property (nonatomic) NSUInteger gameCount;
@property (nonatomic) NSUInteger highScore;
@property (nonatomic) NSUInteger wins;
@property (nonatomic) NSUInteger score;
@property (nonatomic) NSUInteger kills;
@property (nonatomic) NSUInteger deaths;
@property (nonatomic) NSUInteger assists;
@property (nonatomic) NSUInteger betrayals;
@property (nonatomic) NSUInteger firstPlace;
@property (nonatomic) NSUInteger placedTopHalf;
@property (nonatomic) NSUInteger placedTopThird;
@property (nonatomic) NSUInteger totalWins;
@property (nonatomic) NSUInteger playtime;
@property (nonatomic) NSUInteger totalMedals;
@property (nonatomic) float medalChestCompletion;

- (id)initWithAPIData:(NSDictionary*)apiData;
- (void)playtimeWithString:(NSString*)format;
- (NSInteger)spread;
- (float)killDeathRatio;
- (NSComparisonResult)compareByPlaytime:(RSGroupedStats*)item;
- (NSComparisonResult)compareByMapID:(RSGroupedStats*)item;

@end
