//
//  RSPlayerDetails.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayer.h"
#import "ReachStatsService.h"
#import "RSCommendationMetadataRequest.h"


@implementation RSPlayer

@synthesize gamertag;
@synthesize singlePlayerProgress, coopProgress;
@synthesize initialized, isGuest;
@synthesize emblemData;
@synthesize lastVariantPlayed;
@synthesize armoryCompletion, commendationCompletion, dailyChallengesCompleted, weeklyChallengesCompleted;
@synthesize gamesPlayed, firstPlayed, lastPlayed, firstPlayedDate, lastPlayedDate;
@synthesize serviceTag;
@synthesize commendations;

- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( self = [super init] ) {
		
		// Gamertag
		self.gamertag = [data objectForKey:@"gamertag"];
		
		// Progress
		self.singlePlayerProgress = [self campaignProgressWithAPIString:[data objectForKey:@"CampaignProgressSp"]];
		self.coopProgress = [self campaignProgressWithAPIString:[data objectForKey:@"CampaignProgressCoop"]];
		
		// Type
		self.initialized = [[data objectForKey:@"Initialized"] boolValue];
		self.isGuest = [[data objectForKey:@"IsGuest"] boolValue];
		
		// Emblem
		self.emblemData = [data objectForKey:@"ReachEmblem"];
		
		// Lastest
		self.lastVariantPlayed = [data objectForKey:@"LastGameVariantClassPlayed"];
		
		// Completion
		self.armoryCompletion = [[data objectForKey:@"armor_completion_percentage"] floatValue];
		self.commendationCompletion = [[data objectForKey:@"commendation_completion_percentage"] floatValue];
		self.dailyChallengesCompleted = [[data objectForKey:@"daily_challenges_completed"] intValue];
		self.weeklyChallengesCompleted = [[data objectForKey:@"weekly_challenges_completed"] intValue];
		
		// Activity
		self.gamesPlayed = [[data objectForKey:@"games_total"] intValue];
		self.firstPlayed = [data objectForKey:@"first_active"];
		self.lastPlayed = [data objectForKey:@"last_active"];
		
		// Service Tag
		self.serviceTag = [data objectForKey:@"service_tag"];
		
		// Commendations
		NSArray *comState = [data objectForKey:@"CommendationState"];
		NSMutableDictionary *cDict = [[NSMutableDictionary alloc] initWithCapacity:[comState count]];
		NSDictionary *metadata = [RSCommendationMetadataRequest get];
		for ( NSDictionary *c in comState ) {
			NSNumber *key = [c objectForKey:@"Key"];
			RSCommendation *val = [[[RSCommendation alloc] initWithAPIData:c metadata:[metadata objectForKey:key]] autorelease];
			[cDict setObject:val forKey:[key stringValue]];
		}
		self.commendations = cDict;
		[cDict release];
	}
	
	return self;
}

- (id)initWithDictionary:(NSDictionary*)data {
	if ( self = [super init] ) {
		self.gamertag = [data objectForKey:@"gamertag"];
		self.singlePlayerProgress = [[data objectForKey:@"soloProgress"] intValue];
		self.coopProgress = [[data objectForKey:@"coopProgress"] intValue];
		self.initialized = [[data objectForKey:@"initialized"] boolValue];
		self.isGuest = [[data objectForKey:@"isGuest"] boolValue];
		self.emblemData = [data objectForKey:@"emblemData"];
		self.lastVariantPlayed = [data objectForKey:@"lastVariantPlayed"];
		self.armoryCompletion = [[data objectForKey:@"armoryCompletion"] floatValue];
		self.commendationCompletion = [[data objectForKey:@"commmendationProgress"] floatValue];
		self.dailyChallengesCompleted = [[data objectForKey:@"dailyChallengesCompleted"] intValue];
		self.weeklyChallengesCompleted = [[data objectForKey:@"weeklyChallengesCompleted"] intValue];
		self.gamesPlayed = [[data objectForKey:@"gamesPlayed"] intValue];
		self.firstPlayed = [data objectForKey:@"firstPlayed"];
		self.lastPlayed = [data objectForKey:@"lastPlayed"];
		self.serviceTag = [data objectForKey:@"service_tag"];
		self.commendations = [data objectForKey:@"commendations"];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.gamertag = [aDecoder decodeObjectForKey:@"g"];
		self.singlePlayerProgress = [aDecoder decodeIntForKey:@"sPP"];
		self.coopProgress = [aDecoder decodeIntForKey:@"cP"];
		self.initialized = [aDecoder decodeBoolForKey:@"i"];
		self.isGuest = [aDecoder decodeBoolForKey:@"iG"];
		self.emblemData = [aDecoder decodeObjectForKey:@"eD"];
		self.lastVariantPlayed = [aDecoder decodeObjectForKey:@"lVP"];
		self.armoryCompletion = [aDecoder decodeFloatForKey:@"aC"];
		self.commendationCompletion = [aDecoder decodeFloatForKey:@"cC"];
		self.dailyChallengesCompleted = [aDecoder decodeIntForKey:@"dCC"];
		self.weeklyChallengesCompleted = [aDecoder decodeIntForKey:@"wCC"];
		self.serviceTag = [aDecoder decodeObjectForKey:@"sT"];
		self.gamesPlayed = [aDecoder decodeIntForKey:@"gP"];
		self.firstPlayed = [aDecoder decodeObjectForKey:@"fP"];
		self.lastPlayed = [aDecoder decodeObjectForKey:@"lP"];
		self.commendations = [aDecoder decodeObjectForKey:@"c"];
	}
	return self;
}

