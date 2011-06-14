//
//  RSChallenges.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-19.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallenges.h"


@implementation RSChallenges

@synthesize weekly;
@synthesize daily;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary*)data {
	
	if ( (self = [super init]) ) {
		
		// Weekly
		self.weekly = [RSChallenge challengeWithAPIData:[data objectForKey:@"weekly"] weekly:YES];
		
		// Daily
		NSArray *dailyData = [data objectForKey:@"daily"];
		NSMutableArray *temp_daily = [[NSMutableArray alloc] initWithCapacity:[dailyData count]];
		for ( NSDictionary *data in dailyData ) {
			[temp_daily addObject:[RSChallenge challengeWithAPIData:data]];
		}
		self.daily = temp_daily;
		[temp_daily release];
	}
	
	return self;
}

+ (id)challengesWithAPIData:(NSDictionary*)data {
	return [[[RSChallenges alloc] initWithAPIData:data] autorelease];
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.weekly = [aDecoder decodeObjectForKey:@"w"];
		self.daily  = [aDecoder decodeObjectForKey:@"d"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.weekly forKey:@"w"];
	[aCoder encodeObject:self.daily forKey:@"d"];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	self.weekly = nil;
	[self.daily release];
	[super dealloc];
}


#pragma mark -
#pragma mark Daily
- (NSArray*)dailySortedByCredits {
	return [self dailySortBySelector:@selector(credits)];
}

- (NSArray*)dailySortedByCompletion {
	return [self dailySortBySelector:@selector(percentageComplete)];
}

- (NSArray*)dailySortBySelector:(SEL)key {
	NSUInteger array_size = [self.daily count];
	NSMutableArray *sc = [NSMutableArray arrayWithArray:self.daily];
	for ( int i = 0; i < (array_size - 1); i++ ) {
		for ( int j = (i + 1); j < array_size; j++ ) {
			if ( [[sc objectAtIndex:i] performSelector:key] < [[sc objectAtIndex:j] performSelector:key] ) {
				RSChallenge	*c = [sc objectAtIndex:j];
				[sc insertObject:c atIndex:i];
				[sc removeObjectAtIndex:(j+1)];
			}
		}	
	}
	return sc;
}

- (NSArray*)challenges {
	return [NSArray arrayWithObjects:self.weekly,[self.daily objectAtIndex:0],[self.daily objectAtIndex:1],[self.daily objectAtIndex:2],[self.daily objectAtIndex:3],nil];
}

@end
