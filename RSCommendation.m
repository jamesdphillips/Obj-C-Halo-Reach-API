//
//  RSCommendation.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendation.h"
#import "RSCommendationMetadataRequest.h"
#import "RSCommendationCreditsMetadataRequest.h"


@implementation RSCommendation
@synthesize total, rank;

- (id)initWithAPIData:(NSDictionary *)data metadata:(RSCommendationMetadata*)metadata {
	
	if ((self = [super init])) {
		
		self.ID = metadata.ID;
		
		self.iron =	metadata.iron;
		self.bronze = metadata.bronze;
		self.silver = metadata.silver;
		self.gold = metadata.gold;
		self.onyx = metadata.onyx;
		self.max = metadata.max;
		
		self.name =	metadata.name;
		self.description = metadata.description;
		
		self.total = [[data objectForKey:@"Value"] intValue];
		self.rank = [self getRankFromTotal:self.total];
	}
	
	return self;
}


- (id)initWithAPIData:(NSDictionary *)data {
	NSDictionary *metadata = [RSCommendationMetadataRequest get];
	RSCommendationMetadata *comm = [metadata objectForKey:[data objectForKey:@"Key"]];
	return [self initWithAPIData:data metadata:comm];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super initWithCoder:aDecoder]) ) {
		
		self.total = [aDecoder decodeIntForKey:@"commTotal"];
		self.rank  = [aDecoder decodeIntForKey:@"commRank" ];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.total forKey:@"commTotal"];
	[aCoder encodeInt:self.rank  forKey:@"commRank" ];
	[super encodeWithCoder:aCoder];
}

/**
 * Return rank for given total
 */
- (RSCommendationRank)getRankFromTotal:(NSUInteger)t {
	if ( t >= self.max ) {
		return RSCommendationRankMax;
	} else if ( t >= self.onyx ) {
		return RSCommendationRankOnyx;
	} else if ( t >= self.gold ) {
		return RSCommendationRankGold;
	} else if ( t >= self.silver ) {
		return RSCommendationRankSilver;
	} else if ( t >= self.bronze ) {
		return RSCommendationRankBronze;
	} else if ( t >= self.iron ) {
		return RSCommendationRankIron;
	} else {
		return RSCommendationRankNone;
	}
}

/**
 * Return string representation for given rank
 */
+ (NSString*)rankStringWithRank:(RSCommendationRank)r {
	switch (r) {
		case RSCommendationRankMax:
			return @"Max";
		case RSCommendationRankOnyx:
			return @"Onyx";
		case RSCommendationRankGold:
			return @"Gold";
		case RSCommendationRankSilver:
			return @"Silver";
		case RSCommendationRankBronze:
			return @"Bronze";
		case RSCommendationRankIron:
			return @"Iron";
		case RSCommendationRankNone:
			return @"None";
	}
	return nil;
}

/**
 * Return string representation for current rank
 */
- (NSString*)rankString {
	return [RSCommendation rankStringWithRank:self.rank];
}

/**
 * Return rank total for given rank
 */
- (NSUInteger)rankTotalWithRank:(RSCommendationRank)r {
	switch (r) {
		case RSCommendationRankMax:
			return self.max;
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
		case RSCommendationRankNone:
		default:
			return self.total;
	}
	return self.total;
}

/**
 * Get next rank total
 */
- (NSUInteger)nextRankTotal {
	if ( self.rank != RSCommendationRankMax )
		return [self rankTotalWithRank:(self.rank + 1)];
	return self.total;
}

/**
 * Get next rank total if max'd return the max value
 */
- (NSUInteger)nextRankReal {
	if ( self.rank != RSCommendationRankMax )
		return [self rankTotalWithRank:(self.rank + 1)];
	return self.max;
}

/**
 * Return the image representation for the current rank
 */
