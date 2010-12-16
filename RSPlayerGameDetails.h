//
//  RSPlayerGameDetails.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayer.h"


@interface RSPlayerGameDetails : NSObject <NSCoding> {
	
	// Vehicle Information
	NSDictionary *AICarnage;
	
	// Score Info
	NSArray *pointsOverTime;
	NSArray *killsOverTime;
	NSArray *deathsOverTime;
	NSUInteger assists;
	NSUInteger betrayals;
	NSUInteger deaths;
	NSUInteger individualStandingWithNoRegardsForTeams;
	NSUInteger kills;
	NSUInteger rating;
	NSUInteger score;
	NSUInteger standing;
	NSUInteger suicides;
	BOOL DNF;
	
	// Averages
	NSUInteger averageDeathDistanceMeters;
	NSUInteger averageKillDistanceMeters;
	
	// Team Info
	NSUInteger team;
	NSUInteger teamScore;
	
	// Medals
	NSArray *medalsOverTime;
	NSDictionary *medalCounts;
	NSUInteger multiMedalCount;
	NSUInteger otherMedalCount;
	NSUInteger spreeMedalCount;
	NSUInteger styleMedalCount;
	NSUInteger totalMedalCount;
	NSUInteger uniqueMultiMedalCount;
	NSUInteger uniqueOtherMedalCount;
	NSUInteger uniqueSpreeMedalCount;
	NSUInteger uniqueStyleMedalCount;
	NSUInteger uniqueTotalMedalCount;
	
	// Player
	RSPlayer *playerDetail;
	
	// Weapons
	NSDictionary *weaponCarnage;
	NSUInteger headshots;
}

@property (copy,nonatomic) NSDictionary *AICarnage;

@property (copy,nonatomic) NSArray *pointsOverTime;
@property (copy,nonatomic) NSArray *killsOverTime;
@property (copy,nonatomic) NSArray *deathsOverTime;
@property (nonatomic) NSUInteger assists;
@property (nonatomic) NSUInteger betrayals;
@property (nonatomic) NSUInteger deaths;
@property (nonatomic) NSUInteger individualStandingWithNoRegardsForTeams;
@property (nonatomic) NSUInteger kills;
@property (nonatomic) NSUInteger rating;
@property (nonatomic) NSUInteger score;
@property (nonatomic) NSUInteger standing;
@property (nonatomic) NSUInteger suicides;
@property (nonatomic) BOOL DNF;

@property (nonatomic) NSUInteger averageDeathDistanceMeters;
@property (nonatomic) NSUInteger averageKillDistanceMeters;

@property (nonatomic) NSUInteger team;
@property (nonatomic) NSUInteger teamScore;

@property (copy,nonatomic) NSArray *medalsOverTime;
@property (copy,nonatomic) NSDictionary *medalCounts;
@property (nonatomic) NSUInteger multiMedalCount;
@property (nonatomic) NSUInteger otherMedalCount;
@property (nonatomic) NSUInteger spreeMedalCount;
@property (nonatomic) NSUInteger styleMedalCount;
@property (nonatomic) NSUInteger totalMedalCount;
@property (nonatomic) NSUInteger uniqueMultiMedalCount;
@property (nonatomic) NSUInteger uniqueOtherMedalCount;
@property (nonatomic) NSUInteger uniqueSpreeMedalCount;
@property (nonatomic) NSUInteger uniqueStyleMedalCount;
@property (nonatomic) NSUInteger uniqueTotalMedalCount;

@property (retain,nonatomic) RSPlayer *playerDetail;

@property (copy,nonatomic) NSDictionary *weaponCarnage;
@property (nonatomic) NSUInteger headshots;

@end



/**
 ** AI Carnage
 */
@interface RSAICarnage : NSObject <NSCoding> {
	// ID
	NSUInteger ID;
	// Points
	NSUInteger penalties;
	NSUInteger betrayals;
	NSInteger  points;
	// Kills
	CGFloat killAverageDistance;
	NSUInteger killCount;
	NSArray *killDistances;
	float killsPerHour;
	NSArray *killTimes;
	// Killed By
	CGFloat killedByAverageDistance;
	NSUInteger killedByCount;
	NSArray *killedByDistances;
	NSArray *killedByTimes;
	// Description
	NSString *name;
	NSString *description;
	NSString *imageName;
}
@property (nonatomic) NSUInteger ID;
@property (nonatomic) NSUInteger penalties;
@property (nonatomic) NSUInteger betrayals;
@property (nonatomic) NSInteger  points;
@property (nonatomic) CGFloat killAverageDistance;
@property (nonatomic) NSUInteger killCount;
@property (nonatomic,copy) NSArray *killDistances;
@property (nonatomic) float killsPerHour;
@property (nonatomic,copy) NSArray *killTimes;
@property (nonatomic) CGFloat killedByAverageDistance;
@property (nonatomic) NSUInteger killedByCount;
@property (nonatomic,copy) NSArray *killedByDistances;
@property (nonatomic,copy) NSArray *killedByTimes;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *imageName;
- (id)initWithAPIData:(NSDictionary *)data;
+ (RSAICarnage *)AICarnageWithAPIData:(NSDictionary *)data;
+ (RSAICarnage *)AICarnageWithAPIData:(NSDictionary *)data name:(NSString *)n description:(NSString *)d imageName:(NSString *)iname;
- (NSString*)imageURL;
- (NSComparisonResult)compare:(RSAICarnage*)obj;
@end



/**
 ** Weapon Carnage
 */
@interface RSWeaponCarnage : NSObject <NSCoding> {
	NSUInteger	ID;
	NSString	*name;
	NSString	*description;
	NSUInteger	deaths;
	NSUInteger	headshots;
	NSUInteger	kills;
	NSUInteger	penalties;
}
@property (nonatomic) NSUInteger ID;
@property (nonatomic) NSUInteger deaths;
@property (nonatomic) NSUInteger headshots;
@property (nonatomic) NSUInteger kills;
@property (nonatomic) NSUInteger penalties;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *name;
- (id)initWithID:(NSUInteger)i deaths:(NSUInteger)d headshots:(NSUInteger)h kills:(NSUInteger)k penalties:(NSUInteger)p;
- (id)initWithAPIData:(NSDictionary *)data;
+ (RSWeaponCarnage *)weaponCarnageWithID:(NSUInteger)i deaths:(NSUInteger)d headshots:(NSUInteger)h kills:(NSUInteger)k penalties:(NSUInteger)p;
+ (RSWeaponCarnage *)weaponCarnageWithAPIData:(NSDictionary *)data;
+ (RSWeaponCarnage *)weaponCarnageWithAPIData:(NSDictionary *)data name:(NSString *)n description:(NSString *)d;
- (NSString*)imageURL;
- (NSComparisonResult)compare:(RSWeaponCarnage*)obj;
@end