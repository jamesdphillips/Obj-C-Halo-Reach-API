//
//  RSPlayerGameDetails.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayerGameDetails.h"
#import "RSScoreOverTime.h"
#import "RSPlayer.h"
#import "RSEnemyMetadataRequest.h"
#import "RSWeaponMetadataRequest.h"




/**
 ** Weapon Carnage
 */

@implementation RSWeaponCarnage


#pragma mark -
#pragma mark Synthesize

@synthesize ID;
@synthesize deaths,headshots,kills,penalties;
@synthesize name,description;


#pragma mark -
#pragma mark Initialize

- (id)initWithID:(NSUInteger)i deaths:(NSUInteger)d headshots:(NSUInteger)h kills:(NSUInteger)k penalties:(NSUInteger)p {
	if ( (self = [super init]) ) {
		self.ID = i;
		self.deaths = d;
		self.headshots = h;
		self.kills = k;
		self.penalties = p;
	}
	return self;
}

- (id)initWithAPIData:(NSDictionary *)data {
	if ( (self = [super init]) ) {
		self.ID = [[data objectForKey:@"WeaponId"] intValue];
		self.deaths = [[data objectForKey:@"Deaths"] intValue];
		self.headshots = [[data objectForKey:@"Headshots"] intValue];
		self.kills = [[data objectForKey:@"Kills"] intValue];
		self.penalties = [[data objectForKey:@"Penalties"] intValue];
	}
	return self;
}

+ (RSWeaponCarnage *)weaponCarnageWithID:(NSUInteger)i deaths:(NSUInteger)d headshots:(NSUInteger)h kills:(NSUInteger)k penalties:(NSUInteger)p {
	return [[[RSWeaponCarnage alloc] initWithID:i deaths:d headshots:h kills:k penalties:p] autorelease];
}

+ (RSWeaponCarnage *)weaponCarnageWithAPIData:(NSDictionary *)data {
	return [[[RSWeaponCarnage alloc] initWithAPIData:data] autorelease];
}

+ (RSWeaponCarnage *)weaponCarnageWithAPIData:(NSDictionary *)data name:(NSString *)n description:(NSString *)d {
	RSWeaponCarnage *wc = [[[RSWeaponCarnage alloc] initWithAPIData:data] autorelease];
	[wc setName:n];
	[wc setDescription:d];
	return wc;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.deaths = [aDecoder decodeIntForKey:@"d"];
		self.headshots = [aDecoder decodeIntForKey:@"h"];
		self.kills = [aDecoder decodeIntForKey:@"k"];
		self.penalties = [aDecoder decodeIntForKey:@"p"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"desc"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.ID forKey:@"I"];
	[aCoder encodeInt:self.deaths forKey:@"d"];
	[aCoder encodeInt:self.headshots forKey:@"h"];
	[aCoder encodeInt:self.kills forKey:@"k"];
	[aCoder encodeInt:self.penalties forKey:@"p"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"desc"];
}

- (NSString*)imageURL {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/weapons/%d.png",self.ID];
}

- (NSString*)doubleSizedImageURL {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/weapons/%d@2x.png",self.ID];
}

- (NSComparisonResult)compare:(RSWeaponCarnage*)obj {
	if ( self.kills > obj.kills )
		return NSOrderedAscending;
	else if ( self.kills < obj.kills )
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}

- (void)dealloc {
	[self.name release];
	[self.description release];
	[super dealloc];
}

@end




/**
 ** Vehicle Carnage
 */

@implementation RSAICarnage

@synthesize ID;
@synthesize name, description, imageName;
@synthesize penalties, betrayals, points;
@synthesize killAverageDistance,killCount,killDistances,killsPerHour,killTimes;
@synthesize killedByAverageDistance,killedByCount,killedByDistances,killedByTimes;


#pragma mark -
#pragma mark Initialize

