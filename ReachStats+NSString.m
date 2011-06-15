//
//  ReachStats+NSString.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-25.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStats+NSString.h"


@implementation NSString (ReachStatsAdditions)

+ (NSString*)commaDelimitedStringWithNumber:(NSUInteger)num {
	NSNumberFormatter *frmtr = [[NSNumberFormatter alloc] init];
	[frmtr setGroupingSize:3];
	[frmtr setGroupingSeparator:@","];
	[frmtr setUsesGroupingSeparator:YES];
	NSString *commaString = [frmtr stringFromNumber:[NSNumber numberWithInt:num]];
	[frmtr release];
	return commaString;
}

+ (NSString*)commaDelimitedCreditsStringWithNumber:(NSUInteger)num {
	return [[NSString commaDelimitedStringWithNumber:num] stringByAppendingString:@" cR"];
}

@end
