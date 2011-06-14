//
//  RSGameVariantMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameVariantMetadataRequest.h"


@implementation RSGameVariantMetadataRequest

- (id)init {
	return [super initWithMethod:@"game_variants" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"game_variants" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithCapacity:[dict count]];
	for ( NSDictionary *c in dict ) {
		id key = [c objectForKey:@"Value"];
		id value = [c objectForKey:@"Key"];
		[metadata setObject:key
					 forKey:value];
	}
	return [super handleResponse:metadata];
}

@end
