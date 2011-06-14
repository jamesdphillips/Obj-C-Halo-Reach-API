//
//  RSRenderedVideoLinksRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-26.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


@interface RSRenderedVideoLinksRequest : ReachStatsRequest { }

- (id)initWithFileID:(NSUInteger)FID withDelegate:(id)_delegate;
- (id)initWithFileID:(NSUInteger)FID;
+ (NSDictionary*)videoLinksWithFileID:(NSUInteger)FID;
- (void)setFileID:(NSUInteger)FID;

@end
