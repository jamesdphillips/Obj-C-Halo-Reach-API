//
//  RSPointsOverTime.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSScoreOverTime.h"


@implementation RSScoreOverTime

@synthesize time,score;


#pragma mark -
#pragma mark Initialize

- (id)initWithTime:(NSUInteger)t score:(NSUInteger)s {
	if ( self = [super init] ) {
		self.time = t;
		self.score = s;
	}
	return self;
}

+ (RSScoreOverTime *)scoreOverTimeWithTime:(NSUInteger)t score:(NSUInteger)s {
	return [[[RSScoreOverTime alloc] initWithTime:t score:s] autorelease];
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		
		self.time  = [aDecoder decodeIntForKey:@"t"];
		self.score = [aDecoder decodeIntForKey:@"s"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.time forKey:@"t"];
	[aCoder encodeInt:self.score forKey:@"s"];
}

@end