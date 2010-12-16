//
//  RSCommendationCredits.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-24.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendation.h"


@interface RSCommendationCreditsMetadata : NSObject <NSCoding> {
	
	NSUInteger ID;
	NSUInteger iron;
	NSUInteger bronze;
	NSUInteger silver;
	NSUInteger gold;
	NSUInteger onyx;
}

@property (nonatomic) NSUInteger ID;
@property (nonatomic) NSUInteger iron;
@property (nonatomic) NSUInteger bronze;
@property (nonatomic) NSUInteger silver;
@property (nonatomic) NSUInteger gold;
@property (nonatomic) NSUInteger onyx;

- (id)initWithAPIData:(NSDictionary*)data;

- (NSUInteger)creditsWithRank:(RSCommendationRank)rank;
- (NSUInteger)cumulativeCreditsWithRank:(RSCommendationRank)rank;

@end
