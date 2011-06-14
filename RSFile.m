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
@synthesize likes, downloadCount;
@synthesize renderJobResolution;


#pragma mark -
#pragma mark Initialize
- (id)initWithDictionary:(NSDictionary *)data {
	
	if ( (self = [super init]) ) {
		
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
		
		// Image URLs
		self.fullScreenURL = [data objectForKey:@"ScreenshotFullSizeUrl"];
		
		// Likes
		self.likes = [[data objectForKey:@"LikesCount"] intValue];
		self.downloadCount = [[data objectForKey:@"DownloadCount"] intValue];
		
		// rendered
		self.renderJobResolution = [data objectForKey:@"RenderJobResolution"];
	}
	
	return self;
}


#pragma mark -
#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super init]) ) {
		self.ID = [aDecoder decodeIntForKey:@"I"];
		self.author = [aDecoder decodeObjectForKey:@"a"];
		self.originalAuthor = [aDecoder decodeObjectForKey:@"oA"];
		self.title = [aDecoder decodeObjectForKey:@"t"];
		self.description = [aDecoder decodeObjectForKey:@"d"];
		self.createdAt = [aDecoder decodeObjectForKey:@"cA"];
		self.updatedAt = [aDecoder decodeObjectForKey:@"uA"];
		self.category = [aDecoder decodeObjectForKey:@"c"];
		self.mapID = [aDecoder decodeIntForKey:@"mI"];
		self.fullScreenURL = [aDecoder decodeObjectForKey:@"fSU"];
		self.likes = [aDecoder decodeIntForKey:@"l"];
		self.downloadCount = [aDecoder decodeIntForKey:@"dC"];
		self.renderJobResolution = [aDecoder decodeObjectForKey:@"rJR"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:self.ID forKey:@"I"];
	[aCoder encodeObject:self.author forKey:@"a"];
	[aCoder encodeObject:self.originalAuthor forKey:@"oA"];
	[aCoder encodeObject:self.title forKey:@"t"];
	[aCoder encodeObject:self.description forKey:@"d"];
	[aCoder encodeObject:self.createdAt forKey:@"cA"];
	[aCoder encodeObject:self.updatedAt forKey:@"uA"];
	[aCoder encodeObject:self.category forKey:@"c"];
	[aCoder encodeInt:self.mapID forKey:@"mI"];
	[aCoder encodeObject:self.fullScreenURL forKey:@"fSU"];
	[aCoder encodeInt:self.likes forKey:@"l"];
	[aCoder encodeInt:self.downloadCount forKey:@"dC"];
	[aCoder encodeObject:self.renderJobResolution forKey:@"rJR"];
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
	[self.renderJobResolution release];
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

@end
