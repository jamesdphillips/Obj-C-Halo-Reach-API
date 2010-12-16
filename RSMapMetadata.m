//
//  RSMapMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMapMetadata.h"


@implementation RSMapMetadata

@synthesize identifier;
@synthesize name, imageName, mapType;

- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( self = [super init] ) {
		
		self.identifier = [[data objectForKey:@"Id"] intValue];
		
		self.name = [data objectForKey:@"Name"];
		self.imageName = [data objectForKey:@"ImageName"];
		self.mapType = [data objectForKey:@"MapType"];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.identifier = [aDecoder decodeIntForKey:@"i"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.imageName = [aDecoder decodeObjectForKey:@"iN"];
		self.mapType = [aDecoder decodeObjectForKey:@"mT"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.identifier forKey:@"i"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.imageName forKey:@"iN"];
	[aCoder encodeObject:self.mapType forKey:@"mT"];
}

+ (id)mapMetadataWithAPIData:(NSDictionary*)data {
	return [[[RSMapMetadata alloc] initWithAPIData:data] autorelease];
}

- (NSString *)derpWithSize:(NSString*)imageSize {
	if ([self.mapType isEqualToString:@"cp"]) {
		NSString *mn = [[self.name stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
		return [NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/%@_%@.jpg",imageSize,self.mapType,mn];
	}
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/%@.jpg",imageSize,self.imageName];
}

- (NSString *)imageURLWithSize:(NSString*)imageSize {
	if ([self.mapType isEqualToString:@"cp"]) {
		NSString *mn = [[self.name stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
		return [NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/%@_%@.jpg",imageSize,self.mapType,mn];
	}
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/maps/%@/%@.jpg",imageSize,self.imageName];
}

- (NSString *)imageURL {
	return [self imageURLWithSize:@"thumbs"];
}

- (void)dealloc {
	[self.name release];
	[self.imageName release];
	[self.mapType release];
	[super dealloc];
}

@end
