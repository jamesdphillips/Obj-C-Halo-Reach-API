//
//  ReachStatsServiceRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-15.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import <YAJL/YAJL.h>


@interface ReachStatsRequest : NSObject <ASIHTTPRequestDelegate> {
	
	ASIHTTPRequest *httpRequest;
	YAJLDocument *jsonParser;
	id response;
	id delegate;
}

@property (nonatomic,retain) ASIHTTPRequest *httpRequest;
@property (nonatomic,retain) YAJLDocument *jsonParser;
@property (nonatomic,retain) id response;
@property (nonatomic,assign) id delegate;

- (id)initWithDelegate:(id)_delegate;
- (id)startSynchronous;
- (void)startAsynchronous;

- (id)handleResponse:(id)dict;
- (void)setURL:(NSString *)_url;
- (void)createHTTPRequest;
- (void)createJSONParser;
+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(ASIHTTPRequest*)request;
- (NSDictionary*)checkResponse:(NSDictionary*)rawResponse;
- (void)cacheResponse:(NSDictionary*)rawResponse;
- (NSString*)cacheFileLocationWithUniqueKey:(NSString*)key;
- (NSString*)cacheFileLocation;
- (NSDictionary*)getCachedResponse;
- (NSString *)keyForRequest;
- (NSString *)hashForUniqueKey:(NSString*)key;

@end


@protocol ReachStatsRequestDelegate

- (void)requestCompletedWithResponse:(id)response;
- (void)requestFailedWithError:(NSString*)errorMessage;

@end


