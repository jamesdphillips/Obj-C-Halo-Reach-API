//
//  ReachStatsServiceRequest.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-15.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YAJL/YAJL.h>


@interface ReachStatsRequest : NSObject {
	
	YAJLDocument *jsonParser;
	id response;
	id delegate;
}

@property (nonatomic,retain) NSMutableURLRequest *httpRequest;
@property (nonatomic,retain) NSHTTPURLResponse *httpResponse;
@property (nonatomic,retain) NSURLConnection *httpConnection;
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
+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(NSHTTPURLResponse*)_httpResponse;
- (NSDictionary*)checkResponse:(NSDictionary*)rawResponse;
- (void)cacheResponse:(NSDictionary*)rawResponse;
- (NSString*)cacheFileLocationWithUniqueKey:(NSString*)key;
- (NSString*)cacheFileLocation;
- (NSDictionary*)getCachedResponse;
- (NSString *)keyForRequest;
- (NSString *)hashForUniqueKey:(NSString*)key;
- (void)startSynchronousConnection;
- (void)parseJSON:(NSData *)data;

@end


@protocol ReachStatsRequestDelegate

- (void)requestCompletedWithResponse:(id)response;
- (void)requestFailedWithError:(NSString*)errorMessage;

@end


