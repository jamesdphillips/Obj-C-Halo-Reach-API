//
//  ReachStatsService.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

extern NSString * const rsAPIKey;
extern NSString * const rsBaseURI;
extern NSString * const rsAelatisReachURI;
extern NSString * const rsMetadataPath;
extern NSString * const rsFileSharePath;
extern NSString * const rsFileDetailsPath;


@interface ReachStatsService : NSObject {

}

+ (NSString *)applicationDocumentsDirectory;

+ (NSDate*)formatBungieDate:(NSString*)bungieFailDate;
+ (NSString*)formatDate:(NSDate*)date format:(NSString *)dateFormat;
+ (NSString*)defaultFormatDate:(NSDate*)date;

@end
