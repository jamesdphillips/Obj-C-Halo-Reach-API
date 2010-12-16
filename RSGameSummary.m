//
//  RSGameSummary.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-12.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameSummary.h"
#import "ReachStatsService.h"


@implementation RSGameSummary

@synthesize ID;
@synthesize campaignDifficulty, campaignGlobalScore, campaignMetagameEnabled;
@synthesize duration, timestamp;
@synthesize variant, variantIconID, variantName;
@synthesize isTeamGame;
@synthesize baseMapName;
@synthesize playerCount;
@synthesize playlistName;
@synthesize requestedPlayerGamertag, requestedPlayerAssists, requestedPlayerKills, requestedPlayerDeaths, requestedPlayerRating, requestedPlayerStanding, requestedPlayerScore;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data gamertag:(NSString *)gamertag {
	
	if ( self = [super init] ) {
		
		// ID
		self.ID = [[data objectForKey:@"GameId"] intValue];
		
		// Campaign
		self.campaignDifficulty = [data objectForKey:@"CampaignDifficulty"];
		self.campaignGlobalScore = [data objectForKey:@"CampaignGlobalScore"];
		self.campaignMetagameEnabled = [[data objectForKey:@"CampaignMetagameEnabled"] boolValue];
		
		// Time
		self.duration = [[data objectForKey:@"GameDuration"] intValue];
		self.timestamp = [data objectForKey:@"GameTimestamp"];
		
		// Variant
		self.variant = [[data objectForKey:@"GameVariantClass"] intValue];
		self.variantIconID = [[data objectForKey:@"GameVariantIconIndex"] intValue];
		self.variantName = [data objectForKey:@"GameVariantName"];
		
		// Team
		self.isTeamGame = [[data objectForKey:@"IsTeamGame"] boolValue];
		
		// Map
		self.baseMapName = [data objectForKey:@"MapName"];
		
		// Players
		self.playerCount = [[data objectForKey:@"PlayerCount"] intValue];
		
		// Playlist
		self.playlistName = [data objectForKey:@"PlaylistName"];
		
		// Requested Player
		self.requestedPlayerGamertag = gamertag;
		self.requestedPlayerAssists	= [[data objectForKey:@"RequestedPlayerAssists"] intValue];
		self.requestedPlayerKills	= [[data objectForKey:@"RequestedPlayerKills"] intValue];
		self.requestedPlayerDeaths	= [[data objectForKey:@"RequestedPlayerDeaths"] intValue];
		self.requestedPlayerRating	= [[data objectForKey:@"RequestedPlayerRating"] intValue];
		self.requestedPlayerScore	= [[data objectForKey:@"RequestedPlayerScore"] intValue];
		self.requestedPlayerStanding = [[data objectForKey:@"RequestedPlayerStanding"] intValue];
	}
	
	return self;
}

