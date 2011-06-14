//
//  RSCommendationMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendationMetadata.h"


@implementation RSCommendationMetadata


#pragma mark -
#pragma mark Synthesize
@synthesize ID;
@synthesize iron, bronze, silver, gold, onyx, max;
@synthesize name, description;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( (self = [super init]) ) {
		
		self.ID = [[data objectForKey:@"Id"] intValue];
		
		self.iron = [[data objectForKey:@"Iron"] intValue];
		self.bronze	= [[data objectForKey:@"Bronze"] intValue];
		self.silver	= [[data objectForKey:@"Silver"] intValue];
		self.gold = [[data objectForKey:@"Gold"] intValue];
		self.onyx = [[data objectForKey:@"Onyx"] intValue];
		self.max = [[data objectForKey:@"Max"] intValue];
		
		self.name = [data objectForKey:@"Name"];
		self.description = [data objectForKey:@"Description"];
	}
	
	return self;
}

+ (RSCommendationMetadata *)commendationsWithAPIData:(NSDictionary *)data {
	return [[[RSCommendationMetadata alloc] initWithAPIData:data] autorelease];
}


#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.iron = [aDecoder decodeIntForKey:@"i"];
		self.bronze = [aDecoder decodeIntForKey:@"b"];
		self.silver = [aDecoder decodeIntForKey:@"s"];
		self.gold = [aDecoder decodeIntForKey:@"g"];
		self.onyx = [aDecoder decodeIntForKey:@"o"];
		self.max = [aDecoder decodeIntForKey:@"m"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"d"];
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
	[aCoder encodeInt:self.max forKey:@"m"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"d"];
}


#pragma mark -
#pragma mark Comprare

- (NSComparisonResult)compare:(RSCommendationMetadata*)comp {
	return [self.name caseInsensitiveCompare:comp.name];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.name release];
	[self.description release];
	[super dealloc];
}

@end