- (id)initWithAPIData:(NSDictionary *)data {
	if ( (self = [super init]) ) {
		
		
		/**
		 ** ID
		 */
		
		self.ID = [[data objectForKey:@"aiTypeClass"] intValue];
		
		
		/**
		 ** Points
		 */
		
		self.penalties = [[data objectForKey:@"PenaltyPoints"] intValue];
		self.betrayals = [[data objectForKey:@"PlayerBetrayedAiCount"] intValue];
		self.points = [[data objectForKey:@"Points"] intValue];
		
		
		/** 
		 ** Kills
		 */
		
		// Kill Distances
		NSMutableArray *temp_kd = [[NSMutableArray alloc] init];
		for ( NSNumber *killDistance in [data objectForKey:@"PlayerKilledAiDistancesInMeters"] ) {
			[temp_kd addObject:killDistance];
		}
		self.killDistances = temp_kd;
		[temp_kd release];
		
		// Kill Times
		NSMutableArray *temp_kt = [[NSMutableArray alloc] init];
		for ( NSNumber *killTime in [data objectForKey:@"PlayerKilledAiTimeIndexes"] ) {
			[temp_kt addObject:killTime];
		}
		self.killTimes = temp_kt;
		[temp_kt release];
		
		// Details
		self.killAverageDistance = [[data objectForKey:@"PlayerKilledAiAverageDistanceInMeters"] floatValue];
		self.killCount = [[data objectForKey:@"PlayerKilledAiCount"] intValue];
		self.killsPerHour = [[data objectForKey:@"PlayerKilledAiPerHour"] floatValue];
		
		
		/**
		 ** Killed By
		 */
		
		// Killed By Distances
		NSMutableArray *temp_kbd = [[NSMutableArray alloc] init];
		for ( NSNumber *killedByDistance in [data objectForKey:@"PlayerKilledByAiDistancesInMeters"] ) {
			[temp_kbd addObject:killedByDistance];
		}
		self.killedByDistances = temp_kbd;
		[temp_kbd release];
		
		// Killed By Times
		NSMutableArray *temp_kbt = [[NSMutableArray alloc] init];
		for ( NSNumber *killedByTime in [data objectForKey:@"PlayerKilledByAiTimeIndexes"] ) {
			[temp_kbt addObject:killedByTime];
		}
		self.killedByTimes = temp_kbt;
		[temp_kbt release];
		
		// Details
		self.killedByCount = [[data objectForKey:@"PlayerKilledByAiCount"] intValue];
		self.killedByAverageDistance = [[data objectForKey:@"PlayerKilledByAiAverageDistanceInMeters"] floatValue];
	}
	return self;
}

+ (RSAICarnage *)AICarnageWithAPIData:(NSDictionary *)data {
	return [[[RSAICarnage alloc] initWithAPIData:data] autorelease];
}

+ (RSAICarnage *)AICarnageWithAPIData:(NSDictionary *)data name:(NSString *)n description:(NSString *)d imageName:(NSString *)iname {
	
	RSAICarnage *ai = [self AICarnageWithAPIData:data];
	[ai setName:n];
	[ai setDescription:d];
	[ai setImageName:iname];
	
	return ai;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.penalties = [aDecoder decodeIntForKey:@"p"];
		self.betrayals = [aDecoder decodeIntForKey:@"b"];
		self.points = [aDecoder decodeIntForKey:@"po"];
		self.killAverageDistance = [aDecoder decodeFloatForKey:@"kAD"];
		self.killCount = [aDecoder decodeIntForKey:@"kC"];
		self.killDistances = [aDecoder decodeObjectForKey:@"kD"];
		self.killsPerHour = [aDecoder decodeFloatForKey:@"kPH"];
		self.killTimes = [aDecoder decodeObjectForKey:@"killTimes"];
		self.killedByAverageDistance = [aDecoder decodeFloatForKey:@"kBAD"];
		self.killedByCount = [aDecoder decodeIntForKey:@"kBC"];
		self.killedByDistances = [aDecoder decodeObjectForKey:@"kBD"];
		self.killedByTimes = [aDecoder decodeObjectForKey:@"kBT"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"d"];
		self.imageName = [aDecoder decodeObjectForKey:@"iN"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.ID forKey:@"I"];
	[aCoder encodeInt:self.penalties forKey:@"p"];
	[aCoder encodeInt:self.betrayals forKey:@"b"];
	[aCoder encodeInt:self.points forKey:@"po"];
	[aCoder encodeFloat:self.killAverageDistance forKey:@"kAD"];
	[aCoder encodeInt:self.killCount forKey:@"kC"];
	[aCoder encodeObject:self.killDistances forKey:@"kD"];
	[aCoder encodeFloat:self.killsPerHour forKey:@"kPH"];
	[aCoder encodeObject:self.killTimes forKey:@"kT"];
	[aCoder encodeFloat:self.killedByAverageDistance forKey:@"kBAD"];
	[aCoder encodeInt:self.killedByCount forKey:@"kBC"];
	[aCoder encodeObject:self.killedByDistances forKey:@"kBD"];
	[aCoder encodeObject:self.killedByTimes forKey:@"kBT"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"d"];
	[aCoder encodeObject:self.imageName forKey:@"iN"];
}

