//
//  RSPlayerDetails.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayer.h"
#import "RSRankMetadata.h"
#import "RSSeasonStats.h"
#import "RSGroupedStats.h"
#import "RSGroupedAIStats.h"
#import "RSVariantPlaylistsStats.h"
#import "RSPlaylistStats.h"


@interface RSPlayerDetails : RSPlayer <NSCoding> {
	
	// AI Carnage
	NSArray *AIStats;
	RSGroupedAIStats *campaignAggregate;
	RSGroupedAIStats *firefightAggregate;
	NSDictionary *campaignAggregateByMap;
	NSDictionary *firefightAggregateByMap;
	
	// Stats by Map
	NSArray *statsByMap;
	RSGroupedStats *invasionStats;
	RSGroupedStats *competitiveStats;
	RSGroupedStats *arenaStats;
	RSGroupedStats *customGameStats;
	
	// Matchmaking Stats
	NSUInteger matchmakingKills;
	NSUInteger matchmakingDeaths;
	NSUInteger matchmakingAssists;
	NSUInteger matchmakingBetrayals;
	NSUInteger matchmakingMedals;
	NSUInteger matchmakingGamesPlayed;
	NSUInteger matchmakingGamesWon;
	NSUInteger matchmakingPlaytime;
	
	// Current Season Stats
	NSDictionary *currentSeasonStats;
	
	// Stats for playlist
	NSDictionary *statsByPlaylist;
	
	// Rank
	NSString*  rankIndex;
	NSString*  rankString;
	NSUInteger rankCredits;
	NSUInteger credits;
	NSUInteger creditsToNextRank;
	
	// Player Model
	NSString *lowResPlayerModelURL;
	NSString *highResPlayerModelURL;
}

@property (copy, nonatomic) NSArray *AIStats;
@property (copy, nonatomic) NSDictionary *currentSeasonStats;;
@property (copy, nonatomic) NSArray *statsByMap;
@property (copy, nonatomic) NSDictionary *statsByPlaylist;

@property (nonatomic,copy) NSDictionary *campaignAggregateByMap;
@property (nonatomic,copy) NSDictionary *firefightAggregateByMap;
@property (nonatomic,retain) RSGroupedAIStats *campaignAggregate;
@property (nonatomic,retain) RSGroupedAIStats *firefightAggregate;
@property (nonatomic,retain) RSGroupedStats *invasionStats;
@property (nonatomic,retain) RSGroupedStats *competitiveStats;
@property (nonatomic,retain) RSGroupedStats *arenaStats;
@property (nonatomic,retain) RSGroupedStats *customGameStats;

@property (nonatomic) NSUInteger matchmakingKills;
@property (nonatomic) NSUInteger matchmakingDeaths;
@property (nonatomic) NSUInteger matchmakingAssists;
@property (nonatomic) NSUInteger matchmakingBetrayals;
@property (nonatomic) NSUInteger matchmakingMedals;
@property (nonatomic) NSUInteger matchmakingGamesPlayed;
@property (nonatomic) NSUInteger matchmakingGamesWon;
@property (nonatomic) NSUInteger matchmakingPlaytime;

@property (copy, nonatomic) NSString *lowResPlayerModelURL;
@property (copy, nonatomic) NSString *highResPlayerModelURL;

@property (copy, nonatomic) NSString *rankIndex;
@property (copy, nonatomic) NSString *rankString;
@property (nonatomic) NSUInteger rankCredits;
@property (nonatomic) NSUInteger credits;
@property (nonatomic) NSUInteger creditsToNextRank;

- (NSURL *)rankIcon;
- (NSString *)rankString;
- (NSUInteger)rankTotalCredits;
- (NSString *)formattedTotalCredits;

- (NSUInteger)matchmakingSpread;
- (float)matchmakingKillDeath;

- (RSVariantPlaylistsStats*)statsWithVariantID:(NSUInteger)variantID;

@end
