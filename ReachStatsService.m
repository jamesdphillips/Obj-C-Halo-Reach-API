//
//  ReachStatsService.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsService.h"


/**
 * Constants
 */
NSString * const rsAPIKey = @"";
NSString * const rsBaseURI = @"http://www.bungie.net/api/reach/reachapijson.svc/";
NSString * const rsAelatisReachURI = @"http://reachstats.aelatis.com";
NSString * const rsMetadataPath = @"game/metadata/";
NSString * const rsFileSharePath = @"file/share/";


/**
 Provides basic constants and helpers
 **/
@implementation ReachStatsService


/**
 Provides the base directory to save cached data
 **/
+ (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


/**
 Provides an NSDate for the provided bungie API data format
 **/
+ (NSDate*)formatBungieDate:(NSString*)bungieFailDate {
	//NSString *dateString = [[bungieFailDate stringByReplacingOccurrencesOfString:@"/Date(" withString:@""] stringByReplacingOccurrencesOfString:@"-0700)/" withString:@""];
	NSString *dateString = [bungieFailDate substringWithRange:NSMakeRange(6, 13)];
	NSTimeInterval date = [dateString doubleValue] / 1000.0;
	return [NSDate dateWithTimeIntervalSince1970:date];
}


/**
 Provides a formatted date string for the provided date
 **/
+ (NSString*)formatDate:(NSDate*)date format:(NSString *)dateFormat {
	NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *ret = [formatter stringFromDate:date];
    [formatter release];
    [cal release];
    return ret;
}

/**
 Use this API default data format
 */
+ (NSString*)defaultFormatDate:(NSDate*)date {
	return [ReachStatsService formatDate:date format:@"yyyy-MM-dd hh:mm a zz"];
}

@end
