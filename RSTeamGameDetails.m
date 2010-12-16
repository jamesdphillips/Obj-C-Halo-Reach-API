//
//  RSTeamGameDetails.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSTeamGameDetails.h"
#import "RSScoreOverTime.h"


@implementation RSTeamGameDetails

@synthesize ID;
@synthesize deathsOverTime, killsOverTime, medalsOverTime, score, standing, metagameScore;
@synthesize assists, betrayals, deaths, kills, medals, suicides;
@synthesize exists;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( self = [super init] ) {
		
		
		/** 
		 ** ID
		 */
		
		self.ID = [[data objectForKey:@"Index"] intValue];
		
		
		/**
		 ** Score
		 */
		
		// Deaths/Time
		NSArray *dot = [data objectForKey:@"DeathsOverTime"];
		NSMutableArray *temp_dot = [[NSMutableArray alloc] initWithCapacity:[dot count]];
		for ( NSArray *death in dot ) {
			[temp_dot addObject:[RSScoreOverTime scoreOverTimeWithTime:[[death objectAtIndex:0] intValue]
																 score:[[death objectAtIndex:1] intValue]]];
		}
		self.deathsOverTime = temp_dot;
		[temp_dot release];
		
		// Kills/Time
		NSArray *kot = [data objectForKey:@"KillsOverTime"];
		NSMutableArray *temp_kot = [[NSMutableArray alloc] initWithCapacity:[kot count]];
		for ( NSArray *kill in kot ) {
			[temp_kot addObject:[RSScoreOverTime scoreOverTimeWithTime:[[kill objectAtIndex:0] intValue]
																 score:[[kill objectAtIndex:1] intValue]]];
		}
		self.killsOverTime = temp_kot;
		[temp_kot release];
		
		// Medals/Time
		NSArray *mot = [data objectForKey:@"MedalsOverTime"];
		NSMutableArray *temp_mot = [[NSMutableArray alloc] initWithCapacity:[mot count]];
		for ( NSArray *medal in mot ) {
			[temp_mot addObject:[RSScoreOverTime scoreOverTimeWithTime:[[medal objectAtIndex:0] intValue]
																 score:[[medal objectAtIndex:1] intValue]]];
		}
		self.medalsOverTime = temp_mot;
		[temp_mot release];
		
		// Details
		self.score = [[data objectForKey:@"Score"] intValue];
		self.standing = [[data objectForKey:@"Standing"] intValue];
		self.metagameScore = [[data objectForKey:@"MetagameScore"] intValue];
		
		
		/** 
		 ** Totals
		 */
		
		self.assists =	[[data objectForKey:@"TeamTotalAssists"] intValue];
		self.betrayals = [[data objectForKey:@"TeamTotalBetrayals"] intValue];
		self.deaths =	[[data objectForKey:@"TeamTotalDeaths"] intValue];
		self.kills =	[[data objectForKey:@"TeamTotalKills"] intValue];
		self.medals =	[[data objectForKey:@"TeamTotalMedals"] intValue];
		self.suicides =	[[data objectForKey:@"TeamTotalSuicides"] intValue];
		
		
		/**
		 ** ..?
		 */
		
		self.exists = [[data objectForKey:@"Exists"] boolValue];
	}
	
	return self;
}

+ (RSTeamGameDetails *)teamDetailsWithAPIData:(NSDictionary *)data {
	return [[[RSTeamGameDetails alloc] initWithAPIData:data] autorelease];
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.deathsOverTime = [aDecoder decodeObjectForKey:@"dOT"];
		self.killsOverTime = [aDecoder decodeObjectForKey:@"kOT"];
		self.medalsOverTime = [aDecoder decodeObjectForKey:@"mOT"];
		self.score = [aDecoder decodeIntForKey:@"s"];
		self.standing = [aDecoder decodeIntForKey:@"st"];
		self.metagameScore = [aDecoder decodeIntForKey:@"mS"];
		self.assists = [aDecoder decodeIntForKey:@"a"];
		self.betrayals = [aDecoder decodeIntForKey:@"b"];
		self.deaths = [aDecoder decodeIntForKey:@"d"];
		self.kills = [aDecoder decodeIntForKey:@"k"];
		self.medals = [aDecoder decodeIntForKey:@"m"];
		self.suicides = [aDecoder decodeIntForKey:@"su"];
		self.exists = [aDecoder decodeBoolForKey:@"e"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.ID forKey:@"I"];
	[aCoder encodeObject:self.deathsOverTime forKey:@"dOT"];
	[aCoder encodeObject:self.killsOverTime forKey:@"kOT"];
	[aCoder encodeObject:self.medalsOverTime forKey:@"mOT"];
	[aCoder encodeInt:self.score forKey:@"s"];
	[aCoder encodeInt:self.standing forKey:@"st"];
	[aCoder encodeInt:self.metagameScore forKey:@"mS"];
	[aCoder encodeInt:self.assists forKey:@"a"];
	[aCoder encodeInt:self.betrayals forKey:@"b"];
	[aCoder encodeInt:self.deaths forKey:@"d"];
	[aCoder encodeInt:self.kills forKey:@"k"];
	[aCoder encodeInt:self.medals forKey:@"m"];
	[aCoder encodeInt:self.suicides forKey:@"su"];
	[aCoder encodeBool:self.exists forKey:@"e"];
}


#pragma mark -
#pragma mark Colours
- (NSString *)colourString {
	switch (self.ID) {
		case RSTeamColourBlue:
			return @"Blue";
		case RSTeamColourRed:
			return @"Red";
		case RSTeamColourGreen:
			return @"Green";
		case RSTeamColourOrange:
			return @"Orange";
		case RSTeamColourPurple:
			return @"Purple";
		case RSTeamColourBrown:
			return @"Brown";
		case RSTeamColourGold:
			return @"Gold";
		case RSTeamColourPink:
			return @"Pink";
		default:
			return @"Unkown";
	}
	return @"Unknown";
}

- (UIColor *)colour {
	switch (self.ID) {
		case RSTeamColourBlue:
			return [UIColor colorWithCGColor:RGBCOLOR(6,36,69).CGColor];
		case RSTeamColourRed:
			return [UIColor redColor];
		case RSTeamColourOrange:
			return RGBCOLOR(206,143,29);
		case RSTeamColourPink:
			return RGBCOLOR(255,186,226);
		case RSTeamColourPurple:
			return [UIColor purpleColor];
		case RSTeamColourGreen:
			return [UIColor greenColor];
		case RSTeamColourBrown:
			return [UIColor brownColor];
		case RSTeamColourGold:
			return [UIColor yellowColor];
		default:
			return [UIColor grayColor];
	}
	return [UIColor grayColor];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.deathsOverTime release];
	[self.killsOverTime release];
	[self.medalsOverTime release];
	[super dealloc];
}

@end
