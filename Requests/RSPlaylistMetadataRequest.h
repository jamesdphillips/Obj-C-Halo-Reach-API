//
//  RSPlaylistMetadataRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMetadataRequest.h"
#import "RSPlaylistMetadata.h"


@interface RSPlaylistMetadataRequest : RSMetadataRequest { }

+ (RSPlaylistMetadata*)get;

@end