- (NSUInteger)killDistanceAtIndex:(NSUInteger)index {
	return [[self.killDistances objectAtIndex:index] intValue];
}

- (NSUInteger)killTimeAtIndex:(NSUInteger)index {
	return [[self.killTimes objectAtIndex:index] intValue];
}

- (NSUInteger)killedByDistanceAtIndex:(NSUInteger)index {
	return [[self.killedByDistances objectAtIndex:index] intValue];
}

- (NSUInteger)killedByTimeAtIndex:(NSUInteger)index {
	return [[self.killedByTimes objectAtIndex:index] intValue];
}

- (NSString*)imageURL {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/enemies/%@.png",self.imageName];
}

- (NSString*)doubleSizedImageURL {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/enemies/%@@2x.png",self.imageName];
}

- (NSComparisonResult)compare:(RSAICarnage*)obj {
	if ( self.killCount > obj.killCount )
		return NSOrderedAscending;
	else if ( self.killCount < obj.killCount )
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}

- (void)dealloc {
	[self.killDistances release];
	[self.killTimes release];
	[self.killedByDistances release];
	[self.killedByTimes release];
	[self.name release];
	[self.description release];
	[self.imageName release];
	[super dealloc];
}

@end





/** 
 ** Player Game Details
 */ 
@implementation RSPlayerGameDetails

