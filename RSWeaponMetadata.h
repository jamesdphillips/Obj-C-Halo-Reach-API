//
//  RSWeaponMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSWeaponMetadata : NSObject <NSCoding> {
	
	// ID
	NSUInteger identifier;
	
	// Description
	NSString *name;
	NSString *description;
	
}

@property (nonatomic) NSUInteger identifier;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *description;

- (id)initWithAPIData:(NSDictionary *)data;
+ (id)weaponMetadataWithAPIData:(NSDictionary *)data;
- (NSString*)imageURLWithSize:(BOOL)isDoubleScale;
- (NSString*)imageURL;
- (NSString*)doubleScaleImageURL;

@end
