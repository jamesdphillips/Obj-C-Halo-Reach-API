//
//  RSChallenge.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-18.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallenge.h"


@implementation RSChallenge

@synthesize name,description;
@synthesize imageIndex;
@synthesize progress,total;
@synthesize credits;
@synthesize isWeekly;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary*)data weekly:(BOOL)w {
	
	if ( self = [super init] ) {
		
		// Description
		self.name = [data objectForKey:@"name"];
		self.description = [data objectForKey:@"description"];
		
		// Image
		self.imageIndex = [[data objectForKey:@"image"] intValue];
		
		// Progress
		if ( [[data objectForKey:@"progress"] length] > 0 ) {
			NSArray *progressArray = [[data objectForKey:@"progress"] componentsSeparatedByString:@"/"];
			self.progress = [[progressArray objectAtIndex:0] integerValue];
			self.total = [[progressArray objectAtIndex:1] integerValue];
		} else {
			self.progress = 1;
			self.total = 1;
		}
		
		// Credits
		self.credits = [[[data objectForKey:@"credits"] stringByReplacingOccurrencesOfString:@"cR" withString:@""] integerValue];
		
		// Weekly
		self.isWeekly = w;
	}
	
	return self;
}

+ (id)challengeWithAPIData:(NSDictionary*)data {
	return [[[RSChallenge alloc] initWithAPIData:data weekly:NO] autorelease];
}

+ (id)challengeWithAPIData:(NSDictionary*)data weekly:(BOOL)w {
	return [[[RSChallenge alloc] initWithAPIData:data weekly:w] autorelease];
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"de"];
		self.imageIndex = [aDecoder decodeIntForKey:@"iI"];
		self.progress = [aDecoder decodeIntForKey:@"p"];
		self.total = [aDecoder decodeIntForKey:@"t"];
		self.credits = [aDecoder decodeIntForKey:@"c"];
		self.isWeekly = [aDecoder decodeBoolForKey:@"iW"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"de"];
	[aCoder encodeInt:self.imageIndex forKey:@"iI"];
	[aCoder encodeInt:self.progress forKey:@"p"];
	[aCoder encodeInt:self.total forKey:@"t"];
	[aCoder encodeInt:self.credits forKey:@"c"];
	[aCoder encodeBool:self.isWeekly forKey:@"iW"];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.name release];
	[self.description release];
	[super dealloc];
}


#pragma mark -
#pragma mark Image
- (NSURL*)imageURL {
	return [NSURL URLWithString:[self imageString]];
}

- (NSString*)imageString {
	return [NSString stringWithFormat:@"http://www.bungie.net/images/reachstats/challenges/%d.png",self.imageIndex];
}


#pragma mark -
#pragma mark Progress
- (CGFloat)percentageComplete {
	return ((CGFloat)self.progress / (CGFloat)self.total);
}

- (NSString *)percentageCompleteString {
	return [NSString stringWithFormat:@"%0.1f %%",[self percentageComplete]];
}

- (NSString *)completeString {
	return [NSString stringWithFormat:@"%d/%d",self.progress,self.total];
}


#pragma mark -
#pragma mark Credits
- (NSString *)creditsString {
	return [NSString stringWithFormat:@"%dcR",self.credits];
}


#pragma mark -
#pragma mark Time
- (NSUInteger)secondsLeft {
	if ( isWeekly ) {
		return [RSChallenge secondsTillWeekly];
	} else {
		return [RSChallenge secondsTillDaily];
	}
}

+ (NSUInteger)secondsTillWeekly {
	NSUInteger daylightSav = ([[NSTimeZone timeZoneWithAbbreviation:@"PST"] isDaylightSavingTime] ? 0 : 3600);
	NSUInteger currentDate = [[NSDate date] timeIntervalSince1970];
	NSUInteger lengthOfWeek = 604800; // (7 * 24 * 60 * 60)
	NSUInteger timeSinceThursday = currentDate % lengthOfWeek;
	NSUInteger newChallengesTime = 381600 + daylightSav; // (4 * 24 * 60 * 60) + (10 * 60 * 60)
	NSUInteger timeRemaining = newChallengesTime - timeSinceThursday;
	if ( timeSinceThursday > newChallengesTime )
		timeRemaining = (lengthOfWeek - timeSinceThursday) + newChallengesTime;
	
	return timeRemaining;
}

+ (NSUInteger)secondsTillDaily {
	NSUInteger daylightSav = ([[NSTimeZone timeZoneWithAbbreviation:@"PST"] isDaylightSavingTime] ? 0 : 3600);
	NSUInteger currentDate = [[NSDate date] timeIntervalSince1970];
	NSUInteger lengthOfDay = 86400; // (24 * 60 * 60)
	NSUInteger timeSinceMidnight = currentDate % lengthOfDay;
	NSUInteger newChallengesTime = 36000 + daylightSav; // (10 * 60 * 60)
	NSUInteger timeRemaining = newChallengesTime - timeSinceMidnight;
	if ( timeSinceMidnight > newChallengesTime )
		timeRemaining = (lengthOfDay - timeSinceMidnight) + newChallengesTime;
	
	return timeRemaining;
}

+ (NSString*)timeTillEndString:(NSUInteger)timeRemaining {
	if ( timeRemaining >= 86400 ) {
		return [NSString stringWithFormat:@"%dd%dh%dm",
				(int)floorf(timeRemaining / 86400),
				(int)floorf((timeRemaining % 86400) / 60.0f / 60.0f),
				((int)ceilf(timeRemaining / 60.0) % 60)];
	}
	return [NSString stringWithFormat:@"%dh%dm",
			(int)floorf((float)timeRemaining / 60.0f / 60.0f),
			((int)ceilf((float)timeRemaining / 60.0f) % 60)];
}

+ (NSString*)timeTillDailyString {
	return [RSChallenge timeTillEndString:[RSChallenge secondsTillDaily]];
}

+ (NSString*)timeTillWeeklyString {
	return [RSChallenge timeTillEndString:[RSChallenge secondsTillWeekly]];
}

- (NSString *)timeLeftString {
	if ( self.isWeekly )
		return [RSChallenge timeTillWeeklyString];
	else
		return [RSChallenge timeTillDailyString];
}

- (NSString *)daysLeftString {
	return [RSChallenge timeTillWeeklyString];
}

- (NSDate*)expiryDate {
	NSDate *date = [NSDate date];
	return [NSDate dateWithTimeIntervalSince1970:([date timeIntervalSince1970] + [self secondsLeft])];
}

@end
