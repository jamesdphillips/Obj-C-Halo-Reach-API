//
//  RSGameDetailsRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-15.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"
#import "RSGameDetails.h"


extern NSString * const rsGameDetailsPath;


@interface RSGameDetailsRequest : ReachStatsRequest {
	
	NSString *filePath;
}

@property (nonatomic,copy) NSString *filePath;

+ (RSGameDetails *)gameDetailsWithGID:(NSUInteger)GID;
- (id)initWithGameID:(NSUInteger)GID;
- (void)setGameID:(NSUInteger)gameID;
- (RSGameDetails*)checkForSavedCopy;

@end
