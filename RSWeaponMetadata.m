//
//  RSWeaponMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSWeaponMetadata.h"


@implementation RSWeaponMetadata

@synthesize identifier;
@synthesize name, description;

- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( self = [super init] ) {
		
		self.identifier = [[data objectForKey:@"Id"] intValue];
		
		self.name = [data objectForKey:@"Name"];
		self.description = [data objectForKey:@"Description"];
	}
	
	return self;
}

+ (id)weaponMetadataWithAPIData:(NSDictionary *)data {
	return [[[RSWeaponMetadata alloc] initWithAPIData:data] autorelease];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.identifier = [aDecoder decodeIntForKey:@"id"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"d"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"d"];
	[aCoder encodeInt:self.identifier forKey:@"id"];
}

- (NSString*)imageURLWithSize:(BOOL)isDoubleScale {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/weapons/%d%@.png",self.identifier,(isDoubleScale ? @"@2x" : @"")];
}

- (NSString*)imageURL {
	return [self imageURLWithSize:NO];
}

- (NSString*)doubleScaleImageURL {
	return [self imageURLWithSize:YES];
}

- (void)dealloc {
	[self.name release];
	[self.description release];
	[super dealloc];
}

@end
