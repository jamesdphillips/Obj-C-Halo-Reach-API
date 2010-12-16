//
//  RSGameDetails.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameDetails.h"
#import "RSTeamGameDetails.h"
#import "RSPlayerGameDetails.h"


@implementation RSGameDetails

@synthesize mapName;
@synthesize players;
@synthesize teams;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( self = [super initWithAPIData:data] ) {
		
		/**
		 ** MapName
		 */
		
		self.mapName = [data objectForKey:@"MapName"];
		self.baseMapName = [data objectForKey:@"BaseMapName"];
		
		
		/**
		 ** Players
		 **/
		
		NSArray *playersData = [data objectForKey:@"Players"];
		NSMutableArray *temp_players = [[NSMutableArray alloc] initWithCapacity:[playersData count]];
		for ( NSDictionary *player in playersData ) {
			[temp_players addObject:[[[RSPlayerGameDetails alloc] initWithAPIData:player] autorelease]];
		}
		self.players = temp_players;
		[temp_players release];
		
		
		/**
		 ** Teams
		 */
		
		NSArray *teamsData = [data objectForKey:@"Teams"];
		if ( [teamsData isKindOfClass:[NSArray class]] ) {
			NSMutableArray *temp_teams = [[NSMutableArray alloc] initWithCapacity:[teamsData count]];
			for ( NSDictionary *team in teamsData ) {
				[temp_teams addObject:[[[RSTeamGameDetails alloc] initWithAPIData:team] autorelease]];
			}
			self.teams = temp_teams;
			[temp_teams release];
		}
	}
	
	return self;
}

+ (RSGameDetails *)gameDetailsWithAPIData:(NSDictionary *)data {
	return [[[RSGameDetails alloc] initWithAPIData:data] autorelease];
}


#pragma mark -
#pragma mark NSCoder

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		
		self.mapName =	[aDecoder decodeObjectForKey:@"mapName"];
		self.players =	[aDecoder decodeObjectForKey:@"players"];
		self.teams =	[aDecoder decodeObjectForKey:@"teams"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.mapName forKey:@"mapName"];
	[aCoder encodeObject:self.players forKey:@"players"];
	[aCoder encodeObject:self.teams   forKey:@"teams"];
	
	[super encodeWithCoder:aCoder];
}


#pragma mark -
#pragma mark Players

- (NSArray *)playersOnTeam:(NSUInteger)team {
	
	NSMutableArray *teammates = [NSMutableArray array];
	for ( RSPlayerGameDetails *player in self.players ) {
		if ( [player team] == team )
			[teammates addObject:player];
	}
	
	return [NSArray arrayWithArray:teammates];
}

- (NSArray *)sortPlayers:(NSArray *)p {
	
	NSUInteger array_size = [p count];
	NSMutableArray *sortedPlayers = [NSMutableArray arrayWithArray:p];
	for ( int i = 0; i < (array_size - 1); i++ ) {
		for ( int j = (i + 1); j < array_size; j++ ) {
			if ( [[sortedPlayers objectAtIndex:i] score] < [[sortedPlayers objectAtIndex:j] score] ) {
				RSPlayerGameDetails *player = [sortedPlayers objectAtIndex:j];
				[sortedPlayers insertObject:player atIndex:i];
				[sortedPlayers removeObjectAtIndex:(j+1)];
			}
		}	
	}
	return sortedPlayers;
}

- (NSArray *)sortedPlayersOnTeam:(NSUInteger)team {
	return [self sortPlayers:[self playersOnTeam:team]];
}

- (NSArray *)sortAllPlayers {
	return [self sortPlayers:self.players];
}


#pragma mark -
#pragma mark Teams
- (NSArray *)sortedTeams {
	
	if ( self.isTeamGame ) {
		NSUInteger array_size = [self.teams count];
		NSMutableArray *sortedTeams = [NSMutableArray arrayWithArray:self.teams];
		for ( int i = 0; i < (array_size - 1); i++ ) {
			for ( int j = (i + 1); j < array_size; j++ ) {
				if ( [[sortedTeams objectAtIndex:i] score] < [[sortedTeams objectAtIndex:j] score] ) {
					RSTeamGameDetails *team = [sortedTeams objectAtIndex:j];
					[sortedTeams insertObject:team atIndex:i];
					[sortedTeams removeObjectAtIndex:(j+1)];
				}
			}	
		}
		return sortedTeams;
	}
	return nil;
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.mapName release];
	[self.players release];
	[self.teams release];
	[super dealloc];
}


#pragma mark -
#pragma mark Maps

- (NSURL *)mapImageWithSize:(NSString*)size {
	if ( self.variant == 4 ) {
		NSString *mn = [[self.mapName stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
		return [NSURL URLWithString:[NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/cp_%@.jpg",size,mn]];
	}
	return [super mapImageWithSize:size];
}

@end
