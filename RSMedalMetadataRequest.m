//
//  RSMedalMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMedalMetadataRequest.h"


@implementation RSMedalMetadataRequest

- (id)init {
	return [super initWithMethod:@"medals" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"medals" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithCapacity:[dict count]];
	for ( NSDictionary *c in dict ) {
		id key = [c objectForKey:@"Key"];
		NSDictionary *value = [c objectForKey:@"Value"];
		[metadata setObject:[RSMedalMetadata medalMetadataWithAPIData:value]
					 forKey:key];
	}
	return [super handleResponse:metadata];
}

@end
