//
//  RSPlaylistStats.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-26.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGroupedStats.h"
#import "RSPlaylistMetadata.h"


@interface RSPlaylistStats : RSGroupedStats <NSCoding> {
	
	RSPlaylistMetadataItem *playlistInfo;
}

@property (nonatomic,retain) RSPlaylistMetadataItem *playlistInfo;

- (id)initWithAPIData:(NSDictionary *)apiData metadata:(RSPlaylistMetadata*)mData;

@end
