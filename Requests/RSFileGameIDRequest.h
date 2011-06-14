//
//  RSFileGameIDRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-19.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


@interface RSFileGameIDRequest : ReachStatsRequest

- (id)initWithFileID:(NSUInteger)FID withDelegate:(id)_delegate;
- (id)initWithFileID:(NSUInteger)FID;
+ (NSUInteger)gameIDWithFileID:(NSUInteger)FID;
- (void)setFileID:(NSUInteger)FID;

@end
