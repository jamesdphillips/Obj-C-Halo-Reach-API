//
//  RSCreditsRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-23.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


@interface RSCreditsRequest : ReachStatsRequest {
	
	NSString *gamertag;
	NSUInteger cachedResponseIfYoungerThan;
	NSTimeInterval lastModified;
}

@property (nonatomic,copy) NSString *gamertag;
@property (nonatomic) NSUInteger cachedResponseIfYoungerThan;
@property (nonatomic) NSTimeInterval lastModified;

- (id)initWithDelegate:(id)_delegate gamertag:(NSString*)tag age:(NSUInteger)age lastModified:(NSTimeInterval)last;

@end
