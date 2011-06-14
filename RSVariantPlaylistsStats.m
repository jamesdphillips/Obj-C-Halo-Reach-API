//
//  RSVariantPlaylistsStats.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-26.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSVariantPlaylistsStats.h"


@implementation RSVariantPlaylistsStats

@synthesize variantID, playlistStats;
@synthesize medals,gamesPlayed,assists,betrayals,deaths,firstPlace,kills,playtime,score,placedTopHalf,placedTopThird,wins;

- (id)initWithVariantID:(NSUInteger)ID playlist:(RSPlaylistStats*)playlist  {
	if ( (self = [self initWithVariantID:ID]) ) {
		//[self setVariantID:ID];
		[self addPlaylist:playlist];
	}
	return self;
}

- (id)initWithPlaylist:(RSPlaylistStats*)playlist {
	if ( (self = [self initWithVariantID:playlist.variantID]) ) {
		//[self setVariantID:playlist.hopperID];
		[self addPlaylist:playlist];
	}
	return self;
}

- (id)initWithVariantID:(NSUInteger)ID {
	if ( (self = [super init]) ) {
		self.variantID = ID;
		self.playlistStats = [NSMutableDictionary dictionary];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.variantID = [aDecoder decodeIntForKey:@"vID"];
		self.playlistStats = [aDecoder decodeObjectForKey:@"pStats"];
		self.medals = [aDecoder decodeIntForKey:@"m"];
		self.gamesPlayed = [aDecoder decodeIntForKey:@"gP"];
		self.assists = [aDecoder decodeIntForKey:@"a"];
		self.betrayals = [aDecoder decodeIntForKey:@"b"];
		self.deaths = [aDecoder decodeIntForKey:@"d"];
		self.firstPlace = [aDecoder decodeIntForKey:@"fP"];
		self.kills = [aDecoder decodeIntForKey:@"k"];
		self.playtime = [aDecoder decodeIntForKey:@"p"];
		self.score = [aDecoder decodeIntForKey:@"s"];
		self.placedTopHalf = [aDecoder decodeIntForKey:@"pTH"];
		self.placedTopThird = [aDecoder decodeIntForKey:@"pTT"];
		self.wins = [aDecoder decodeIntForKey:@"w"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.playlistStats forKey:@"pStats"];
	[aCoder encodeInt:self.variantID forKey:@"vID"];
	[aCoder encodeInt:self.medals forKey:@"m"];
	[aCoder encodeInt:self.gamesPlayed forKey:@"gP"];
	[aCoder encodeInt:self.assists forKey:@"a"];
	[aCoder encodeInt:self.betrayals forKey:@"b"];
	[aCoder encodeInt:self.deaths forKey:@"d"];
	[aCoder encodeInt:self.firstPlace forKey:@"fP"];
	[aCoder encodeInt:self.kills forKey:@"k"];
	[aCoder encodeInt:self.playtime forKey:@"p"];
	[aCoder encodeInt:self.score forKey:@"s"];
	[aCoder encodeInt:self.placedTopThird forKey:@"pTT"];
	[aCoder encodeInt:self.placedTopHalf forKey:@"pTH"];
	[aCoder encodeInt:self.wins forKey:@"w"];
}

- (void)addPlaylist:(RSPlaylistStats*)playlist {
	self.medals += playlist.totalMedals;
	self.gamesPlayed += playlist.gameCount;
	self.assists += playlist.assists;
	self.betrayals += playlist.betrayals;
	self.deaths += playlist.deaths;
	self.firstPlace += playlist.firstPlace;
	self.kills += playlist.kills;
	self.playtime += playlist.playtime;
	self.score += playlist.score;
	self.placedTopHalf += playlist.placedTopHalf;
	self.placedTopThird += playlist.placedTopThird;
	self.wins += playlist.wins;
	[self.playlistStats setObject:playlist forKey:[NSNumber numberWithInt:playlist.hopperID]];
}

- (void)dealloc {
	self.playlistStats = nil;
	[super dealloc];
}

@end
