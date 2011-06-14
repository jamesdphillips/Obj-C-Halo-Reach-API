//
//  RSChallengeMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-02-01.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSChallengeMetadata : NSObject <NSCoding> {
	NSString *name;
	NSArray  *helpfulText;
	NSArray  *helpfulVideos;
	NSArray  *helpfulLinks;
}

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray  *helpfulText;
@property (nonatomic,copy) NSArray  *helpfulVideos;
@property (nonatomic,copy) NSArray  *helpfulLinks;

- (id)initWithAPIData:(NSDictionary*)data;
+ (RSChallengeMetadata*)metadataWithAPIData:(NSDictionary*)data;

@end
