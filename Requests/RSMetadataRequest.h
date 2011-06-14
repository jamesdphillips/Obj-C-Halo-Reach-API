//
//  RSMetadataRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-22.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"


@interface RSMetadataRequest : ReachStatsRequest {
	
	NSString *method;
	NSUInteger maxAge;
}

@property (nonatomic,copy) NSString *method;
@property (nonatomic) NSUInteger maxAge;

- (id)initWithMethod:(NSString *)_method delegate:(id)_delegate;
- (id)initWithMethod:(NSString *)_method;
+ (NSDictionary*)get;
+ (NSDictionary*)getWithMethod:(NSString*)_method;

@end
