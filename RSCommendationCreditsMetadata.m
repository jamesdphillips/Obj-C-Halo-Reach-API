//
//  RSCommendationCredits.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-24.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendationCreditsMetadata.h"


@implementation RSCommendationCreditsMetadata

@synthesize ID;
@synthesize iron;
@synthesize bronze;
@synthesize silver;
@synthesize gold;
@synthesize onyx;

- (id)initWithAPIData:(NSDictionary*)data {
	if (self = [super init]) {
		self.ID = [[data objectForKey:@"key"] intValue];
		self.iron = [[data objectForKey:@"iron"] intValue];
		self.bronze = [[data objectForKey:@"bronze"] intValue];
		self.silver = [[data objectForKey:@"silver"] intValue];
		self.gold = [[data objectForKey:@"gold"] intValue];
		self.onyx = [[data objectForKey:@"onyx"] intValue];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.iron = [aDecoder decodeIntForKey:@"i"];
		self.bronze = [aDecoder decodeIntForKey:@"b"];
		self.silver = [aDecoder decodeIntForKey:@"s"];
		self.gold = [aDecoder decodeIntForKey:@"g"];
		self.onyx = [aDecoder decodeIntForKey:@"o"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.ID forKey:@"I"];
	[aCoder encodeInt:self.iron forKey:@"i"];
	[aCoder encodeInt:self.bronze forKey:@"b"];
	[aCoder encodeInt:self.silver forKey:@"s"];
	[aCoder encodeInt:self.gold forKey:@"g"];
	[aCoder encodeInt:self.onyx forKey:@"o"];
}

- (NSUInteger)creditsWithRank:(RSCommendationRank)rank {
	switch (rank) {
		case RSCommendationRankOnyx:
			return self.onyx;
		case RSCommendationRankGold:
			return self.gold;
		case RSCommendationRankSilver:
			return self.silver;
		case RSCommendationRankBronze:
			return self.bronze;
		case RSCommendationRankIron:
			return self.iron;
		default:
			return 0;
	}
}

- (NSUInteger)cumulativeCreditsWithRank:(RSCommendationRank)rank {
	NSUInteger cumulativeCredits = 0;
	switch (rank) {
		case RSCommendationRankMax:
		case RSCommendationRankOnyx:
			cumulativeCredits += self.onyx;
		case RSCommendationRankGold:
			cumulativeCredits += self.gold;
		case RSCommendationRankSilver:
			cumulativeCredits += self.silver;
		case RSCommendationRankBronze:
			cumulativeCredits += self.bronze;
		case RSCommendationRankIron:
			cumulativeCredits += self.iron;
			return cumulativeCredits;
		default:
			return 0;
	}
}

@end
