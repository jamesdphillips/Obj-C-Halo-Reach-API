//
//  RSFileShareRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-26.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


@interface RSFileShareRequest : ReachStatsRequest { }

- (void)setGamertag:(NSString *)_gamertag;
+ (NSDictionary*)fileShareWithGamertag:(NSString*)_gamertag;

@end
