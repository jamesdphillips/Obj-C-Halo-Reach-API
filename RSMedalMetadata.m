//
//  RSMedalMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMedalMetadata.h"


@implementation RSMedalMetadata

@synthesize identifier;
@synthesize name, description, imageName;

- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( self = [super init] ) {
		
		self.identifier = [[data objectForKey:@"Id"] intValue];
		
		self.name = [data objectForKey:@"Name"];
		self.description = [data objectForKey:@"Description"];
		self.imageName = [data objectForKey:@"ImageName"];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
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

+ (id)medalMetadataWithAPIData:(NSDictionary*)data {
	return [[[RSMedalMetadata alloc] initWithAPIData:data] autorelease];
}

- (NSString *)imageURLWithSize:(NSString*)size doubled:(BOOL)doubled {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/medals/%@/%d%@.png",size,self.identifier,(doubled ? @"@2x" : @"")];
}

- (NSString *)doubleSizedThumbnailURL {
	return [self imageURLWithSize:@"thumb" doubled:YES];
}

- (NSString *)thumbnailImageURL {
	return [self imageURLWithSize:@"thumb" doubled:NO];
}

- (NSString *)imageURLWithSize:(NSString *)size {
	return [self imageURLWithSize:size doubled:YES];
}

- (NSString *)imageURL {
	return [self imageURLWithSize:@"small" doubled:YES];
}

- (void)dealloc {
	[self.name release];
	[self.description release];
	[self.imageName release];
	[super dealloc];
}

@end
