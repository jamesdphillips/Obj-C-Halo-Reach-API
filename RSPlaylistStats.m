//
//  RSPlaylistStats.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-26.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlaylistStats.h"


@implementation RSPlaylistStats

@synthesize playlistInfo;

- (id)initWithAPIData:(NSDictionary *)apiData metadata:(RSPlaylistMetadata*)mData {
	if ( self = [super initWithAPIData:apiData] ) {
		self.playlistInfo = [mData playlistWithID:self.hopperID];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super initWithCoder:aDecoder] ) {
		self.playlistInfo = [aDecoder decodeObjectForKey:@"playlistInfo"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.playlistInfo forKey:@"playlistInfo"];
}

- (void)dealloc {
	self.playlistInfo = nil;
	[super dealloc];
}

@end
