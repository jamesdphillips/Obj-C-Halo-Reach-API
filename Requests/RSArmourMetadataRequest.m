//
//  RSArmourMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-20.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSArmourMetadataRequest.h"
#import "RSArmourMetadata.h"


@implementation RSArmourMetadataRequest

- (id)init {
	return [super initWithMethod:@"armour" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"armour" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithCapacity:[dict count]];
	for ( NSString *key in [dict allKeys] ) {
        NSArray *items = [dict objectForKey:key];
        NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[items count]];
        for ( NSDictionary *item in items ) {
            RSArmourMetadata *m = [[[RSArmourMetadata alloc] initWithAPIData:item] autorelease];
            [objects addObject:m];
        }
        [metadata setObject:objects forKey:key];
	}
	return [super handleResponse:metadata];
}

@end
