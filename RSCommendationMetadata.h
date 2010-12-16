//
//  RSCommendationMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSCommendationMetadata : NSObject <NSCoding> {
	
	// Identifier
	NSUInteger ID;
	
	// Levels
	NSUInteger iron;
	NSUInteger bronze;
	NSUInteger silver;
	NSUInteger gold;
	NSUInteger onyx;
	NSUInteger max;
	
	// Description
	NSString *name;
	NSString *description;
}

@property (nonatomic) NSUInteger ID;

@property (nonatomic) NSUInteger iron;
@property (nonatomic) NSUInteger bronze;
@property (nonatomic) NSUInteger silver;
@property (nonatomic) NSUInteger gold;
@property (nonatomic) NSUInteger onyx;
@property (nonatomic) NSUInteger max;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *description;

- (id)initWithAPIData:(NSDictionary *)data;
+ (RSCommendationMetadata *)commendationsWithAPIData:(NSDictionary *)data;

@end
