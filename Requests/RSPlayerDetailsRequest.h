//
//  RSPlayerDetailsRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-17.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"
#import "RSPlayerDetails.h"


extern NSString * const rsPlayerDetailsPath;


@interface RSPlayerDetailsRequest : ReachStatsRequest { }

- (id)initWithGamertag:(NSString*)_gamertag delegate:(id)_delegate;
- (id)initWithGamertag:(NSString *)_gamertag;
- (void)setGamertag:(NSString*)_gamertag;

+ (RSPlayerDetails *)playerWithGamertag:(NSString*)gamertag;

@end
