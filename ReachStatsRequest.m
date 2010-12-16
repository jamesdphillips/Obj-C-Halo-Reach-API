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
@synthesize jsonParser;
@synthesize response;
@synthesize delegate;

- (id)initWithDelegate:(id)_delegate {
	if ( self = [super init] ) {
		
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
	self.httpRequest = [[[ASIHTTPRequest alloc] initWithURL:nil] autorelease];
	self.httpRequest.requestMethod = @"GET";
	self.httpRequest.timeOutSeconds = 5;
	self.httpRequest.numberOfTimesToRetryOnTimeout = 3;
//	self.httpRequest.cachePolicy = ASIUseCacheIfLoadFailsCachePolicy;
//	self.httpRequest.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
	self.httpRequest.delegate = self;
}

- (void)setURL:(NSString *)_url {
	NSLog(@"url: %@",_url);
	self.httpRequest.url = [NSURL URLWithString:_url];
}

- (id)startSynchronous {
	
	// Start
	[self.httpRequest startSynchronous];
	NSLog(@"done syncronous!");
	
	// If success
	NSDictionary *dict = [self checkResponse:[self.jsonParser root]];
	
	// Check for errors
	NSString *error = [[self class] checkResponseForErrors:dict request:self.httpRequest];
	if ( !error ) {
		return [self handleResponse:dict];
	} else {
		// TODO: THROW SOME ERROR
		return nil;
	}
}

- (void)startAsynchronous {
	[self.httpRequest setDidFinishSelector:@selector(apiRequestFinished:)];
	[self.httpRequest setDidFailSelector:@selector(apiRequestFailed:)];
	[self.httpRequest startAsynchronous];
}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data {
	@try {
		yajl_status status = [self.jsonParser parse:data error:nil];
		if ( status == yajl_status_error ) {
			[self.httpRequest cancel];
		}
	}
	@catch (NSException * e) {
		[self.httpRequest cancel];
	}
}

- (void)apiRequestFinished:(ASIHTTPRequest *)request {
	NSDictionary *dict = [self checkResponse:[self.jsonParser root]];
	NSString *error = [[self class] checkResponseForErrors:dict request:self.httpRequest];
	if ( !error ) {
		[self handleResponse:dict];
		[self.delegate performSelector:@selector(requestCompletedWithResponse:) withObject:self];
	} else
		[self.delegate performSelector:@selector(requestFailedWithError:) withObject:error];
}

- (void)apiRequestFailed:(ASIHTTPRequest *)request {
	[self.delegate performSelector:@selector(requestFailedWithError:) withObject:@"Unable to contact the API."];
}

- (id)handleResponse:(id)dict {
	self.response = dict;
	return self.response;
}

+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(ASIHTTPRequest*)request {
	if ( request.responseStatusCode == 200 || [request didUseCachedResponse] ) {
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
	NSDictionary *dict = [self.jsonParser root];
	if ( !dict ) {
		dict = [self getCachedResponse];
		if ( !dict )
			return nil;
		else
			[self.httpRequest setDidUseCachedResponse:YES];
	} else {
		[self performSelectorInBackground:@selector(cacheResponseInThread:)
							   withObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:rawResponse,[self.httpRequest url],nil]
																	  forKeys:[NSArray arrayWithObjects:@"data",@"URL",nil]]];
	}
	return dict;
}

- (NSString*)cacheFileLocationWithUniqueKey:(NSString*)key {
	NSString *path = [[ReachStatsService applicationDocumentsDirectory] stringByAppendingFormat:@"/rsr.cache.%@",[self hashForUniqueKey:key]];
	NSLog(@"path: %@",path);
	return path;
}

- (NSString*)cacheFileLocation {
	return [self cacheFileLocationWithUniqueKey:[[self.httpRequest url] absoluteString]];
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
	NSLog(@"done saving!");
}

- (void)cacheResponse:(NSDictionary*)rawResponse {
	[self cacheResponse:rawResponse URL:[self.httpRequest url]];
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
	return [self hashForUniqueKey:[[self.httpRequest url] absoluteString]];
}

- (NSString *)hashForUniqueKey:(NSString*)key {
	const char *cStr = [key UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]]; 	
}

- (void)dealloc {
	self.httpRequest.delegate = nil;
	self.httpRequest = nil;
	self.jsonParser.delegate = nil;
	self.jsonParser = nil;
	self.response = nil;
	[super dealloc];
}

@end
