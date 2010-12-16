//
//  RSCommendationCreditsMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-24.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCommendationCreditsMetadataRequest.h"


@implementation RSCommendationCreditsMetadataRequest

- (id)init {
	return [super initWithMethod:@"commendation_credits" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"commendation_credits" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithCapacity:[dict count]];
	for ( NSDictionary *c in dict ) {
		id key = [c objectForKey:@"key"];
		[metadata setObject:[[[RSCommendationCreditsMetadata alloc] initWithAPIData:c] autorelease]
					 forKey:key];
	}
	return [super handleResponse:metadata];
}

@end
