//
//  RSRankMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSRankMetadata.h"


@implementation RSRankMetadata

@synthesize key;
@synthesize name;
@synthesize credits;

- (id)initWithAPIData:(NSDictionary*)apiData {
	if ( (self = [super init]) ) {
		
		self.key =  [apiData objectForKey:@"Key"];
		self.name = [apiData objectForKey:@"Value"];
		self.credits = [[apiData objectForKey:@"credits"] intValue];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.key  = [aDecoder decodeObjectForKey:@"k"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.credits = [aDecoder decodeIntForKey:@"c"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.key  forKey:@"k"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeInt:self.credits forKey:@"c"];
}

- (NSURL *)image {
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net/images/reachStats/grades/med/%@.png",self.key]];
}

- (void)dealloc {
	[self.key release];
	[self.name release];
	[super dealloc];
}

@end
