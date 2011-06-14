//
//  RSFile.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSFile : NSObject <NSCoding> {
	
	// File ID
	NSUInteger ID;
	
	// Gamertag
	NSString *author;
	NSString *originalAuthor;
	
	// Description
	NSString *title;
	NSString *description;
	
	// Date
	NSString *createdAt; //NSUInteger createdAt;
	NSString *updatedAt; //NSUInteger updatedAt;
	
	// Category
	NSString *category;
	
	// Map
	NSUInteger mapID;
	
	// fullScreenURL
	NSString *fullScreenURL;
	
	// Likes
	NSUInteger likes;
	NSUInteger downloadCount;
	
	// Rendered
	NSString *renderJobResolution;
}

@property (nonatomic) NSUInteger ID;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *originalAuthor;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,copy) NSString *updatedAt;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *fullScreenURL;
@property (nonatomic) NSUInteger mapID;
@property (nonatomic) NSUInteger likes;
@property (nonatomic) NSUInteger downloadCount;
@property (nonatomic,copy) NSString *renderJobResolution;

- (id)initWithDictionary:(NSDictionary *)data;

- (NSDate *)dateCreatedAt;
- (NSURL *)fileDetailsURL;
- (NSURL *)thumbURL;
- (NSURL *)mediumURL;
- (NSURL *)fullURL;

@end
