//
//  RSPlaylistMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSPlaylistMetadataItem : NSObject <NSCoding> {
	
	NSUInteger ID;
	NSString *name;
	NSString *description;
	BOOL isTeamPlaylist;
	
	NSUInteger maxLocalPlayers;
	NSUInteger maxPartySize;
	
	NSArray *maps;
	NSArray *gametypes;
}

@property (nonatomic) NSUInteger ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *description;
@property (nonatomic) BOOL isTeamPlaylist;
@property (nonatomic) NSUInteger maxLocalPlayers;
@property (nonatomic) NSUInteger maxPartySize;
@property (nonatomic,copy) NSArray *maps;
@property (nonatomic,copy) NSArray *gametypes;

- (id)initWithAPIData:(NSDictionary*)data;
- (NSString *)imageURL;
- (NSString *)twoTimesScaleImageURL;

@end


@interface RSPlaylistMetadata : NSObject <NSCoding> {
	
	NSDictionary *playlists;
}

@property (nonatomic,copy) NSDictionary *playlists;

- (id)initWithAPIData:(NSArray *)data;
- (RSPlaylistMetadataItem*)playlistWithID:(NSUInteger)ID;

@end
