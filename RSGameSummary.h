//
//  RSGameSummary.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-12.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface RSGameSummary : NSObject <NSCoding> {
	
	// ID
	NSUInteger ID;
	
	// Campaign
	NSString *campaignDifficulty;
	NSString *campaignGlobalScore;
	BOOL campaignMetagameEnabled;
	
	// Time
	NSUInteger duration;
	NSString *timestamp; // NSUInteger gameTimestamp;
	
	// GameVariant
	NSUInteger variant;
	NSUInteger variantIconID;
	NSString *variantName;
	
	// Team
	BOOL isTeamGame;
	
	// Map
	NSString *baseMapName;
	
	// Players
	NSUInteger playerCount;
	
	// Playlist
	NSString *playlistName;
	
	// Requested Player
	NSString   *requestedPlayerGamertag;
	NSUInteger requestedPlayerAssists;
	NSUInteger requestedPlayerKills;
	NSUInteger requestedPlayerDeaths;
	NSUInteger requestedPlayerRating;
	NSUInteger requestedPlayerStanding;
	NSInteger  requestedPlayerScore;
}

@property (nonatomic) NSUInteger ID;
@property (nonatomic,copy) NSString *campaignDifficulty;
@property (nonatomic,copy) NSString *campaignGlobalScore;
@property (nonatomic) BOOL campaignMetagameEnabled;
@property (nonatomic) NSUInteger duration;
@property (nonatomic,copy) NSString *timestamp; // NSUInteger gameTimestamp;
@property (nonatomic) NSUInteger variant;
@property (nonatomic) NSUInteger variantIconID;
@property (nonatomic,copy) NSString *variantName;
@property (nonatomic) BOOL isTeamGame;
@property (nonatomic,copy) NSString *baseMapName;
@property (nonatomic) NSUInteger playerCount;
@property (nonatomic,copy) NSString *playlistName;
@property (nonatomic,copy) NSString *requestedPlayerGamertag;
@property (nonatomic) NSUInteger requestedPlayerAssists;
@property (nonatomic) NSUInteger requestedPlayerKills;
@property (nonatomic) NSUInteger requestedPlayerDeaths;
@property (nonatomic) NSUInteger requestedPlayerRating;
@property (nonatomic) NSUInteger requestedPlayerStanding;
@property (nonatomic) NSInteger  requestedPlayerScore;

- (id)initWithAPIData:(NSDictionary *)data gamertag:(NSString *)gamertag;
- (id)initWithAPIData:(NSDictionary *)data;

- (NSURL *)mapImageWithSize:(NSString*)size;
- (NSURL *)mapImage;

- (NSDate*)gameDate;

@end
