//
//  RSSeasonStats.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-23.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSeasonStats : NSObject <NSCoding> {
	
	NSUInteger currentDailyRating;
	NSUInteger division;
	float divisionPercentile;
	NSUInteger gamesPlayed;
	NSString*  playlistSystemName;
	NSUInteger qualifyingDays;
	NSUInteger requiredDailyGames;
	NSUInteger requiredDays;
	NSUInteger seasonID;
}

@property (nonatomic) NSUInteger currentDailyRating;
@property (nonatomic) NSUInteger division;
@property (nonatomic) float divisionPercentile;
@property (nonatomic) NSUInteger gamesPlayed;
@property (nonatomic,copy) NSString*  playlistSystemName;
@property (nonatomic) NSUInteger qualifyingDays;
@property (nonatomic) NSUInteger requiredDailyGames;
@property (nonatomic) NSUInteger requiredDays;
@property (nonatomic) NSUInteger seasonID;

@end
