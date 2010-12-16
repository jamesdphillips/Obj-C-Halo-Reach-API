//
//  RSPlayerDetails.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendation.h"

typedef enum {
	CampaignProgressNone,
	CampaignProgressEasyPartial,
	CampaignProgressNormalPartial,
	CampaignProgressHeroicPartial,
	CampaignProgressLegendaryPartial,
	CampaignProgressEasyComplete,
	CampaignProgressNormalComplete,
	CampaignProgressHeroicComplete,
	CampaignProgressLegendaryComplete
} CampaignProgressState;

@interface RSPlayer : NSObject <NSCoding> {
	
	// Gamertag
	NSString *gamertag;
	
	// Campaign Progress
	CampaignProgressState singlePlayerProgress;
	CampaignProgressState coopProgress;
	
	// Player type
	BOOL initialized;
	BOOL isGuest;
	
	// Player emblem
	NSDictionary *emblemData;
	
	// Last Variant Played
	NSString *lastVariantPlayed;
	
	// Completion
	float armoryCompletion;
	float commendationCompletion;
	NSUInteger dailyChallengesCompleted;
	NSUInteger weeklyChallengesCompleted;
	
	// Service Tag
	NSString *serviceTag;
	
	// Activity
	NSUInteger gamesPlayed;
	NSString *firstPlayed;
	NSString *lastPlayed;
	NSDate *firstPlayedDate;
	NSDate *lastPlayedDate;
	
	// Commendations
	NSDictionary *commendations;
}

@property (copy,nonatomic) NSString *gamertag;
@property (nonatomic) CampaignProgressState singlePlayerProgress;
@property (nonatomic) CampaignProgressState coopProgress;
@property (nonatomic) BOOL initialized;
@property (nonatomic) BOOL isGuest;
@property (copy,nonatomic) NSDictionary *emblemData;
@property (copy,nonatomic) NSString *lastVariantPlayed;
@property (nonatomic) float armoryCompletion;
@property (nonatomic) float commendationCompletion;
@property (nonatomic) NSUInteger dailyChallengesCompleted;
@property (nonatomic) NSUInteger weeklyChallengesCompleted;
@property (copy,nonatomic) NSString *serviceTag;
@property (nonatomic) NSUInteger gamesPlayed;
@property (copy,nonatomic) NSString *firstPlayed;
@property (copy,nonatomic) NSString *lastPlayed;
@property (retain,nonatomic) NSDate *firstPlayedDate;
@property (retain,nonatomic) NSDate *lastPlayedDate;
@property (copy,nonatomic) NSDictionary *commendations;

- (id)initWithAPIData:(NSDictionary *)data;
- (id)initWithDictionary:(NSDictionary*)data;

+ (RSPlayer*)playerWithAPIData:(NSDictionary*)data;
+ (RSPlayer*)playerWithDictionary:(NSDictionary*)data;

- (NSDictionary*)serialize;

- (NSString *)campaignProgressStringWithProgress:(CampaignProgressState)progress;
- (NSString *)singlePlayerProgressString;
- (NSString *)coopProgressString;
- (CampaignProgressState)campaignProgressWithAPIString:(NSString *)apiString;

- (NSURL *)campaignProgressImageURL:(CampaignProgressState)progress;
- (NSURL *)soloCampaignProgressImageURL;
- (NSURL *)coopCampaignProgressImageURL;

- (NSURL *)emblemURLWithSize:(NSUInteger)size;
- (NSURL *)emblemURL;

- (NSDate*)firstPlayedDate;
- (NSDate*)lastPlayedDate;
- (NSString*)firstPlayedString;
- (NSString*)lastPlayedString;

@end
