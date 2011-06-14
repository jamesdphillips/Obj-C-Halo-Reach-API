//
//  RSFileDetailsRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-04.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSFileDetailsRequest.h"
#import "ReachStatsService.h"
#import "RSFile.h"

/**
 Screenshots path
 **/
NSString * const rsFileDetailsPath = @"file/details/";


/**
 Reach API Screenshots request.
 Get data from the api with a given gamertag.
 **/
@implementation RSFileDetailsRequest


/**
 Initialze with gamertag and delegate
 **/
- (id)initWithFileID:(NSUInteger)_fileID delegate:(id)_delegate {
	
	if ( (self = [super initWithDelegate:_delegate]) ) {
		[self setFileID:_fileID];
	}
	return self;
}


/**
 Initialize with gamertag
 **/
- (id)initWithFileID:(NSUInteger)_fileID {
	return [self initWithFileID:_fileID delegate:nil];
}


/**
 Set gamertag
 **/
- (void)setFileID:(NSUInteger)_fileID {
	[self setURL:[NSString stringWithFormat:@"%@%@%@/%d",
				  rsBaseURI,
				  rsFileDetailsPath,
				  rsAPIKey,
				  _fileID]];
}

- (id)handleResponse:(NSDictionary *)dict {
	NSArray *filesAry = [dict objectForKey:@"Files"];
	RSFile *fileDetails = nil;
	if ( [filesAry isKindOfClass:[NSArray class]] ) {
		if ( [filesAry count] > 0 )
			fileDetails = [[[RSFile alloc] initWithDictionary:[filesAry objectAtIndex:0]] autorelease];
	}
	return [super handleResponse:fileDetails];
}

/**
 * 
 */
+ (RSFile*)fileDetailsWithFileID:(NSUInteger)fileID {
	RSFileDetailsRequest *rqst = [[RSFileDetailsRequest alloc] initWithFileID:fileID];
	[rqst startSynchronous];
	RSFile *file = [rqst response];
	[rqst release];
	return file;
}

@end
