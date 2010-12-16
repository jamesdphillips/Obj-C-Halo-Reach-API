//
//  RSGroupedAIStats.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGroupedAIStats.h"


@implementation RSGroupedAIStats

@synthesize	killsByEnemy,deathsByEnemy,pointsByEnemy,pointsByDamageType;
@synthesize biggestKillPoints,biggestKillStreak,difficulty,highScoreCoop,highScoreSolo,highestGameKills,highestSet,highestSkullMultiplier;
@synthesize enemyPlayersKilled,generatorsDestroyed,missionsBeatingPar,missionsNotDying;
@synthesize totalScoreCoop,totalScoreSolo,totalWavesCompleted;

- (id)initWithAPIData:(NSDictionary *)apiData {
	if ( self = [super initWithAPIData:apiData] ) {
		
		NSArray *kbe = [apiData objectForKey:@"KillsByEnemyTypeClass"];
		NSMutableDictionary *kbe_dict = [NSMutableDictionary dictionaryWithCapacity:[kbe count]];
		for ( NSDictionary *obj in kbe ) {
			NSNumber *key = [obj objectForKey:@"Key"];
			NSNumber *value = [obj objectForKey:@"Value"];
			[kbe_dict setObject:value forKey:key];
		}
		self.killsByEnemy = kbe_dict;
		
		NSArray *dbe = [apiData objectForKey:@"DeathsByEnemyTypeClass"];
		NSMutableDictionary *dbe_dict = [NSMutableDictionary dictionaryWithCapacity:[dbe count]];
		for ( NSDictionary *obj in dbe ) {
			NSNumber *key = [obj objectForKey:@"Key"];
			NSNumber *value = [obj objectForKey:@"Value"];
			[dbe_dict setObject:value forKey:key];
		}
		self.deathsByEnemy = dbe_dict;
		
		NSArray *pbe = [apiData objectForKey:@"PointsByEnemyTypeClass"];
		NSMutableDictionary *pbe_dict = [NSMutableDictionary dictionaryWithCapacity:[pbe count]];
		for ( NSDictionary *obj in pbe ) {
			NSNumber *key = [obj objectForKey:@"Key"];
			NSNumber *value = [obj objectForKey:@"Value"];
			[pbe_dict setObject:value forKey:key];
		}
		self.pointsByEnemy = pbe_dict;
		
		NSArray *pbdt = [apiData objectForKey:@"PointsByDamageType"];
		NSMutableDictionary *pbdt_dict = [NSMutableDictionary dictionaryWithCapacity:[pbdt count]];
		for ( NSDictionary *obj in pbdt ) {
			NSNumber *key = [obj objectForKey:@"Key"];
			NSNumber *value = [obj objectForKey:@"Value"];
			[pbe_dict setObject:value forKey:key];
		}
		self.pointsByDamageType = pbdt_dict;
		
		self.biggestKillPoints = [[apiData objectForKey:@"biggest_kill_points"] intValue];
		self.biggestKillStreak = [[apiData objectForKey:@"biggest_kill_streak"] intValue];
		self.difficulty = [[apiData objectForKey:@"game_difficulty"] intValue];
		self.highScoreCoop = [[apiData objectForKey:@"high_score_coop"] intValue];
		self.highScoreSolo = [[apiData objectForKey:@"high_score_solo"] intValue];
		self.highestGameKills = [[apiData objectForKey:@"highest_game_kills"] intValue];
		self.highestSet = [[apiData objectForKey:@"highest_set"] intValue];
		self.highestSkullMultiplier = [[apiData objectForKey:@"highest_skull_multiplier"] intValue];
		self.enemyPlayersKilled = [[apiData objectForKey:@"total_enemy_players_killed"] intValue];
		self.generatorsDestroyed = [[apiData objectForKey:@"total_generators_destroyed"] intValue];
		self.missionsBeatingPar = [[apiData objectForKey:@"total_missions_beating_par"] intValue];
		self.missionsNotDying = [[apiData objectForKey:@"total_missions_not_dying"] intValue];
		self.totalScoreCoop = [[apiData objectForKey:@"total_score_coop"] intValue];
		self.totalScoreSolo = [[apiData objectForKey:@"total_score_solo"] intValue];
		self.totalWavesCompleted = [[apiData objectForKey:@"total_waves_completed"] intValue];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super initWithCoder:aDecoder] ) {
		self.killsByEnemy = [aDecoder decodeObjectForKey:@"kbe"];
		self.deathsByEnemy = [aDecoder decodeObjectForKey:@"dbe"];
		self.pointsByEnemy = [aDecoder decodeObjectForKey:@"pbe"];
		self.pointsByDamageType = [aDecoder decodeObjectForKey:@"pbdt"];
		self.biggestKillPoints = [aDecoder decodeIntForKey:@"bkp"];
		self.biggestKillStreak = [aDecoder decodeIntForKey:@"bks"];
		self.difficulty = [aDecoder decodeIntForKey:@"di"];
		self.highScoreCoop = [aDecoder decodeIntForKey:@"hsc"];
		self.highScoreSolo = [aDecoder decodeIntForKey:@"hss"];
		self.highestGameKills = [aDecoder decodeIntForKey:@"hgk"];
		self.highestSet = [aDecoder decodeIntForKey:@"hs"];
		self.highestSkullMultiplier = [aDecoder decodeIntForKey:@"hsm"];
		self.enemyPlayersKilled = [aDecoder decodeIntForKey:@"epk"];
		self.generatorsDestroyed = [aDecoder decodeIntForKey:@"gd"];
		self.missionsBeatingPar = [aDecoder decodeIntForKey:@"mbp"];
		self.missionsNotDying = [aDecoder decodeIntForKey:@"mnd"];
		self.totalScoreCoop = [aDecoder decodeIntForKey:@"tsc"];
		self.totalScoreSolo = [aDecoder decodeIntForKey:@"tss"];
		self.totalWavesCompleted = [aDecoder decodeIntForKey:@"twc"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.killsByEnemy forKey:@"kbe"];
	[aCoder encodeObject:self.deathsByEnemy forKey:@"dbe"];
	[aCoder encodeObject:self.pointsByEnemy forKey:@"pbe"];
	[aCoder encodeObject:self.pointsByDamageType forKey:@"pbdt"];
	[aCoder encodeInt:self.biggestKillPoints forKey:@"bkp"];
	[aCoder encodeInt:self.biggestKillStreak forKey:@"bks"];
	[aCoder encodeInt:self.difficulty forKey:@"di"];
	[aCoder encodeInt:self.highScoreCoop forKey:@"hsc"];
	[aCoder encodeInt:self.highScoreSolo forKey:@"hss"];
	[aCoder encodeInt:self.highestGameKills forKey:@"hgk"];
	[aCoder encodeInt:self.highestSet forKey:@"hs"];
	[aCoder encodeInt:self.highestSkullMultiplier forKey:@"hsm"];
	[aCoder encodeInt:self.enemyPlayersKilled forKey:@"epk"];
	[aCoder encodeInt:self.generatorsDestroyed forKey:@"gd"];
	[aCoder encodeInt:self.missionsBeatingPar forKey:@"mbp"];
	[aCoder encodeInt:self.missionsNotDying forKey:@"mnd"];
	[aCoder encodeInt:self.totalScoreCoop forKey:@"tsc"];
	[aCoder encodeInt:self.totalScoreSolo forKey:@"tss"];
	[aCoder encodeInt:self.totalWavesCompleted forKey:@"twc"];
	[super encodeWithCoder:aCoder];
}

- (void)dealloc {
	[self.killsByEnemy release];
	[self.deathsByEnemy release];
	[self.pointsByEnemy release];
	[self.pointsByDamageType release];
	[super dealloc];
}

@end
