//
//  RSGroupedAIStats.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGroupedStats.h"

typedef enum {
	CampaignDifficultyEasy,
	CampaignDifficultyNormal,
	CampaignDifficultyHeroic,
	CampaignDifficultyLegendary
} CampaignDifficulty;


@interface RSGroupedAIStats : RSGroupedStats {
	
	NSDictionary *killsByEnemy;
	NSDictionary *deathsByEnemy;
	NSDictionary *pointsByEnemy;
	NSDictionary *pointsByDamageType;
	
	NSUInteger biggestKillPoints;
	NSUInteger biggestKillStreak;
	CampaignDifficulty difficulty;
	NSUInteger highScoreCoop;
	NSUInteger highScoreSolo;
	NSUInteger highestGameKills;
	NSUInteger highestSet;
	NSUInteger highestSkullMultiplier;
	
	NSUInteger enemyPlayersKilled;
	NSUInteger generatorsDestroyed;
	NSUInteger missionsBeatingPar;
	NSUInteger missionsNotDying;
	
	NSUInteger totalScoreCoop;
	NSUInteger totalScoreSolo;
	NSUInteger totalWavesCompleted;
}

@property (nonatomic,copy) NSDictionary *killsByEnemy;
@property (nonatomic,copy) NSDictionary *deathsByEnemy;
@property (nonatomic,copy) NSDictionary *pointsByEnemy;
@property (nonatomic,copy) NSDictionary *pointsByDamageType;

@property (nonatomic) NSUInteger biggestKillPoints;
@property (nonatomic) NSUInteger biggestKillStreak;
@property (nonatomic) CampaignDifficulty difficulty;
@property (nonatomic) NSUInteger highScoreCoop;
@property (nonatomic) NSUInteger highScoreSolo;
@property (nonatomic) NSUInteger highestGameKills;
@property (nonatomic) NSUInteger highestSet;
@property (nonatomic) NSUInteger highestSkullMultiplier;

@property (nonatomic) NSUInteger enemyPlayersKilled;
@property (nonatomic) NSUInteger generatorsDestroyed;
@property (nonatomic) NSUInteger missionsBeatingPar;
@property (nonatomic) NSUInteger missionsNotDying;

@property (nonatomic) NSUInteger totalScoreCoop;
@property (nonatomic) NSUInteger totalScoreSolo;
@property (nonatomic) NSUInteger totalWavesCompleted;

@end
