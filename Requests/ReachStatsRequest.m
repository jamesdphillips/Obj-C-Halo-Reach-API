//
//  ReachStatsServiceRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-15.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "ReachStatsRequest.h"
#import "ReachStatsService.h"
#import <CommonCrypto/CommonDigest.h>


@implementation ReachStatsRequest

@synthesize httpRequest;
@synthesize httpResponse;
@synthesize httpConnection;
@synthesize jsonParser;
@synthesize response;
@synthesize delegate;

- (id)initWithDelegate:(id)_delegate {
	if ( (self = [super init]) ) {
		
		[self createHTTPRequest];
		[self createJSONParser];
		
		self.delegate = _delegate;
	}
	return self;
}

- (id)init {
	return [self initWithDelegate:nil];
}

- (void)createJSONParser {
	self.jsonParser  = [[[YAJLDocument alloc] init] autorelease];
}

- (void)createHTTPRequest {
	self.httpRequest = [[[NSMutableURLRequest alloc] init] autorelease];
    [self.httpRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[self.httpRequest setHTTPMethod:@"GET"];
    [self.httpRequest setTimeoutInterval:20.0f];
    //[self.httpRequest setHTTPShouldUsePipelining:YES];
}

- (void)setURL:(NSString *)_url {
#ifdef DEBUG
	NSLog(@"url: %@",_url);
#endif
	self.httpRequest.URL = [NSURL URLWithString:_url];
}

- (id)startSynchronous {
	
	[self startSynchronousConnection];
	
	// If success
	NSDictionary *dict = [self checkResponse:[self.jsonParser root]];
	
	// Check for errors
	NSString *error = [[self class] checkResponseForErrors:dict request:self.httpResponse];
	if ( !error ) {
		return [self handleResponse:dict];
	} else {
#ifdef DEBUG
		NSLog(@"error: %@",error);
#endif
		// TODO: THROW SOME ERROR
		return nil;
	}
}

- (void)startAsynchronous {
    self.httpConnection = [NSURLConnection connectionWithRequest:self.httpRequest delegate:self];
    
    if ( !self.httpConnection )
        [self.delegate requestFailedWithError:@"Unable to open connection!"];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
#ifdef DEBUG
    NSLog(@"got chunk");
#endif
    @try {
		yajl_status status = [self.jsonParser parse:data error:nil];
		if ( status == yajl_status_error ) {
#ifdef DEBUG
			NSLog(@"yajl error: %d",status);
#endif
			[self.httpConnection cancel];
		}
	}
	@catch (NSException * e) {
#ifdef DEBUG
		NSLog(@"yajl exception: %@",e);
#endif
		[self.httpConnection cancel];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)_response
{
    if ( [_response isKindOfClass:[NSHTTPURLResponse class]] )
        self.httpResponse = (NSHTTPURLResponse *)_response;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dict = [self checkResponse:[self.jsonParser root]];
	NSString *error = [[self class] checkResponseForErrors:dict request:self.httpResponse];
	if ( !error ) {
		[self handleResponse:dict];
		[self.delegate performSelector:@selector(requestCompletedWithResponse:) withObject:self];
	} else
		[self.delegate performSelector:@selector(requestFailedWithError:) withObject:error];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate performSelector:@selector(requestFailedWithError:) withObject:[error description]];
}

- (id)handleResponse:(id)dict {
	self.response = dict;
	return self.response;
}

+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(NSHTTPURLResponse *)_httpResponse {
	if ( [_httpResponse statusCode] >= 200 && [_httpResponse statusCode] < 500 ) {
		if ([_response isKindOfClass:[NSDictionary class]]) {
			if ( [_response objectForKey:@"status"] ) {
				if ([[_response objectForKey:@"status"] intValue] == 0)
					return nil;
				else
					return [_response objectForKey:@"reason"];
			}
		}
		return @"Invalid Response";
	}
	return @"Unable to contact the API!";
}

- (NSDictionary*)checkResponse:(NSDictionary*)rawResponse {
    
    // No response
	NSDictionary *dict = [self.jsonParser root];
	if ( !dict ) {
		dict = [self getCachedResponse];
		if ( !dict )
			return nil;
//		else
//			[self.httpRequest setDidUseCachedResponse:YES];
	}
    
    // Save to cache
//    else {
//		[self performSelectorInBackground:@selector(cacheResponseInThread:)
//							   withObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:rawResponse,[self.httpRequest URL],nil]
//																	  forKeys:[NSArray arrayWithObjects:@"data",@"URL",nil]]];
//	}
	return dict;
}

- (NSString*)cacheFileLocationWithUniqueKey:(NSString*)key {
	NSString *path = [[ReachStatsService applicationDocumentsDirectory] stringByAppendingFormat:@"/rsr.cache.%@",[self hashForUniqueKey:key]];
#ifdef DEBUG
	NSLog(@"path: %@",path);
#endif
	return path;
}

- (NSString*)cacheFileLocation {
	return [self cacheFileLocationWithUniqueKey:[[[self.httpRequest URL] absoluteString] stringByAppendingString:@".v2"]];
}

- (void)cacheResponse:(NSDictionary *)rawResponse URL:(NSURL*)url {
	NSDictionary *cacheFile = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
																   rawResponse,
																   [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]],
																   nil]
														  forKeys:[NSArray arrayWithObjects:
																   @"data",
																   @"last-modified",
																   nil]];
	[NSKeyedArchiver archiveRootObject:cacheFile toFile:[self cacheFileLocationWithUniqueKey:[url absoluteString]]];
#ifdef DEBUG
	NSLog(@"done saving! %@",[self class]);
#endif
}

- (void)cacheResponse:(NSDictionary*)rawResponse {
	[self cacheResponse:rawResponse URL:[self.httpRequest URL]];
}

- (void)cacheResponseInThread:(NSDictionary *)data {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self cacheResponse:[data objectForKey:@"data"] URL:[data objectForKey:@"URL"]];
	[pool release];
}

- (NSDictionary*)getCachedResponse {
	NSDictionary *cached = [NSKeyedUnarchiver unarchiveObjectWithFile:[self cacheFileLocation]];
	return [cached objectForKey:@"data"];
}

- (NSString *)keyForRequest {
	return [self hashForUniqueKey:[[self.httpRequest URL] absoluteString]];
}

- (NSString *)hashForUniqueKey:(NSString*)key {
	const char *cStr = [key UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]]; 	
}

- (void)parseJSON:(NSData *)data {
    @try {
		yajl_status status = [self.jsonParser parse:data error:nil];
		if ( status == yajl_status_error ) {
#ifdef DEBUG
			NSLog(@"yajl error: %d",status);
#endif
		}
	}
	@catch (NSException * e) {
#ifdef DEBUG
		NSLog(@"yajl exception: %@",e);
#endif
	}
}

- (void)startSynchronousConnection
{
    // Start
    NSError *e = nil;
    NSHTTPURLResponse *r = nil;
    NSData *rd = [NSURLConnection sendSynchronousRequest:self.httpRequest returningResponse:&r error:&e];
    
#ifdef DEBUG
	NSLog(@"done syncronous!");
#endif
    
    // Response
    self.httpResponse = r;
    
    // JSON
    [self parseJSON:rd];
}

- (void)dealloc {
    [self.httpConnection cancel];
    self.httpConnection = nil;
    self.httpResponse = nil;
	self.httpRequest = nil;
	[self.jsonParser setDelegate:nil];
	self.jsonParser = nil;
	self.response = nil;
	[super dealloc];
}

@end