+ (RSPlayer*)playerWithAPIData:(NSDictionary*)data {
	return [[[RSPlayer alloc] initWithAPIData:data] autorelease];
}
+ (RSPlayer*)playerWithDictionary:(NSDictionary*)data {
	return [[[RSPlayer alloc] initWithDictionary:data] autorelease];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.gamertag forKey:@"g"];
	[aCoder encodeInt:self.singlePlayerProgress forKey:@"sPP"];
	[aCoder encodeInt:self.coopProgress forKey:@"cP"];
	[aCoder encodeBool:self.initialized forKey:@"i"];
	[aCoder encodeBool:self.isGuest forKey:@"iG"];
	[aCoder encodeObject:self.emblemData forKey:@"eD"];
	[aCoder encodeObject:self.lastVariantPlayed forKey:@"lVP"];
	[aCoder encodeFloat:self.armoryCompletion forKey:@"aC"];
	[aCoder encodeFloat:self.commendationCompletion forKey:@"cC"];
	[aCoder encodeInt:self.dailyChallengesCompleted forKey:@"dCC"];
	[aCoder encodeInt:self.weeklyChallengesCompleted forKey:@"wCC"];
	[aCoder encodeObject:self.serviceTag forKey:@"sT"];
	[aCoder encodeInt:self.gamesPlayed forKey:@"gP"];
	[aCoder encodeObject:self.firstPlayed forKey:@"fP"];
	[aCoder encodeObject:self.lastPlayed forKey:@"lP"];
	[aCoder encodeObject:self.commendations forKey:@"c"];
}

- (NSDictionary*)serialize {
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSString stringWithString:self.gamertag], @"gamertag",
			[NSNumber numberWithInt:self.singlePlayerProgress], @"soloProgress",
			[NSNumber numberWithInt:self.coopProgress], @"coopProgress",
			[NSNumber numberWithBool:self.initialized], @"initialized",
			[NSNumber numberWithBool:self.isGuest], @"isGuest",
			[NSDictionary dictionaryWithDictionary:self.emblemData], @"emblemData",
			[NSString stringWithString:self.lastVariantPlayed], @"lastVariantPlayed",
			[NSNumber numberWithFloat:self.armoryCompletion], @"armoryCompletion",
			[NSNumber numberWithFloat:self.commendationCompletion], @"commmendationProgress",
			[NSNumber numberWithInt:self.dailyChallengesCompleted], @"dailyChallengesCompleted",
			[NSNumber numberWithInt:self.weeklyChallengesCompleted], @"weeklyChallengesCompleted",
			[NSNumber numberWithInt:self.gamesPlayed], @"gamesPlayed",
			[NSString stringWithString:self.firstPlayed], @"firstPlayed",
			[NSString stringWithString:self.lastPlayed], @"lastPlayed",
			[NSString stringWithString:self.serviceTag], @"service_tag",
			//[NSDictionary dictionaryWithDictionary:[self serializeCommendations]], @"commendations",
			nil
			];
}

- (NSString *)campaignProgressStringWithProgress:(CampaignProgressState)progress {
	switch (progress) {
		case CampaignProgressEasyPartial:
			return @"Easy (partial)";
		case CampaignProgressEasyComplete:
			return @"Easy";
		case CampaignProgressNormalPartial:
			return @"Normal (partial)";
		case CampaignProgressNormalComplete:
			return @"Normal";
		case CampaignProgressHeroicPartial:
			return @"Heroic (partial)";
		case CampaignProgressHeroicComplete:
			return @"Heroic";
		case CampaignProgressLegendaryPartial:
			return @"Legendary (partial)";
		case CampaignProgressLegendaryComplete:
			return @"Legendary";
		default:
			return @"None";
	}
	return @"None";
}

- (NSString *)singlePlayerProgressString {
	return [self campaignProgressStringWithProgress:self.singlePlayerProgress];
}

- (NSString *)coopProgressString {
	return [self campaignProgressStringWithProgress:self.coopProgress];
}

