//
//  RSFileGameIDRequest.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-19.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSFileGameIDRequest.h"


@implementation RSFileGameIDRequest

- (id)initWithFileID:(NSUInteger)FID withDelegate:(id)_delegate {
	if ((self = [super initWithDelegate:_delegate])) {
		[self setFileID:FID];
	}
	return self;
}

- (id)initWithFileID:(NSUInteger)FID {
	if ((self = [super initWithDelegate:nil])) {
		[self setFileID:FID];
	}
	return self;
}

- (id)startSynchronous {
	
	// If already cached.. no point..
	id cached = [self getCachedResponse];
	if ( [cached isKindOfClass:[NSArray class]] ) {
		return [self handleResponse:cached];
	} else {
		return [super startSynchronous];
	}
}

- (id)handleResponse:(id)dict {
    self.response = [dict objectForKey:@"GID"];
	return self.response;
}

+ (NSUInteger)gameIDWithFileID:(NSUInteger)FID {
	id rqst = [[[self class] alloc] initWithFileID:FID];
	[(RSFileGameIDRequest*)rqst startSynchronous];
	NSString *r = [(RSFileGameIDRequest*)rqst response];
	[rqst release];
    if ( [r isKindOfClass:[NSString class]] )
        return [r integerValue];
    else
        return 0;
}

+ (NSString *)checkResponseForErrors:(NSDictionary*)_response request:(NSHTTPURLResponse *)_httpResponse
{
	if ( [_httpResponse statusCode] == 200 ) {
		if ([_response isKindOfClass:[NSDictionary class]]) {
			return nil;
		}
		return @"Invalid Response";
	}
	return @"Unable to contact the API!";
}

- (void)setFileID:(NSUInteger)FID {
	[self setURL:[NSString stringWithFormat:@"http://api.reachservicerecord.com/file_game_id/%d",FID]];
}


@end
