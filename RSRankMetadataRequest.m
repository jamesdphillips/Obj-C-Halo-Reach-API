//
//  RSRankMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSRankMetadataRequest.h"
#import "RSRankMetadata.h"


@implementation RSRankMetadataRequest
@synthesize asArray;

- (id)init {
	return [super initWithMethod:@"ranks" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"ranks" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableArray *metadata = [NSMutableArray arrayWithCapacity:[dict count]];
	for ( NSDictionary *c in dict ) [metadata addObject:[[[RSRankMetadata alloc] initWithAPIData:c] autorelease]];
	return [super handleResponse:metadata];
}

- (id)response {
	if (!self.asArray) {
		NSMutableDictionary *r = [NSMutableDictionary dictionaryWithCapacity:[response count]];
		for ( RSRankMetadata *rank in response ) {
			[r setObject:rank forKey:rank.key];
		}
		return r;
	}
	return response;
}

+ (NSArray*)getAsArray {
	RSRankMetadataRequest *r = [[RSRankMetadataRequest alloc] init];
	r.asArray = YES;
	NSArray *m = [r startSynchronous];
	[r release];
	return m;
}

@end
