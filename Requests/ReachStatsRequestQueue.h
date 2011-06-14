//
//  ReachStatsRequestQueue.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-18.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReachStatsRequest.h"


@interface ReachStatsRequestQueue : NSObject <ReachStatsRequestDelegate> {
    
    NSMutableArray *requests;
    NSOperationQueue *queue;
}

@property (nonatomic,retain) NSMutableArray *requests;
@property (nonatomic,retain) NSOperationQueue *queue;

- (void)addRequest:(ReachStatsRequest *)request;

@end
