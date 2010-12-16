//
//  RSScreenshotsRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-16.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


extern NSString * const rsScreenshotsPath;


@interface RSScreenshotsRequest : ReachStatsRequest { }

- (id)initWithGamertag:(NSString *)_gamertag;
- (id)initWithGamertag:(NSString *)_gamertag delegate:(id)_delegate;
- (void)setGamertag:(NSString *)_gamertag;
+ (NSDictionary*)screensWithGamertag:(NSString*)_gamertag;

@end