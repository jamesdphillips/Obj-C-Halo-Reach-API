//
//  RSRankMetadataRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSMetadataRequest.h"


@interface RSRankMetadataRequest : RSMetadataRequest {
	BOOL asArray;
}
@property (nonatomic) BOOL asArray;
+ (NSArray*)getAsArray;
@end
