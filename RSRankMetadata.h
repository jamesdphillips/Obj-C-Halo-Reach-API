//
//  RSRankMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//


@interface RSRankMetadata : NSObject {
	NSString *key;
	NSString *name;
	NSUInteger credits;
}

- (id)initWithAPIData:(NSDictionary*)apiData;
- (NSURL *)image;

@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *name;
@property (nonatomic) NSUInteger credits;

@end
