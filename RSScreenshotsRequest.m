//
//  RSScreenshotsRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-16.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSScreenshotsRequest.h"
#import "ReachStatsService.h"
#import "RSFile.h"


/**
 Screenshots path
 **/
NSString * const rsScreenshotsPath = @"file/screenshots/";


/**
 Reach API Screenshots request.
 Get data from the api with a given gamertag.
 **/
@implementation RSScreenshotsRequest


/**
 Initialze with gamertag and delegate
 **/
- (id)initWithGamertag:(NSString *)_gamertag delegate:(id)_delegate {
	
	if ( self = [super initWithDelegate:_delegate] ) {
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
				  rsScreenshotsPath,
				  rsAPIKey,
				  [_gamertag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
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

+ (NSDictionary*)screensWithGamertag:(NSString*)_gamertag {
	RSScreenshotsRequest *rqst = [[RSScreenshotsRequest alloc] initWithGamertag:_gamertag];
	[rqst startSynchronous];
	NSDictionary *screens = [rqst response];
	[rqst release];
	return screens;
}

@end
