//
//  RSFile.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSFile.h"
#import "ReachStatsService.h"


@implementation RSFile

@synthesize ID;
@synthesize author, originalAuthor;
@synthesize title, description;
@synthesize createdAt, updatedAt;
@synthesize category;
@synthesize mapID;
@synthesize fullScreenURL;


#pragma mark -
#pragma mark Initialize
- (id)initWithDictionary:(NSDictionary *)data {
	
	if ( self = [super init] ) {
		
		// ID
		self.ID = [[data objectForKey:@"FileId"] intValue];
		
		// Authors
		self.author = [data objectForKey:@"Author"];
		self.originalAuthor = [data objectForKey:@"OriginalAuthor"];
		
		// Description
		self.title = [data objectForKey:@"Title"];
		self.description = [data objectForKey:@"Description"];
		
		// Date
		self.createdAt = [data objectForKey:@"CreateDate"];
		self.updatedAt = [data objectForKey:@"ModifiedDate"];
		
		// Category
		self.category = [data objectForKey:@"FileCategory"];
		
		// Map
		self.mapID = [[data objectForKey:@"MapId"] intValue];
		
		// Full URL
		self.fullScreenURL = [data objectForKey:@"ScreenshotFullSizeUrl"];
	}
	
	return self;
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.author release];
	[self.originalAuthor release];
	[self.title release];
	[self.description release];
	[self.createdAt release];
	[self.updatedAt release];
	[self.category release];
	[self.fullScreenURL release];
	[super dealloc];
}


#pragma mark -
#pragma mark File Details
- (NSURL *)fileDetailsURL {
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net/stats/reach/filedetails.aspx?fid=%d",self.ID]];
}


#pragma mark -
#pragma mark Screenshot URLs
- (NSURL *)thumbURL {
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net/Stats/Reach/Screenshot.ashx?fid=%d",self.ID]];
}

- (NSURL *)mediumURL {
	return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net/Stats/Reach/Screenshot.ashx?fid=%d&size=medium",self.ID]];
}

- (NSURL *)fullURL {
	
	// Return URL if we have it
	if ( [self.fullScreenURL isKindOfClass:[NSString class]] )
		return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net%@",self.fullScreenURL]];
	
	// Get the URL if it is an image
	else if ( [self.category isEqualToString:@"Image"] ) {
		
		//RSFile *file = [RSScreenshotsRequest getFileDetailsWithFileID:self.ID];
		//self.fullScreenURL = file.fullScreenURL;
		//return [NSURL URLWithString:[NSString stringWithFormat:@"http://www.bungie.net%@",self.fullScreenURL]];
	}
	
	return nil;
}


#pragma mark -
#pragma mark Dates
- (NSDate *)dateCreatedAt {
	return [ReachStatsService formatBungieDate:self.createdAt];
}


#pragma mark -
#pragma mark RSJSONParserDelegate

- (void)parse_FileId:(NSNumber*)fileID {
	self.ID = [fileID intValue];
}

- (void)parse_Author:(NSString*)_author {
	self.author = _author;
}

- (void)parse_OriginalAuthor:(NSString*)_oauthor {
	self.originalAuthor = _oauthor;
}

- (void)parse_Title:(NSString*)_title {
	self.title = _title;
}

- (void)parse_Description:(NSString*)_desc {
	self.description = _desc;
}

- (void)parse_CreateDate:(NSString*)_createdat {
	self.createdAt = _createdat;
}

- (void)parse_ModifiedDate:(NSString*)_moddate {
	self.updatedAt = _moddate;
}

- (void)parse_MapId:(NSNumber*)_mapid {
	self.mapID = [_mapid intValue];
}

- (void)parse_ScreenshotFullSizeUrl:(NSString*)fsurl {
	self.fullScreenURL = fsurl;
}


@end
