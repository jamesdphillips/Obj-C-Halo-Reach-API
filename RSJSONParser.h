//
//  RSJSONParser.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-16.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <YAJL/YAJL.h>


@interface RSJSONParser : YAJLParser <YAJLParserDelegate> {
	
	@private
	
	NSMutableArray *keys;
	NSMutableArray *objects;
	id head;
}

@property (nonatomic,retain) NSMutableArray *keys;
@property (nonatomic,retain) NSMutableArray *objects;
@property (nonatomic,assign) id head;

- (id)initWithObject:(id)obj;
- (void)addObject:(id)obj;
- (void)addKey:(NSString *)key;
- (id)objectForKey:(NSString*)key withObject:(id)obj;
- (void)setValue:(id)value forKey:(NSString*)key withObject:(id)obj;
- (void)moveHead:(id)obj;
- (void)restoreHead;

@end


@protocol RSJSONParserDelegate

//- (id)objectForJSONKey:(NSString*)key;
//- (void)setValue:(id)value forKey:(NSString*)key;

@end

