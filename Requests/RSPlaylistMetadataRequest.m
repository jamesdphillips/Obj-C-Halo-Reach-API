//
//  RSPlaylistMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlaylistMetadataRequest.h"


@implementation RSPlaylistMetadataRequest

- (id)init {
	return [super initWithMethod:@"playlists" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"playlists" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	RSPlaylistMetadata *metadata = [[[RSPlaylistMetadata alloc] initWithAPIData:dict] autorelease];
	return [super handleResponse:metadata];
}

+ (RSPlaylistMetadata*)get {
	return (RSPlaylistMetadata*)[super get];
}

@end
