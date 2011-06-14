//
//  RSChallengesCommentaryLinkRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-01.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallengesCommentaryLinkRequest.h"


@implementation RSChallengesCommentaryLinkRequest

- (id)initWithDelegate:(id)_delegate {
	if ( (self = [super initWithDelegate:_delegate]) ) {
		[self setURL:@"http://api.reachservicerecord.com/challenges_commentary/link"];
	}
	return self;
}

- (id)init {
	return [self initWithDelegate:nil];
}

- (id)handleResponse:(id)dict {
	return [super handleResponse:[dict objectForKey:@"link"]];
}

+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(NSHTTPURLResponse *)_httpResponse
{
	if ( [_httpResponse statusCode] == 200 ) {
		if ([_response isKindOfClass:[NSDictionary class]]) {
			return nil;
		}
		return @"Invalid Response";
	}
	return @"Unable to contact the API!";
}

- (NSDictionary*)getCachedResponse {
	return nil;
}

+ (NSString *)get {
	RSChallengesCommentaryLinkRequest *rqst = [[RSChallengesCommentaryLinkRequest alloc] init];
	[rqst startSynchronous];
	NSString *r = [rqst response];
	[rqst release];
	return r;
}

@end
