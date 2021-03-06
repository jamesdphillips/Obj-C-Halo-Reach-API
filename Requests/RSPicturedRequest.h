//
//  RSPicturedRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-26.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


@interface RSPicturedRequest : ReachStatsRequest { }

- (id)initWithFileID:(NSUInteger)FID withDelegate:(id)_delegate;
- (id)initWithFileID:(NSUInteger)FID;
+ (NSArray*)picturedParticipantsWithFileID:(NSUInteger)FID;
- (void)setFileID:(NSUInteger)FID;

@end
