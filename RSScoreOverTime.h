//
//  RSPointsOverTime.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSScoreOverTime : NSObject <NSCoding> {
	NSUInteger time;
	NSUInteger score;
}

@property (nonatomic) NSUInteger time;
@property (nonatomic) NSUInteger score;

- (id)initWithTime:(NSUInteger)t score:(NSUInteger)s;
+ (RSScoreOverTime *)scoreOverTimeWithTime:(NSUInteger)t score:(NSUInteger)s;

@end