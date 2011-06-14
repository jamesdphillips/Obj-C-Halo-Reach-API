//
//  RSChallengeMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-01.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSChallengeMetadataRequest.h"
#import "RSChallengeMetadata.h"


@implementation RSChallengeMetadataRequest

- (id)initWithChallengeTitle:(NSString*)title {
	return [self initWithChallengeTitle:title delegate:nil];
}

- (id)initWithChallengeTitle:(NSString*)title delegate:(id)_delegate {
	if ( (self = [super initWithDelegate:_delegate]) ) {
		[self setChallengeTitle:title];
	}
	return self;
}

- (void)setChallengeTitle:(NSString*)title {
	[self setMethod:[NSString stringWithFormat:@"challenge_help_%@",[[self hashForUniqueKey:title] lowercaseString]]];
}

- (id)handleResponse:(id)dict {
	RSChallengeMetadata *metadata = [RSChallengeMetadata metadataWithAPIData:dict];
	return [super handleResponse:metadata];
}

+ (RSChallengeMetadata*)metadataWithChallengeTitle:(NSString*)title {
	RSChallengeMetadataRequest *rqst = [[RSChallengeMetadataRequest alloc] initWithChallengeTitle:title];
	[rqst startSynchronous];
	RSChallengeMetadata *r = [rqst response];
	[rqst release];
	return r;
}

@end
