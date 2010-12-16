//
//  RSChallenge.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-18.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

@interface RSChallenge : NSObject <NSCoding> {
	
	// Description
	NSString *name;
	NSString *description;
	
	// Image
	NSUInteger imageIndex;
	
	// Progress
	NSUInteger progress;
	NSUInteger total;
	
	// Credits
	NSUInteger credits;
	
	// Weekly
	BOOL isWeekly;
}

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *description;
@property (nonatomic) NSUInteger imageIndex;
@property (nonatomic) NSUInteger progress;
@property (nonatomic) NSUInteger total;
@property (nonatomic) NSUInteger credits;
@property (nonatomic) BOOL isWeekly;

- (id)initWithAPIData:(NSDictionary*)data weekly:(BOOL)w;
+ (id)challengeWithAPIData:(NSDictionary*)data;
+ (id)challengeWithAPIData:(NSDictionary *)data weekly:(BOOL)w;

- (NSURL*)imageURL;
- (NSString*)imageString;

- (CGFloat)percentageComplete;
- (NSString *)percentageCompleteString;
- (NSString *)completeString;

+ (NSUInteger)secondsTillWeekly;
+ (NSUInteger)secondsTillDaily;
+ (NSString*)timeTillEndString:(NSUInteger)timeRemaining;
+ (NSString*)timeTillDailyString;
+ (NSString*)timeTillWeeklyString;
- (NSUInteger)secondsLeft;
- (NSString*)timeLeftString;
- (NSString*)daysLeftString;
- (NSDate*)expiryDate;

@end
