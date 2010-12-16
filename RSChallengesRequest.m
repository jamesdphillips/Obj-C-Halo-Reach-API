//
//  RSChallengesRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-18.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallengesRequest.h"


@implementation RSChallengesRequest

- (id)initWithGamertag:(NSString*)_gamertag delegate:(id)_delegate {
	if ( self = [super initWithDelegate:_delegate] ) {
		[self setGamertag:_gamertag];
	}
	return self;
}

- (id)initWithGamertag:(NSString *)_gamertag {
	return [self initWithGamertag:_gamertag delegate:nil];
}

- (void)setGamertag:(NSString*)_gamertag {
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com:8124/challenges/%@",
				  [_gamertag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

- (id)handleResponse:(id)dict {
	return [[[RSChallenges alloc] initWithAPIData:dict] autorelease];
}

+ (RSChallenges *)challengesWithGamertag:(NSString*)gamertag {
	ReachStatsRequest *request = [[[self class] alloc] initWithGamertag:gamertag];
	id response = [request startSynchronous];
	[request release];
	return response;
}

+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(ASIHTTPRequest*)request {
	if ( [request responseStatusCode] == 200 || [request didUseCachedResponse] ) {
		return nil;
	}
	return @"Unable to contact server!";
}

@end
