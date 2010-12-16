//
//  RSGameDetails.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameSummary.h"
#import "RSTeamGameDetails.h"
#import "RSPlayerGameDetails.h"


@interface RSGameDetails : RSGameSummary <NSCoding> {
	
	// Map
	NSString *mapName;
	
	// Players
	NSArray *players;
	
	// Teams
	NSArray *teams;
}

@property (nonatomic,copy) NSString *mapName;
@property (nonatomic,copy) NSArray *players;
@property (nonatomic,copy) NSArray *teams;

- (id)initWithAPIData:(NSDictionary *)data;
+ (RSGameDetails *)gameDetailsWithAPIData:(NSDictionary *)data;

- (NSArray *)playersOnTeam:(NSUInteger)team;
- (NSArray *)sortedPlayersOnTeam:(NSUInteger)team;
- (NSArray *)sortAllPlayers;

- (NSArray *)sortedTeams;

@end
