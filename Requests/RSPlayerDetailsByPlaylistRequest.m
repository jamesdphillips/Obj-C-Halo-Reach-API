//
//  RSPlayerDetailsByPlaylistRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-24.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayerDetailsByPlaylistRequest.h"
#import "ReachStatsService.h"
#import "RFC3875+NSString.h"


@implementation RSPlayerDetailsByPlaylistRequest

/**
 Set gamertag
 **/
- (void)setGamertag:(NSString*)_gamertag {
	[self setURL:[NSString stringWithFormat:@"%@%@byplaylist/%@/%@",
				  rsBaseURI,
				  rsPlayerDetailsPath,
				  rsAPIKey,
				  [_gamertag stringByAddingRFC3875PercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

@end
