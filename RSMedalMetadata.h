//
//  RSMedalMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSMedalMetadata : NSObject <NSCoding> {
	
	// ID
	NSUInteger identifier;
	
	// Description
	NSString *name;
	NSString *description;
	NSString *imageName;
	
}

@property (nonatomic) NSUInteger identifier;

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *description;
@property (copy,nonatomic) NSString *imageName;

- (id)initWithAPIData:(NSDictionary *)data;
+ (id)medalMetadataWithAPIData:(NSDictionary*)data;
- (NSString *)imageURLWithSize:(NSString*)size doubled:(BOOL)doubled;
- (NSString *)doubleSizedThumbnailURL;
- (NSString *)thumbnailImageURL;
- (NSString *)imageURLWithSize:(NSString *)size;
- (NSString *)imageURL;

@end
