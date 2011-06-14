//
//  RSChallengeMetadataRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-01.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMetadataRequest.h"


@class RSChallengeMetadata;

@interface RSChallengeMetadataRequest : RSMetadataRequest { }

- (id)initWithChallengeTitle:(NSString*)title;
- (id)initWithChallengeTitle:(NSString*)title delegate:(id)_delegate;
- (void)setChallengeTitle:(NSString*)title;
+ (RSChallengeMetadata*)metadataWithChallengeTitle:(NSString*)title;

@end
