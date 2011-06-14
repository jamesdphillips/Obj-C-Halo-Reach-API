//
//  RSChallenges.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-19.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallenge.h"


@interface RSChallenges : NSObject <NSCoding> {
	
	// Weekly
	RSChallenge *weekly;
	
	// Daily
	NSArray *daily;
}

@property (nonatomic,retain) RSChallenge *weekly;
@property (nonatomic,copy) NSArray *daily;

- (id)initWithAPIData:(NSDictionary*)data;
+ (id)challengesWithAPIData:(NSDictionary*)data;

- (NSArray*)dailySortedByCredits;
- (NSArray*)dailySortedByCompletion;
- (NSArray*)dailySortBySelector:(SEL)key;
- (NSArray*)challenges;

@end
