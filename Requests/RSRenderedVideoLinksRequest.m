//
//  RSRenderedVideoLinksRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-26.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSRenderedVideoLinksRequest.h"


@implementation RSRenderedVideoLinksRequest

- (id)initWithFileID:(NSUInteger)FID withDelegate:(id)_delegate {
	if ((self = [super initWithDelegate:_delegate])) {
		[self setFileID:FID];
	}
	return self;
}

- (id)initWithFileID:(NSUInteger)FID {
	if ((self = [super initWithDelegate:nil])) {
		[self setFileID:FID];
	}
	return self;
}

- (id)handleResponse:(id)dict {
	self.response = dict;
	[super handleResponse:dict];
	return self.response;
}

+ (NSDictionary*)videoLinksWithFileID:(NSUInteger)FID {
	id rqst = [[[self class] alloc] initWithFileID:FID];
	[(RSRenderedVideoLinksRequest*)rqst startSynchronous];
	NSDictionary *r = [(RSRenderedVideoLinksRequest*)rqst response];
	[rqst release];
	return r;
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

- (void)setFileID:(NSUInteger)FID {
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com/video_links/%d",FID]];
}

@end
