//
//  RSSeasonStats.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-23.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSSeasonStats.h"


@implementation RSSeasonStats

@synthesize currentDailyRating;
@synthesize division;
@synthesize divisionPercentile;
@synthesize gamesPlayed;
@synthesize playlistSystemName;
@synthesize qualifyingDays;
@synthesize requiredDailyGames;
@synthesize requiredDays;
@synthesize seasonID;

- (id)initWithAPIData:(NSDictionary*)data {
	if ( (self = [super init]) ) {
		
		self.currentDailyRating = [[data objectForKey:@"current_daily_rating"] intValue];
		self.division = [[data objectForKey:@"division"] intValue];
		if ( ![[data objectForKey:@"division_percentile"] isKindOfClass:[NSNull class]] )
			self.divisionPercentile = [[data objectForKey:@"division_percentile"] floatValue];
		self.gamesPlayed = [[data objectForKey:@"game_count"] intValue];
		if ( ![[data objectForKey:@"playlist_system_name"] isKindOfClass:[NSNull class]] )
			self.playlistSystemName = [data objectForKey:@"playlist_system_name"];
		self.qualifyingDays = [[data objectForKey:@"qualifying_days"] intValue];
		self.requiredDailyGames = [[data objectForKey:@"required_daily_games"] intValue];
		self.requiredDays = [[data objectForKey:@"required_days"] intValue];
		self.seasonID = [[data objectForKey:@"seasonID"] intValue];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.currentDailyRating = [aDecoder decodeIntForKey:@"cDR"];
		self.division = [aDecoder decodeIntForKey:@"d"];
		self.divisionPercentile = [aDecoder decodeFloatForKey:@"dP"];
		self.gamesPlayed = [aDecoder decodeIntForKey:@"gP"];
		self.playlistSystemName = [aDecoder decodeObjectForKey:@"pSN"];
		self.qualifyingDays = [aDecoder decodeIntForKey:@"qD"];
		self.requiredDays = [aDecoder decodeIntForKey:@"rD"];
		self.requiredDailyGames = [aDecoder decodeIntForKey:@"rDG"];
		self.seasonID = [aDecoder decodeIntForKey:@"sID"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.currentDailyRating forKey:@"cDR"];
	[aCoder encodeInt:self.division forKey:@"d"];
	[aCoder encodeFloat:self.divisionPercentile forKey:@"dP"];
	[aCoder encodeInt:self.gamesPlayed forKey:@"gP"];
	[aCoder encodeObject:self.playlistSystemName forKey:@"pSN"];
	[aCoder encodeInt:self.qualifyingDays forKey:@"qD"];
	[aCoder encodeInt:self.requiredDays forKey:@"rD"];
	[aCoder encodeInt:self.requiredDailyGames forKey:@"rDG"];
	[aCoder encodeInt:self.seasonID forKey:@"sID"];
}

- (void)dealloc {
	[self.playlistSystemName release];
	[super dealloc];
}

@end