@synthesize AICarnage;
@synthesize pointsOverTime,killsOverTime,deathsOverTime,assists,betrayals,deaths,individualStandingWithNoRegardsForTeams,kills,rating,score,standing,suicides,DNF;
@synthesize averageDeathDistanceMeters, averageKillDistanceMeters;
@synthesize	team, teamScore;
@synthesize medalsOverTime,medalCounts,multiMedalCount,otherMedalCount,spreeMedalCount,styleMedalCount,totalMedalCount,uniqueMultiMedalCount,uniqueOtherMedalCount,uniqueSpreeMedalCount,uniqueStyleMedalCount,uniqueTotalMedalCount;
@synthesize	playerDetail, killedMost, killedMostCount, killedByMost, killedByMostCount;
@synthesize weaponCarnage,headshots;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( (self = [super init]) ) {
		
		
		/**
		 ** AI Data
		 */
		NSDictionary *enemyMetadata = [RSEnemyMetadataRequest get];
		NSMutableDictionary *temp_vd = [[NSMutableDictionary alloc] init];
		for ( NSDictionary *vd in [data objectForKey:@"AiEventAggregates"] ) {
			RSEnemiesMetadata *m = [enemyMetadata objectForKey:[vd objectForKey:@"Key"]];
			[temp_vd setObject:[RSAICarnage AICarnageWithAPIData:[vd objectForKey:@"Value"] name:[m name] description:[m description] imageName:[m imageName]]
						forKey:[vd objectForKey:@"Key"]];
		}
		self.AICarnage = temp_vd;
		[temp_vd release];
		
		
		/**
		 ** Points
		 */
		
		// points/time
		NSArray *pot_data = [data objectForKey:@"PointsOverTime"];
		NSMutableArray *temp_pot = [[NSMutableArray alloc] initWithCapacity:[pot_data count]];
		for ( NSArray *pot in pot_data ) {
			NSUInteger time =   [[pot objectAtIndex:0] intValue];
			NSUInteger points = [[pot objectAtIndex:1] intValue];
			RSScoreOverTime *rspot = [RSScoreOverTime scoreOverTimeWithTime:time score:points];
			[temp_pot addObject:rspot];
		}
		self.pointsOverTime = temp_pot;
		[temp_pot release];
		
		// kills/time
		NSMutableArray *temp_kot = [[NSMutableArray alloc] init];
		for ( NSArray *kot in [data objectForKey:@"KillsOverTime"] ) {
			[temp_kot addObject:[RSScoreOverTime scoreOverTimeWithTime:[[kot objectAtIndex:0] intValue] score:[[kot objectAtIndex:1] intValue]]];
		}
		self.killsOverTime = temp_kot;
		[temp_kot release];
		
		// deaths/time
		NSMutableArray *temp_dot = [[NSMutableArray alloc] init];
		for ( NSArray *dot in [data objectForKey:@"DeathsOverTime"] ) {
			[temp_dot addObject:[RSScoreOverTime scoreOverTimeWithTime:[[dot objectAtIndex:0] intValue] score:[[dot objectAtIndex:1] intValue]]];
		}
		self.deathsOverTime = temp_dot;
		[temp_dot release];
		
		// details
		self.assists =	[[data objectForKey:@"Assists"] intValue];
		self.betrayals = [[data objectForKey:@"Betrayals"] intValue];
		self.deaths =	[[data objectForKey:@"Deaths"] intValue];
		self.individualStandingWithNoRegardsForTeams = [[data objectForKey:@"IndividualStandingWithNoRegardForTeams"] intValue];
		self.kills =	[[data objectForKey:@"Kills"] intValue];
		self.rating =	[[data objectForKey:@"Rating"] intValue];
		self.score =	[[data objectForKey:@"Score"] intValue];
		self.standing =	[[data objectForKey:@"Standing"] intValue];
		self.suicides =	[[data objectForKey:@"Suicides"] intValue];
		self.DNF =		[[data objectForKey:@"DNS"] boolValue];
		
		
		/**
		 ** Averages
		 */
		
		self.averageDeathDistanceMeters =	[[data objectForKey:@"AvgDeathDistanceMeters"] intValue];
		self.averageKillDistanceMeters =	[[data objectForKey:@"AvgKillDistanceMeters"] intValue];
		
		
		/**
		 ** Team
		 */
		
		self.team = [[data objectForKey:@"Team"] intValue];
		self.teamScore = [[data objectForKey:@"TeamScore"] intValue];
		
		
		/**
		 ** Medals
		 */
		
		// medals/time
		NSMutableArray *temp_mot = [[NSMutableArray alloc] init];
		for ( NSArray *mot in [data objectForKey:@"MedalsOverTime"] ) {
			[temp_mot addObject:[RSScoreOverTime scoreOverTimeWithTime:[[mot objectAtIndex:0] intValue] score:[[mot objectAtIndex:1] intValue]]];
		}
		self.pointsOverTime = temp_mot;
		[temp_mot release];
		
		// medals counts
		NSMutableDictionary *temp_medal_count = [[NSMutableDictionary alloc] init];
		for ( NSDictionary *m in [data objectForKey:@"SpecificMedalCounts"] ) {
			[temp_medal_count setObject:[m objectForKey:@"Value"] forKey:[m objectForKey:@"Key"]];
		}
		self.medalCounts = temp_medal_count;
		[temp_medal_count release];
		
		// details
		self.multiMedalCount = [[data objectForKey:@"MultiMedalCount"] intValue];
		self.otherMedalCount = [[data objectForKey:@"OtherMedalCount"] intValue];
		self.spreeMedalCount = [[data objectForKey:@"SpreeMedalCount"] intValue];
		self.styleMedalCount = [[data objectForKey:@"StyleMedalCount"] intValue];
		self.totalMedalCount = [[data objectForKey:@"TotalMedalCount"] intValue];
		self.uniqueMultiMedalCount = [[data objectForKey:@"UniqueMultiMedalCount"] intValue];
		self.uniqueOtherMedalCount = [[data objectForKey:@"UniqueOtherMedalCount"] intValue];
		self.uniqueSpreeMedalCount = [[data objectForKey:@"UniqueSpreeMedalCount"] intValue];
		self.uniqueStyleMedalCount = [[data objectForKey:@"UniqueStyleMedalCount"] intValue];
		self.uniqueTotalMedalCount = [[data objectForKey:@"UniqueTotalMedalCount"] intValue];
		
		/**
		 ** Player Details
 		 */
		
        // Details
		self.playerDetail = [[[RSPlayer alloc] initWithAPIData:[data objectForKey:@"PlayerDetail"]] autorelease];
        
        // Most
        self.killedMost = [data objectForKey:@"PlayerKilledMost"];
        self.killedMostCount = [[data objectForKey:@"KilledMostCount"] intValue];
        self.killedByMost = [data objectForKey:@"PlayerKilledByMost"];
        self.killedByMostCount = [[data objectForKey:@"KilledMostByCount"] intValue];
		
		/** 
		 ** Weapons
		 */
		
		// Weapon Carnage Report
		NSDictionary *wmetadata = [RSWeaponMetadataRequest get];
		NSMutableDictionary *temp_wcr = [[NSMutableDictionary alloc] initWithCapacity:[[data objectForKey:@"WeaponCarnageReport"] count]];
		for ( NSDictionary *wc in [data objectForKey:@"WeaponCarnageReport"] ) {
			NSNumber *key = [wc objectForKey:@"WeaponId"];
			RSWeaponMetadata *wm = [wmetadata objectForKey:key];
			RSWeaponCarnage *carnage = [RSWeaponCarnage weaponCarnageWithAPIData:wc
																			name:[wm name]
																	 description:[wm description]];
			[temp_wcr setObject:carnage forKey:key];
		}
		self.weaponCarnage = temp_wcr;
		[temp_wcr release];
		
		// Details
		self.headshots = [[data objectForKey:@"Headshots"] intValue];
	}
	
	return self;
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		
		self.AICarnage = [aDecoder decodeObjectForKey:@"AICarnage"];
		
		self.pointsOverTime =	[aDecoder decodeObjectForKey:@"pointsOverTime"];
		self.killsOverTime =	[aDecoder decodeObjectForKey:@"killsOverTime" ];
		self.deathsOverTime =	[aDecoder decodeObjectForKey:@"deathsOverTime"];
		
		self.assists =		[aDecoder decodeIntForKey:@"assists"];
		self.betrayals =	[aDecoder decodeIntForKey:@"betrayals"];
		self.deaths =		[aDecoder decodeIntForKey:@"deaths"];
		self.individualStandingWithNoRegardsForTeams = [aDecoder decodeIntForKey:@"ISWNRFT"];
		self.kills =		[aDecoder decodeIntForKey:@"kills"];
		self.rating =		[aDecoder decodeIntForKey:@"rating"];
		self.score =		[aDecoder decodeIntForKey:@"score"];
		self.standing =		[aDecoder decodeIntForKey:@"standing"];
		self.suicides =		[aDecoder decodeIntForKey:@"suicides"];
		self.DNF =			[aDecoder decodeBoolForKey:@"DNF"];
		
		self.averageDeathDistanceMeters = [aDecoder decodeIntForKey:@"ADDM"];
		self.averageKillDistanceMeters = [aDecoder decodeIntForKey:@"AKDM"];
		
		self.team = [aDecoder decodeIntForKey:@"team"];
		self.teamScore = [aDecoder decodeIntForKey:@"teamScore"];
		
		self.medalsOverTime =	[aDecoder decodeObjectForKey:@"medalsOverTime"];
		self.medalCounts =		[aDecoder decodeObjectForKey:@"medalCounts"];
		self.multiMedalCount =	[aDecoder decodeIntForKey:@"multiMedalCount"];
		self.otherMedalCount =	[aDecoder decodeIntForKey:@"otherMedalCount"];
		self.spreeMedalCount =	[aDecoder decodeIntForKey:@"spreeMedalCount"];
		self.styleMedalCount =	[aDecoder decodeIntForKey:@"styleMedalCount"];
		self.totalMedalCount =	[aDecoder decodeIntForKey:@"totalMedalCount"];
		self.uniqueMultiMedalCount = [aDecoder decodeIntForKey:@"uniqueMultiMedalCount"];
		self.uniqueOtherMedalCount = [aDecoder decodeIntForKey:@"uniqueOtherMedalCount"];
		self.uniqueSpreeMedalCount = [aDecoder decodeIntForKey:@"uniqueSpreeMedalCount"];
		self.uniqueStyleMedalCount = [aDecoder decodeIntForKey:@"uniqueStyleMedalCount"];
		self.uniqueTotalMedalCount = [aDecoder decodeIntForKey:@"uniqueTotalMedalCount"];
		
		self.playerDetail = [aDecoder decodeObjectForKey:@"playerDetail"];
        self.killedByMost = [aDecoder decodeObjectForKey:@"kBM"];
        self.killedMost = [aDecoder decodeObjectForKey:@"kM"];
        self.killedMostCount = [aDecoder decodeIntForKey:@"kMC"];
        self.killedByMostCount = [aDecoder decodeIntForKey:@"kBMC"];
		
		self.weaponCarnage = [aDecoder decodeObjectForKey:@"weaponCarnage"];
		self.headshots =	 [aDecoder decodeIntForKey:@"headshots"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	
	[aCoder encodeObject:self.AICarnage forKey:@"AICarnage"];
	
	[aCoder encodeObject:self.pointsOverTime forKey:@"pointsOverTime"];
	[aCoder encodeObject:self.killsOverTime  forKey:@"killsOverTime"];
	[aCoder encodeObject:self.deathsOverTime forKey:@"deathsOverTime"];
	
	[aCoder encodeInt:self.assists		forKey:@"assists"];
	[aCoder encodeInt:self.betrayals	forKey:@"betrayals"];
	[aCoder encodeInt:self.deaths		forKey:@"deaths"];
	[aCoder encodeInt:self.individualStandingWithNoRegardsForTeams forKey:@"ISWNRFT"];
	[aCoder encodeInt:self.kills		forKey:@"kills"];
	[aCoder encodeInt:self.rating		forKey:@"rating"];
	[aCoder encodeInt:self.score		forKey:@"score"];
	[aCoder encodeInt:self.standing		forKey:@"standing"];
	[aCoder encodeInt:self.suicides		forKey:@"suicides"];
	[aCoder encodeBool:self.DNF			forKey:@"DNF"];
	
	[aCoder encodeInt:self.averageDeathDistanceMeters	forKey:@"ADDM"];
	[aCoder encodeInt:self.averageKillDistanceMeters	forKey:@"AKDM"];
	
	[aCoder encodeInt:self.team forKey:@"team"];
	[aCoder encodeInt:self.teamScore forKey:@"teamScore"];
	
	[aCoder encodeObject:self.medalsOverTime	 forKey:@"medalsOverTime"];
	[aCoder encodeObject:self.medalCounts		 forKey:@"medalCounts"];
	[aCoder encodeInt:self.multiMedalCount		 forKey:@"multiMedalCount"];
	[aCoder encodeInt:self.otherMedalCount		 forKey:@"otherMedalCount"];
	[aCoder encodeInt:self.spreeMedalCount		 forKey:@"spreeMedalCount"];
	[aCoder encodeInt:self.styleMedalCount		 forKey:@"styleMedalCount"];
	[aCoder encodeInt:self.totalMedalCount		 forKey:@"totalMedalCount"];
	[aCoder encodeInt:self.uniqueMultiMedalCount forKey:@"uniqueMultiMedalCount"];
	[aCoder encodeInt:self.uniqueOtherMedalCount forKey:@"uniqueOtherMedalCount"];
	[aCoder encodeInt:self.uniqueSpreeMedalCount forKey:@"uniqueSpreeMedalCount"];
	[aCoder encodeInt:self.uniqueStyleMedalCount forKey:@"uniqueStyleMedalCount"];
	[aCoder encodeInt:self.uniqueTotalMedalCount forKey:@"uniqueTotalMedalCount"];
	
	[aCoder encodeObject:self.playerDetail  forKey:@"playerDetail"];
    [aCoder encodeObject:self.killedMost    forKey:@"kM"];
    [aCoder encodeObject:self.killedByMost  forKey:@"kBM"];
    [aCoder encodeInt:self.killedMostCount  forKey:@"kMC"];
    [aCoder encodeInt:self.killedByMostCount forKey:@"kBMC"];
	
	[aCoder encodeObject:self.weaponCarnage	forKey:@"weaponCarnage"];
	[aCoder encodeInt:self.headshots		forKey:@"headshots"];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.AICarnage release];
	[self.pointsOverTime release];
	[self.killsOverTime release];
	[self.deathsOverTime release];
	[self.medalsOverTime release];
	[self.medalCounts release];
	[self.weaponCarnage release];
    [self.killedMost release];
    [self.killedByMost release];
	self.playerDetail = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Weapon Carnage
- (RSWeaponCarnage *)carnageForWeaponID:(NSUInteger)ID {
	return [self.weaponCarnage objectForKey:[NSNumber numberWithInt:ID]];
}

#pragma mark -
#pragma mark AI/Vehicle Carnage
- (RSAICarnage *)carnageForVehicleID:(NSUInteger)vehicleID {
	return [self.AICarnage objectForKey:[NSNumber numberWithInt:vehicleID]];
}

- (RSAICarnage *)carnageForEnemyID:(NSUInteger)enemyID {
	return [self.AICarnage objectForKey:[NSNumber numberWithInt:enemyID]];
}

@end