- (id)initWithAPIData:(NSDictionary *)data {
	return [self initWithAPIData:data gamertag:nil];
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		
		self.ID = [aDecoder decodeIntForKey:@"ID"];
		
		self.campaignDifficulty =	[aDecoder decodeObjectForKey:@"campaignDifficulty"];
		self.campaignGlobalScore =	[aDecoder decodeObjectForKey:@"campaignGlobalScore"];
		self.campaignMetagameEnabled = [aDecoder decodeBoolForKey:@"campaignMetagameEnabled"];
		
		self.duration =  [aDecoder decodeIntForKey:@"duration"];
		self.timestamp = [aDecoder decodeObjectForKey:@"timestamp"];
		
		self.variant = [aDecoder decodeIntForKey:@"variant"];
		self.variantIconID = [aDecoder decodeIntForKey:@"variantIconID"];
		self.variantName = [aDecoder decodeObjectForKey:@"variantName"];
		
		self.isTeamGame =	[aDecoder decodeBoolForKey:@"isTeamGame"];
		self.baseMapName =	[aDecoder decodeObjectForKey:@"baseMapName"];
		self.playerCount =	[aDecoder decodeIntForKey:@"playerCount"];
		self.playlistName =	[aDecoder decodeObjectForKey:@"playlistName"];
		
		self.requestedPlayerGamertag =	[aDecoder decodeObjectForKey:@"requestedPlayerGamertag"];
		self.requestedPlayerAssists =	[aDecoder decodeIntForKey:@"requestedPlayerAssists"];
		self.requestedPlayerKills =		[aDecoder decodeIntForKey:@"requestedPlayerKills"];
		self.requestedPlayerDeaths =	[aDecoder decodeIntForKey:@"requestedPlayerDeaths"];
		self.requestedPlayerRating =	[aDecoder decodeIntForKey:@"requestedPlayerRating"];
		self.requestedPlayerStanding =	[aDecoder decodeIntForKey:@"requestedPlayerStanding"];
		self.requestedPlayerScore =		[aDecoder decodeIntForKey:@"requestedPlayerScore"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	
	[aCoder encodeInt:self.ID forKey:@"ID"];
	
	[aCoder encodeObject:self.campaignDifficulty	forKey:@"campaignDifficulty"];
	[aCoder encodeObject:self.campaignGlobalScore	forKey:@"campaignGlobalScore"];
	[aCoder encodeBool:self.campaignMetagameEnabled	forKey:@"campaignMetagameEnabled"];
	
	[aCoder encodeInt:self.duration		forKey:@"duration" ];
	[aCoder encodeObject:self.timestamp	forKey:@"timestamp"];
	
	[aCoder encodeInt:self.variant forKey:@"variant"];
	[aCoder encodeInt:self.variantIconID forKey:@"variantIconID"];
	[aCoder encodeObject:self.variantName forKey:@"variantName"];
	
	[aCoder encodeBool:self.isTeamGame forKey:@"isTeamGame"];
	[aCoder encodeObject:self.baseMapName forKey:@"baseMapName"];
	[aCoder encodeInt:self.playerCount forKey:@"playerCount"];
	[aCoder encodeObject:self.playlistName forKey:@"playlistName"];
	
	[aCoder encodeObject:self.requestedPlayerGamertag forKey:@"requestedPlayerGamertag"];
	[aCoder encodeInt:self.requestedPlayerAssists forKey:@"requestedPlayerAssists"];
	[aCoder encodeInt:self.requestedPlayerKills forKey:@"requestedPlayerKills"];
	[aCoder encodeInt:self.requestedPlayerDeaths forKey:@"requestedPlayerDeaths"];
	[aCoder encodeInt:self.requestedPlayerRating forKey:@"requestedPlayerRating"];
	[aCoder encodeInt:self.requestedPlayerStanding forKey:@"requestedPlayerStanding"];
	[aCoder encodeInt:self.requestedPlayerScore forKey:@"requestedPlayerScore"];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.campaignDifficulty release];
	[self.campaignGlobalScore release];
	[self.timestamp release];
	[self.variantName release];
	[self.baseMapName release];
	[self.playlistName release];
	[self.requestedPlayerGamertag release];
	[super dealloc];
}


#pragma mark -
#pragma mark Map Image
- (NSURL *)mapImageWithSize:(NSString*)size {
	NSString *mn = [[self.baseMapName stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
	switch (self.variant) {
		case 1:
		case 2:
		case 3:
			return [NSURL URLWithString:[NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/mp_%@.jpg",size,mn]];
		case 4:
			return [NSURL URLWithString:[NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/cp_%@.jpg",size,mn]];
		case 5:
			return [NSURL URLWithString:[NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/ff_%@.jpg",size,mn]];
		default:
			return [NSURL URLWithString:[NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/cp_spoiler.jpg",size]];
	}
	return nil; // ...
}

- (NSURL *)mapImage {
	return [self mapImageWithSize:@"thumbs"];
}

#pragma mark -
#pragma mark timestamp
- (NSDate*)gameDate {
	return [ReachStatsService formatBungieDate:self.timestamp];
}

@end
