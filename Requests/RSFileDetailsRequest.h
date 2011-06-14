//
//  RSFileDetailsRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-04.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


extern NSString * const rsFileDetailsPath;

@class RSFile;

@interface RSFileDetailsRequest : ReachStatsRequest { }

- (id)initWithFileID:(NSUInteger)_fileID delegate:(id)_delegate;
- (id)initWithFileID:(NSUInteger)_fileID;
- (void)setFileID:(NSUInteger)_fileID;
+ (RSFile*)fileDetailsWithFileID:(NSUInteger)fileID;

@end
