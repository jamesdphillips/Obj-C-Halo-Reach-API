//
//  RSPlaylistMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlaylistMetadata.h"


@implementation RSPlaylistMetadataItem

@synthesize ID;
@synthesize name;
@synthesize description;
@synthesize isTeamPlaylist;
@synthesize maxLocalPlayers;
@synthesize maxPartySize;
@synthesize maps;
@synthesize gametypes;

- (id)initWithAPIData:(NSDictionary*)data {
	if ( self = [super init] ) {
		self.ID = [[data objectForKey:@"id"] intValue];
		self.name = [data objectForKey:@"name"];
		self.description = [data objectForKey:@"description"];
		self.isTeamPlaylist = [[data objectForKey:@"team"] boolValue];
		self.maxLocalPlayers = [[data objectForKey:@"max_local_players"] intValue];
		self.maxPartySize = [[data objectForKey:@"max_party_size"] intValue];
		self.maps = [data objectForKey:@"maps"];
		self.gametypes = [data objectForKey:@"gametypes"];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.name = [aDecoder decodeObjectForKey:@"n"];
		self.description = [aDecoder decodeObjectForKey:@"d"];
		self.isTeamPlaylist = [aDecoder decodeBoolForKey:@"i"];
		self.maxLocalPlayers = [aDecoder decodeIntForKey:@"mLP"];
		self.maxPartySize = [aDecoder decodeIntForKey:@"mPS"];
		self.maps = [aDecoder decodeObjectForKey:@"m"];
		self.gametypes = [aDecoder decodeObjectForKey:@"g"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.ID forKey:@"I"];
	[aCoder encodeObject:self.name forKey:@"n"];
	[aCoder encodeObject:self.description forKey:@"d"];
	[aCoder encodeBool:self.isTeamPlaylist forKey:@"i"];
	[aCoder encodeInt:self.maxLocalPlayers forKey:@"mLP"];
	[aCoder encodeInt:self.maxPartySize forKey:@"mPS"];
	[aCoder encodeObject:self.maps forKey:@"m"];
	[aCoder encodeObject:self.gametypes forKey:@"g"];
}

- (NSString *)imageURL {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/playlists/%d.jpg",self.ID];
}

- (NSString *)twoTimesScaleImageURL {
	return [NSString stringWithFormat:@"http://i.reachservicerecord.com/playlists/%d2x.jpg",self.ID];
}

- (void)dealloc {
	[self.name release];
	[self.description release];
	[self.maps release];
	[self.gametypes release];
	[super dealloc];
}

@end

@implementation RSPlaylistMetadata

@synthesize playlists;

- (id)initWithAPIData:(NSArray *)data {
	if ( self = [super init] ) {
		NSMutableDictionary *_playlists = [NSMutableDictionary dictionaryWithCapacity:[data count]];
		for ( NSDictionary *playlist in data ) {
			NSNumber *key = [playlist objectForKey:@"id"];
			RSPlaylistMetadataItem *item = [[[RSPlaylistMetadataItem alloc] initWithAPIData:playlist] autorelease];
			[_playlists setObject:item forKey:key];
		}
		self.playlists = _playlists;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( self = [super init] ) {
		self.playlists = [aDecoder decodeObjectForKey:@"p"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.playlists forKey:@"p"];
}

- (RSPlaylistMetadataItem*)playlistWithID:(NSUInteger)ID {
	return [self.playlists objectForKey:[NSNumber numberWithInt:ID]];
}

- (void)dealloc {
	[self.playlists release];
	[super dealloc];
}

@end

