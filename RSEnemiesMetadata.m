//
//  RSEnemiesMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSEnemiesMetadata.h"


@implementation RSEnemiesMetadata

@synthesize identifier;
@synthesize name, description, imageName;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( (self = [super init]) ) {
		
		self.identifier = [[data objectForKey:@"Id"] intValue];
		
		self.name = [data objectForKey:@"Name"];
		self.imageName = [data objectForKey:@"ImageName"];
		self.description = [data objectForKey:@"Description"];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.identifier = [aDecoder decodeIntForKey:@"i"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"d"];
		self.imageName = [aDecoder decodeObjectForKey:@"iN"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.identifier forKey:@"i"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"d"];
	[aCoder encodeObject:self.imageName forKey:@"iN"];
}

+ (RSEnemiesMetadata *)enemyMetadataWithAPIData:(NSDictionary *)data {
	return [[[RSEnemiesMetadata alloc] initWithAPIData:data] autorelease];
}

- (NSString*)imageURLWithSize:(BOOL)doubleSize {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/enemies_resized/%@%@.png",self.imageName,(doubleSize ? @"@2x" : @"")];
}

- (NSString*)doubleSizedImageURL {
	return [self imageURLWithSize:YES];
}

- (NSString*)imageURL {
	return [self imageURLWithSize:NO];
}

- (NSComparisonResult)compare:(RSEnemiesMetadata*)comp {
	return [self.name caseInsensitiveCompare:comp.name];
}

- (void)dealloc {
	[self.name release];
	[self.imageName release];
	[self.description release];
	[super dealloc];
}

@end
