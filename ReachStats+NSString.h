//
//  ReachStats+NSString.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (ReachStatsAdditions)

+ (NSString*)commaDelimitedStringWithNumber:(NSUInteger)num;
+ (NSString*)commaDelimitedCreditsStringWithNumber:(NSUInteger)num;

@end
