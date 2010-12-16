//
//  RSEnemiesMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSEnemiesMetadata : NSObject <NSCoding> {
	
	// ID
	NSUInteger identifier;
	
	// Description
	NSString *description;
	NSString *imageName;
	NSString *name;
}

@property (nonatomic) NSUInteger identifier;
@property (copy,nonatomic) NSString *description;
@property (copy,nonatomic) NSString *imageName;
@property (copy,nonatomic) NSString *name;

- (id)initWithAPIData:(NSDictionary *)data;
+ (RSEnemiesMetadata *)enemyMetadataWithAPIData:(NSDictionary *)data;
- (NSString*)imageURLWithSize:(BOOL)doubleSize;
- (NSString*)doubleSizedImageURL;
- (NSString*)imageURL;

@end
