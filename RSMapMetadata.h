//
//  RSMapMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSMapMetadata : NSObject <NSCoding> {
	
	// ID
	NSUInteger identifier;
	
	// Description
	NSString *name;
	NSString *imageName;
	NSString *mapType;
	
}

@property (nonatomic) NSUInteger identifier;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *imageName;
@property (copy,nonatomic) NSString *mapType;

- (id)initWithAPIData:(NSDictionary *)data;
+ (id)mapMetadataWithAPIData:(NSDictionary*)data;
- (NSString *)derpWithSize:(NSString*)imageSize;
- (NSString *)imageURLWithSize:(NSString*)size;
- (NSString *)imageURL;

@end
