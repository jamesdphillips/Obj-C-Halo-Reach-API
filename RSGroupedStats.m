//
//  RSGroupedStats.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-23.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGroupedStats.h"


@implementation RSGroupedStats

@synthesize deathsByDamageType, killsByDamageType, medalCountsByType;
@synthesize mapID, hopperID, seasonID, variantID;
@synthesize gameCount, highScore, wins, score, kills, deaths, assists, betrayals, firstPlace, placedTopHalf, placedTopThird, totalWins;
@synthesize playtime;
@synthesize	totalMedals;
@synthesize medalChestCompletion;

- (id)initWithAPIData:(NSDictionary*)apiData {
	if ( self = [super init] ) {
		
		// DeathsByDamageType
		NSArray *dbdt = [apiData objectForKey:@"DeathsByDamageType"];
		NSMutableDictionary *dbdt_dict = [NSMutableDictionary dictionaryWithCapacity:[dbdt count]];
		for ( NSDictionary *type in dbdt ) {
			NSNumber *key = [type objectForKey:@"Key"];
			NSNumber *value = [type objectForKey:@"Value"];
			[dbdt_dict setObject:value forKey:key];
		}
		self.deathsByDamageType = dbdt_dict;
		
		// KillsByDamageType
		NSArray *kbdt = [apiData objectForKey:@"KillsByDamageType"];
		NSMutableDictionary *kbdt_dict = [NSMutableDictionary dictionaryWithCapacity:[kbdt count]];
		for ( NSDictionary *type in kbdt ) {
			NSNumber *key = [type objectForKey:@"Key"];
			NSNumber *value = [type objectForKey:@"Value"];
			[kbdt_dict setObject:value forKey:key];
		}
		self.killsByDamageType = kbdt_dict;
		
		// MedalsCountByType
		NSArray *mcbt = [apiData objectForKey:@"MedalCountsByType"];
		NSMutableDictionary *mcbt_dict = [NSMutableDictionary dictionaryWithCapacity:[mcbt count]];
		for ( NSDictionary *type in mcbt ) {
			NSNumber *key = [type objectForKey:@"Key"];
			NSNumber *value = [type objectForKey:@"Value"];
			[mcbt_dict setObject:value forKey:key];
		}
		self.medalCountsByType = mcbt_dict;
		
		// Info
		if ( ![[apiData objectForKey:@"MapId"] isKindOfClass:[NSNull class]] )
			self.mapID = [[apiData objectForKey:@"MapId"] intValue];
		if ( ![[apiData objectForKey:@"HopperId"] isKindOfClass:[NSNull class]] )
			self.hopperID = [[apiData objectForKey:@"HopperId"] intValue];
		self.seasonID = [[apiData objectForKey:@"season_id"] intValue];
		self.variantID = [[apiData objectForKey:@"VariantClass"] intValue];
		
		// Stats
		self.gameCount = [[apiData objectForKey:@"game_count"] intValue];
		self.highScore = [[apiData objectForKey:@"high_score"] intValue];
		self.wins = [[apiData objectForKey:@"total_wins"] intValue];
		self.score = [[apiData objectForKey:@"total_score"] intValue];
		self.kills = [[apiData objectForKey:@"total_kills"] intValue];
		self.deaths = [[apiData objectForKey:@"total_deaths"] intValue];
		self.assists = [[apiData objectForKey:@"total_assists"] intValue];
		self.betrayals = [[apiData objectForKey:@"total_betrayals"] intValue];
		self.firstPlace = [[apiData objectForKey:@"total_first_place"] intValue];
		self.placedTopHalf = [[apiData objectForKey:@"total_top_half_place"] intValue];
		self.placedTopThird = [[apiData objectForKey:@"total_top_third_place"] intValue];
		self.totalWins = [[apiData objectForKey:@"total_wins"] intValue];
		self.totalMedals = [[apiData objectForKey:@"TotalMedals"] intValue];
		
		// Playtime
		[self playtimeWithString:[apiData objectForKey:@"total_playtime"]];
		
		// Medals
		self.medalChestCompletion = [[apiData objectForKey:@"MedalChestCompletionPercentage"] floatValue];
		
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.deathsByDamageType = [aDecoder decodeObjectForKey:@"dbdt"];
		self.killsByDamageType = [aDecoder decodeObjectForKey:@"kbdt"];
		self.medalCountsByType = [aDecoder decodeObjectForKey:@"mcbt"];
		self.mapID = [aDecoder decodeIntForKey:@"mI"];
		self.hopperID = [aDecoder decodeIntForKey:@"hI"];
		self.seasonID = [aDecoder decodeIntForKey:@"sI"];
		self.variantID = [aDecoder decodeIntForKey:@"vI"];
		self.gameCount = [aDecoder decodeIntForKey:@"gC"];
		self.highScore = [aDecoder decodeIntForKey:@"hS"];
		self.wins = [aDecoder decodeIntForKey:@"w"];
		self.score = [aDecoder decodeIntForKey:@"s"];
		self.kills = [aDecoder decodeIntForKey:@"k"];
		self.deaths = [aDecoder decodeIntForKey:@"d"];
		self.assists = [aDecoder decodeIntForKey:@"a"];
		self.betrayals = [aDecoder decodeIntForKey:@"b"];
		self.firstPlace = [aDecoder decodeIntForKey:@"fP"];
		self.placedTopHalf = [aDecoder decodeIntForKey:@"pTH"];
		self.placedTopThird = [aDecoder decodeIntForKey:@"pTT"];
		self.totalMedals = [aDecoder decodeIntForKey:@"tM"];
		self.totalWins = [aDecoder decodeIntForKey:@"tW"];
		self.playtime = [aDecoder decodeIntForKey:@"pT"];
		self.medalChestCompletion = [aDecoder decodeFloatForKey:@"mCC"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.deathsByDamageType forKey:@"dbdt"];
	[aCoder encodeObject:self.killsByDamageType forKey:@"kbdt"];
	[aCoder encodeObject:self.medalCountsByType forKey:@"mcbt"];
	[aCoder encodeInt:self.mapID forKey:@"mI"];
	[aCoder encodeInt:self.hopperID	 forKey:@"hI"];
	[aCoder encodeInt:self.seasonID	 forKey:@"sI"];
	[aCoder encodeInt:self.variantID forKey:@"vI"];
	[aCoder encodeInt:self.gameCount forKey:@"gC"];
	[aCoder encodeInt:self.highScore forKey:@"hS"];
	[aCoder encodeInt:self.wins forKey:@"w"];
	[aCoder encodeInt:self.score forKey:@"s"];
	[aCoder encodeInt:self.kills forKey:@"k"];
	[aCoder encodeInt:self.deaths forKey:@"d"];
	[aCoder encodeInt:self.assists forKey:@"a"];
	[aCoder encodeInt:self.betrayals forKey:@"b"];
	[aCoder encodeInt:self.firstPlace forKey:@"fP"];
	[aCoder encodeInt:self.placedTopHalf forKey:@"pTH"];
	[aCoder encodeInt:self.placedTopThird forKey:@"pTT"];
	[aCoder encodeInt:self.totalMedals forKey:@"tM"];
	[aCoder encodeInt:self.totalWins forKey:@"tW"];
	[aCoder encodeInt:self.playtime forKey:@"pT"];
	[aCoder encodeFloat:self.medalChestCompletion forKey:@"mCC"];
}

- (void)dealloc {
	[self.deathsByDamageType release];
	[self.killsByDamageType release];
	[self.medalCountsByType release];
	[super dealloc];
}

- (void)playtimeWithString:(NSString*)format {
	NSUInteger _playtime = 0;
	NSMutableString *f = [format mutableCopy];
	
	// Get Days
	NSRange daysRange = [f rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"D"]];
	if (daysRange.length) {
		NSRange time = NSMakeRange(1, (daysRange.location-1));
		_playtime += [[f substringWithRange:time] integerValue] * 24 * 60 * 60;
	}
	
	// Strip pt and characters
	NSRange tRange = [format rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"T"]];
	[f deleteCharactersInRange:NSMakeRange(0, (tRange.location + 1))];
	
	// Get Hours
	NSRange hoursRange = [f rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"H"]];
	if (hoursRange.length) {
		_playtime += [[f substringToIndex:hoursRange.location] integerValue] * 60 * 60;
		[f deleteCharactersInRange:NSMakeRange(0, hoursRange.location+1)];
	}
	
	// Get Minutes
	NSRange minutesRange = [f rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"M"]];
	if (minutesRange.length) {
		_playtime += [[f substringToIndex:minutesRange.location] integerValue] * 60;
		[f deleteCharactersInRange:NSMakeRange(0, minutesRange.location+1)];
	}
	
	// Get Seconds
	NSRange secondsRange = [f rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"S"]];
	if (secondsRange.length) {
		_playtime += [[f substringToIndex:secondsRange.location] integerValue];
	}
	
	[f release];
	
	self.playtime = _playtime;
}

- (NSInteger)spread {
	return [self kills]-[self deaths];
}

- (float)killDeathRatio {
	return (float)[self kills]/(float)[self deaths];
}

- (NSComparisonResult)compareByPlaytime:(RSGroupedStats*)item {
	if ( self.playtime > item.playtime )
		return NSOrderedAscending;
	else if ( self.playtime == item.playtime )
		return NSOrderedSame;
	else
		return NSOrderedDescending;
}

- (NSComparisonResult)compareByMapID:(RSGroupedStats*)item {
	if ( self.mapID > item.mapID )
		return NSOrderedAscending;
	else if ( self.mapID == item.mapID )
		return NSOrderedSame;
	else
		return NSOrderedDescending;
}

@end
