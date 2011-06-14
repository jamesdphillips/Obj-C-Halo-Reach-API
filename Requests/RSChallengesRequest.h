//
//  RSChallengesRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-18.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"
#import "RSChallenges.h"


@interface RSChallengesRequest : ReachStatsRequest

- (void)setGamertag:(NSString*)_gamertag;
+ (RSChallenges *)challengesWithGamertag:(NSString*)gamertag;

@end
