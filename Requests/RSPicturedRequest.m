//
//  RSPicturedRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-26.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSPicturedRequest.h"


@implementation RSPicturedRequest

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

- (id)startSynchronous {
	
	// If already cached.. no point..
	id cached = [self getCachedResponse];
	if ( [cached isKindOfClass:[NSArray class]] ) {
		return [self handleResponse:cached];
	} else {
		return [super startSynchronous];
	}
}

+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(NSHTTPURLResponse *)_httpResponse {
	if ( [_httpResponse statusCode] == 200 ) {
		if ([_response isKindOfClass:[NSArray class]]) {
			return nil;
		}
		return @"Invalid Response";
	}
	return @"Unable to contact the API!";
}

+ (NSArray*)picturedParticipantsWithFileID:(NSUInteger)FID {
	RSPicturedRequest *rqst = [[[self class] alloc] initWithFileID:FID];
	[rqst startSynchronous];
	NSArray *r = [rqst response];
	[rqst release];
	return r;
}

- (void)setFileID:(NSUInteger)FID {
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com/pictured/%d",FID]];
}

@end
