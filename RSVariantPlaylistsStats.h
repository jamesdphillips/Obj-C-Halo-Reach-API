//
//  RSVariantPlaylistsStats.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-26.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlaylistStats.h"


@interface RSVariantPlaylistsStats : NSObject <NSCoding> {
	
	NSUInteger variantID;
	NSMutableDictionary *playlistStats;
	
	NSUInteger medals;
	NSUInteger gamesPlayed;
	NSUInteger assists;
	NSUInteger betrayals;
	NSUInteger deaths;
	NSUInteger firstPlace;
	NSUInteger kills;
	NSUInteger playtime;
	NSUInteger score;
	NSUInteger placedTopHalf;
	NSUInteger placedTopThird;
	NSUInteger wins;
}

@property (nonatomic) NSUInteger variantID;
@property (nonatomic,retain) NSMutableDictionary *playlistStats;
@property (nonatomic) NSUInteger medals;
@property (nonatomic) NSUInteger gamesPlayed;
@property (nonatomic) NSUInteger assists;
@property (nonatomic) NSUInteger betrayals;
@property (nonatomic) NSUInteger deaths;
@property (nonatomic) NSUInteger firstPlace;
@property (nonatomic) NSUInteger kills;
@property (nonatomic) NSUInteger playtime;
@property (nonatomic) NSUInteger score;
@property (nonatomic) NSUInteger placedTopHalf;
@property (nonatomic) NSUInteger placedTopThird;
@property (nonatomic) NSUInteger wins;

- (id)initWithVariantID:(NSUInteger)ID playlist:(RSPlaylistStats*)playlist;
- (id)initWithPlaylist:(RSPlaylistStats*)playlist;
- (id)initWithVariantID:(NSUInteger)ID;
- (void)addPlaylist:(RSPlaylistStats*)playlist;

@end
