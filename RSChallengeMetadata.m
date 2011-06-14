//
//  RSChallengeMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-01.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallengeMetadata.h"


@implementation RSChallengeMetadata

@synthesize name;
@synthesize helpfulText, helpfulVideos, helpfulLinks;

- (id)initWithAPIData:(NSDictionary*)data {
	if ( (self = [super init]) ) {
		self.name = [data objectForKey:@"name"];
		self.helpfulText =   [[data objectForKey:@"text"] isKindOfClass:[NSArray class]]   ? [data objectForKey:@"text"]   : nil;
		self.helpfulVideos = [[data objectForKey:@"videos"] isKindOfClass:[NSArray class]] ? [data objectForKey:@"videos"] : nil;
		self.helpfulLinks =  [[data objectForKey:@"links"] isKindOfClass:[NSArray class]]  ? [data objectForKey:@"links"]  : nil;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.helpfulText = [aDecoder decodeObjectForKey:@"hT"];
		self.helpfulVideos = [aDecoder decodeObjectForKey:@"hV"];
		self.helpfulLinks = [aDecoder decodeObjectForKey:@"hL"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.helpfulText forKey:@"hT"];
	[aCoder encodeObject:self.helpfulVideos forKey:@"hV"];
	[aCoder encodeObject:self.helpfulLinks forKey:@"hL"];
}

+ (RSChallengeMetadata*)metadataWithAPIData:(NSDictionary*)data {
	return [[[RSChallengeMetadata alloc] initWithAPIData:data] autorelease];
}

- (void)dealloc {
	[self.name release];
	[self.helpfulText release];
	[self.helpfulVideos release];
	[self.helpfulLinks release];
	[super dealloc];
}

@end
