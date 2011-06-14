//
//  RSCategorizedMedalMetadataRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-23.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSCategorizedMedalMetadataRequest.h"


@implementation RSCategorizedMedalMetadataRequest

- (id)init {
	return [super initWithMethod:@"categorized_medals" delegate:nil];
}

- (id)initWithDelegate:(id)_delegate {
	return [super initWithMethod:@"categorized_medals" delegate:_delegate];
}

- (id)handleResponse:(id)dict {
	NSMutableDictionary *metadata = [NSMutableDictionary dictionaryWithCapacity:[dict count]];
	for ( NSString *key in [dict allKeys] ) {
		[metadata setObject:[NSMutableArray arrayWithCapacity:[[dict objectForKey:key] count]] forKey:key];
		for ( NSDictionary *mdata in [dict objectForKey:key] ) {
			[[metadata objectForKey:key] addObject:[RSMedalMetadata medalMetadataWithAPIData:mdata]];
		}
	}
	return [super handleResponse:metadata];
}

@end
