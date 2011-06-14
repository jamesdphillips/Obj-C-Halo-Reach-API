//
//  RSPlayerDetailsRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-17.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPlayerDetailsRequest.h"
#import "ReachStatsService.h"
#import "RFC3875+NSString.h"


/**
 PlayerDetails API Path
 **/
NSString * const rsPlayerDetailsPath = @"player/details/";


/**
 PlayerDetails API Request.
 Provides interface to acquire details for given gamertag.
 **/
@implementation RSPlayerDetailsRequest


/**
 Initialize with gamertag and delegate
 **/
- (id)initWithGamertag:(NSString*)_gamertag delegate:(id)_delegate {
	if ( (self = [super initWithDelegate:_delegate]) ) {
		[self setGamertag:_gamertag];
	}
	return self;
}


/**
 Initialize with gamertag
 **/
- (id)initWithGamertag:(NSString *)_gamertag {
	return [self initWithGamertag:_gamertag delegate:nil];
}


/**
 Set gamertag
 **/
- (void)setGamertag:(NSString*)_gamertag {
	[self setURL:[NSString stringWithFormat:@"%@%@nostats/%@/%@",
				  rsBaseURI,
				  rsPlayerDetailsPath,
				  rsAPIKey,
				  [_gamertag stringByAddingRFC3875PercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

- (id)handleResponse:(NSDictionary *)dict {
    RSPlayerDetails *playerDetails = nil;
    @try {
        playerDetails = [[[RSPlayerDetails alloc] initWithAPIData:dict] autorelease];
    } @catch (id e) {
        NSLog(@"Error in response");
    }
	return [super handleResponse:playerDetails];
}


/**
 Get Details synchronously
 **/
+ (RSPlayerDetails *)playerWithGamertag:(NSString*)gamertag {
	RSPlayerDetailsRequest *request = [[[self class] alloc] initWithGamertag:gamertag];
	RSPlayerDetails *r = [request startSynchronous];
	[request release];
	return r;
}

@end
