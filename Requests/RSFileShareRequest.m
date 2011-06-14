//
//  RSFileShareRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-01-26.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSFileShareRequest.h"
#import "ReachStatsService.h"
#import "RSFile.h"
#import "RFC3875+NSString.h"


/**
 Screenshots path
 **/
//NSString * const rsFileSharePath = @"file/screenshots/";

/**
 File Share Request
 **/
@implementation RSFileShareRequest

/**
 Initialze with gamertag and delegate
 **/
- (id)initWithGamertag:(NSString *)_gamertag delegate:(id)_delegate {
	
	if ( (self = [super initWithDelegate:_delegate]) ) {
		[self setGamertag:_gamertag];
	}
	return self;
}

/**
 Initialize with gamertag
 **/
- (id)initWithGamertag:(NSString*)_gamertag {
	[self initWithGamertag:_gamertag delegate:nil];
	return self;
}

/**
 Set gamertag
 **/
- (void)setGamertag:(NSString *)_gamertag {
	[self setURL:[NSString stringWithFormat:@"%@%@%@/%@",
				  rsBaseURI,
				  rsFileSharePath,
				  rsAPIKey,
				  [_gamertag stringByAddingRFC3875PercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}

- (id)handleResponse:(NSDictionary *)dict {
	NSArray *filesDict = [dict objectForKey:@"Files"];
	NSMutableDictionary *files = [NSMutableDictionary dictionaryWithCapacity:[filesDict count]];
	for ( NSDictionary *f in filesDict ) {
		RSFile *file = [[[RSFile alloc] initWithDictionary:f] autorelease];
		[files setObject:file forKey:[f objectForKey:@"FileId"]];
	}
	return [super handleResponse:files];
}

/**
 Get fileshare syncronously for given gamertag
 **/
+ (NSDictionary*)fileShareWithGamertag:(NSString*)_gamertag {
	RSFileShareRequest *rqst = [[[self class] alloc] initWithGamertag:_gamertag];
	[rqst startSynchronous];
	NSDictionary *share = [rqst response];
	[rqst release];
	return share;
}

@end
