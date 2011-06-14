//
//  ReachStatsRequestQueue.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-18.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequestQueue.h"
#import "ReachStatsRequest.h"

@implementation ReachStatsRequestQueue

@synthesize requests;
@synthesize queue;

- (id)initWithRequests:(NSMutableArray *)_requests {
    if ( (self = [super init]) ) {
        self.requests = [NSMutableArray array];
        self.queue = [NSOperationQueue currentQueue];
        
        for ( ReachStatsRequest *r in _requests) {
            [self addRequest:r];
        }
    }
    return self;
}

- (void)dealloc {
    self.requests = nil;
    self.queue = nil;
    [super dealloc];
}

- (void)addRequest:(ReachStatsRequest *)request {
    [self.requests addObject:request];
}

- (void)start {
    
}

- (void)requestCompletedWithResponse:(id)response {
    // ...
}

- (void)requestFailedWithError:(NSString*)errorMessage {
    // ...
}

@end