- (NSURL*)rankImage {
	NSString *r = [[self rankString] lowercaseString];
	NSString *formattedName = [[[self name] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://i.reachservicerecord.com/commendations/%@/large/%@.png",r,formattedName]];
}

/**
 * Return completion percentage 
 */
- (CGFloat)percentCompletion {
	return ((CGFloat)self.total / (CGFloat)self.max);
}

/**
 * Return percentage toward next rank
 */
- (CGFloat)percentCompleteToNextRank {
	return ((CGFloat)self.total / (CGFloat)[self nextRankTotal]);
}

/**
 * Return the gametype
 */
- (NSString*)gametype {
	NSArray *types = [NSArray arrayWithObjects:@"Firefight",@"Campaign",@"multiplayer",nil];
	for ( NSString *type in types ) {
		NSRange textRange = [self.description rangeOfString:type];
		if(textRange.location != NSNotFound) {
			return type;
		}
	}
	return nil;
}

/**
 * Get total credits earned from given commendations
 */
+ (NSUInteger)totalCreditsWithComendations:(NSArray*)commendations {
	NSDictionary *cMetadata = [RSCommendationCreditsMetadataRequest get];
	return [[self class] totalCreditsWithComendations:commendations creditsMetadata:cMetadata];
}

/**
 * Get total credits earned from given commendations
 */
+ (NSUInteger)totalCreditsWithComendations:(NSArray *)commendations creditsMetadata:(NSDictionary*)cMetadata {
	NSUInteger totalCredits = 0;
	for ( RSCommendation *comm in commendations ) {
		NSNumber *key = [NSNumber numberWithInt:comm.ID];
		RSCommendationCreditsMetadata *data = [cMetadata objectForKey:key];
		NSUInteger credits = [data cumulativeCreditsWithRank:[comm rank]];
		totalCredits += credits;
	}
	return totalCredits;
}

/**
 * Sort given commendations with given selector  
 */
+ (NSArray*)sortCommendations:(NSArray*)commendations withSelector:(SEL)key {
	
	NSUInteger array_size = [commendations count];
	NSMutableArray *sc = [NSMutableArray arrayWithArray:commendations];
	for ( int i = 0; i < (array_size - 1); i++ ) {
		for ( int j = (i + 1); j < array_size; j++ ) {
			if ( [[sc objectAtIndex:i] performSelector:key] < [[sc objectAtIndex:j] performSelector:key] ) {
				RSCommendation *c = [sc objectAtIndex:j];
				[sc insertObject:c atIndex:i];
				[sc removeObjectAtIndex:(j+1)];
			}
		}	
	}
	return sc;
}


/**
 * Sort given commendations by completion
 */
+ (NSArray*)sortCommendations:(NSArray*)commendations {
	//return [RSCommendation sortCommendations:commendations withSelector:@selector(percentCompletion)];
	NSUInteger array_size = [commendations count];
	NSMutableArray *sc = [NSMutableArray arrayWithArray:commendations];
	for ( int i = 0; i < (array_size - 1); i++ ) {
		for ( int j = (i + 1); j < array_size; j++ ) {
			if ( [[sc objectAtIndex:i] percentCompletion] < [[sc objectAtIndex:j] percentCompletion] ) {
				RSCommendation *c = [sc objectAtIndex:j];
				[sc insertObject:c atIndex:i];
				[sc removeObjectAtIndex:(j+1)];
			}
		}	
	}
	return sc;
}

/**
 * Sort given commendations by rank
 */
+ (NSArray*)sortCommendationsByNextRankCompletion:(id)commendations {
	NSUInteger array_size = [commendations count];
	NSMutableArray *sc = [NSMutableArray arrayWithArray:commendations];
	for ( int i = 0; i < (array_size - 1); i++ ) {
		for ( int j = (i + 1); j < array_size; j++ ) {
			if ( [[sc objectAtIndex:i] percentCompleteToNextRank] < [[sc objectAtIndex:j] percentCompleteToNextRank] ) {
				RSCommendation *c = [sc objectAtIndex:j];
				[sc removeObjectAtIndex:j];
				[sc insertObject:c atIndex:i];
			}
		}	
	}
	return sc;
}

/**
 * Sort given commendations by their gametype
 */
+ (NSDictionary*)sortCommendationsByGametype:(NSArray*)commendations {
	NSMutableDictionary *sortedCommendations = [NSMutableDictionary dictionary];
	for ( RSCommendation *comm in commendations ) {
		NSString *gametype = [comm gametype];
		if ( [sortedCommendations objectForKey:gametype] ) {
			[sortedCommendations setObject:[NSMutableArray arrayWithObject:comm]
									forKey:gametype];
		} else {
			[[sortedCommendations objectForKey:gametype] addObject:comm];
		}
	}
	return [NSDictionary dictionaryWithDictionary:sortedCommendations];
}

/**
 * Retrun commendations for given gametype
 */
+ (NSArray*)sortCommendations:(NSArray*)commendations withGametype:(NSString*)gametype {
	NSMutableArray *sortedCommendations = [NSMutableArray array];
	for ( RSCommendation *comm in commendations ) {
		if ( [[[comm gametype] lowercaseString] isEqualToString:[gametype lowercaseString]] )
			[sortedCommendations addObject:comm];
	}
	return [NSArray arrayWithArray:sortedCommendations];
}

/**
 * Return commendations sorted and categorized by their rank
 */
+ (NSDictionary*)categorizeCommendationsByRank:(NSArray *)commendations {
	NSMutableDictionary *sortedCommendations = [NSMutableDictionary dictionary];
	for ( RSCommendation *comm in commendations ) {
		if ( [sortedCommendations objectForKey:[comm rankString]] ) {
			[[sortedCommendations objectForKey:[comm rankString]] addObject:comm];
		} else {
			[sortedCommendations setObject:[NSMutableArray arrayWithObject:comm] forKey:[comm rankString]];
		}
	}
	return [NSDictionary dictionaryWithDictionary:sortedCommendations];
}

/**
 * Return commendations sorted by their rank
 */
+ (NSArray*)sortCommendationsByRank:(NSArray *)commendations {
	NSMutableDictionary *sortedCommendations = [NSMutableDictionary dictionary];
	for ( RSCommendation *comm in commendations ) {
		NSNumber *rankNum = [NSNumber numberWithInt:[comm rank]];
		if ( [sortedCommendations objectForKey:rankNum] ) {
			[[sortedCommendations objectForKey:rankNum] addObject:comm];
		} else {
			[sortedCommendations setObject:[NSMutableArray arrayWithObject:comm] forKey:rankNum];
		}
	}
	NSMutableArray *sortedCommendationsInOrder = [NSMutableArray arrayWithCapacity:[commendations count]];
	for (int i = 0; [RSCommendation rankStringWithRank:i]; i++) {
		NSNumber *rankNum = [NSNumber numberWithInt:i];
		RSCommendation *comm = [sortedCommendations objectForKey:rankNum];
		if ( comm )
			[sortedCommendationsInOrder insertObject:comm
											 atIndex:0];
	}
	return sortedCommendationsInOrder;
}

@end