- (CampaignProgressState)campaignProgressWithAPIString:(NSString *)apiString {
	
	if ( [apiString isEqualToString:@"None"] )
		return CampaignProgressNone;
	else if ( [apiString isEqualToString:@"PartialLegendary"] )
		return CampaignProgressLegendaryPartial;
	else if ( [apiString isEqualToString:@"CompletedLegendary"] )
		return CampaignProgressLegendaryComplete;
	else if ( [apiString isEqualToString:@"PartialHeroic"] )
		return CampaignProgressHeroicPartial;
	else if ( [apiString isEqualToString:@"CompletedHeroic"] )
		return CampaignProgressHeroicComplete;
	else if ( [apiString isEqualToString:@"PartialNormal"] )
		return CampaignProgressNormalPartial;
	else if ( [apiString isEqualToString:@"CompletedNormal"] )
		return CampaignProgressNormalComplete;
	else if ( [apiString isEqualToString:@"PartialEasy"] )
		return CampaignProgressEasyPartial;
	else if ( [apiString isEqualToString:@"CompletedEasy"] )
		return CampaignProgressEasyComplete;
	return CampaignProgressNone;
}

- (NSURL *)campaignProgressImageURL:(CampaignProgressState)progress {
	switch (progress) {
		case CampaignProgressEasyComplete:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/easy.png"];
		case CampaignProgressNormalPartial:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/partial_normal.png"];
		case CampaignProgressNormalComplete:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/normal.png"];
		case CampaignProgressHeroicPartial:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/partial_heroic.png"];
		case CampaignProgressHeroicComplete:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/heroic.png"];
		case CampaignProgressLegendaryPartial:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/partial_legendary.png"];
		case CampaignProgressLegendaryComplete:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/legendary.png"];
		default:
			return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/none.png"];
	}
	return [NSURL URLWithString:@"http://www.bungie.net/images/reachstats/campaign_progress/none.png"];
}

- (NSURL *)soloCampaignProgressImageURL {
	return [self campaignProgressImageURL:self.singlePlayerProgress];
}

- (NSURL *)coopCampaignProgressImageURL {
	return [self campaignProgressImageURL:self.coopProgress];
}

- (NSURL *)emblemURLWithSize:(NSUInteger)size {
	
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net/Stats/emblem.ashx?s=%d&0=%d&1=%d&2=%d&3=%d&fi=%d&bi=%d&fl=%d&m=3",
								 size,
								 [[[self.emblemData objectForKey:@"change_colors"] objectAtIndex:0] intValue],
								 [[[self.emblemData objectForKey:@"change_colors"] objectAtIndex:1] intValue],
								 [[[self.emblemData objectForKey:@"change_colors"] objectAtIndex:2] intValue],
								 [[[self.emblemData objectForKey:@"change_colors"] objectAtIndex:3] intValue],
								 [[self.emblemData objectForKey:@"foreground_index"] intValue],
								 [[self.emblemData objectForKey:@"background_index"] intValue],
								 ([[self.emblemData objectForKey:@"flags"] intValue] == 1 ? 0 : 1)]];
}

- (NSURL *)emblemURL {
	return [self emblemURLWithSize:120];
}

- (NSDate*)firstPlayedDate {
	if (!firstPlayedDate) {
		firstPlayedDate = [[ReachStatsService formatBungieDate:self.firstPlayed] retain];
	}
	return firstPlayedDate;
}

- (NSDate*)lastPlayedDate {
	if (!lastPlayedDate) {
		lastPlayedDate = [[ReachStatsService formatBungieDate:self.lastPlayed] retain];
	}
	return lastPlayedDate;
}

- (NSString*)firstPlayedString {
	NSDate *date = [self firstPlayedDate];
	return [ReachStatsService defaultFormatDate:date];
}

- (NSString*)lastPlayedString {
	NSDate *date = [self lastPlayedDate];
	return [ReachStatsService defaultFormatDate:date];
}

- (NSDictionary*)serializeCommendations {
	NSMutableDictionary *comm = [NSMutableDictionary dictionaryWithCapacity:[self.commendations count]];
	for ( RSCommendation *c in [self.commendations allValues] ) {
		NSString *key = [[NSNumber numberWithInt:[c ID]] stringValue];
		NSNumber *value = [NSNumber numberWithInt:[c total]];
		[comm setObject:value forKey:key];
	}
	return comm;
}

- (NSArray*)commendationsWithGametype:(NSString*)gametype {
	NSMutableArray *sortedCommendations = [NSMutableArray array];
	for ( RSCommendation *comm in self.commendations ) {
		if ( [[[comm gametype] lowercaseString] isEqualToString:[gametype lowercaseString]] )
			[sortedCommendations addObject:comm];
	}
	return sortedCommendations;
}

- (void)dealloc {
	[self.gamertag release];
	[self.emblemData release];
	[self.lastVariantPlayed release];
	[self.firstPlayed release];
	[self.lastPlayed release];
	[self.commendations release];
	[self.serviceTag release];
	self.firstPlayedDate = nil;
	self.lastPlayedDate = nil;
	[super dealloc];
}

@end
