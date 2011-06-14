//
//  RSWeaponMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSWeaponMetadataRequest.h"


@implementation RSWeaponMetadataRequest

- (id)init {
	return [super initWithMethod:@"weapons" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"weapons" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithCapacity:[dict count]];
	for ( NSDictionary *c in dict ) {
		id key = [c objectForKey:@"Key"];
		NSDictionary *value = [c objectForKey:@"Value"];
		[metadata setObject:[[[RSWeaponMetadata alloc] initWithAPIData:value] autorelease]
					 forKey:key];
	}
	return [super handleResponse:metadata];
}

@end
