//
//  RSJSONParser.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-11-16.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSJSONParser.h"


@implementation RSJSONParser

@synthesize keys;
@synthesize objects;
@synthesize head;


#pragma mark -
#pragma mark Initialize

- (id)initWithObject:(id)obj {
	if ( self = [self init] ) {
		[self addObject:obj];
	}
	return self;
}

- (id)init {
	if ( self = [super init] ) {
		
		// Delegate
		self.delegate = self;
		
		// Initialize Arrays
		self.keys = [NSMutableArray array];
		self.objects = [NSMutableArray array];
		
		// Initial Key
		// [self addKey:@"__FirstKey__"];
	}
	return self;
}


#pragma mark -
#pragma mark Deallocate

- (void)dealloc {
	self.keys = nil;
	self.objects = nil;
	self.head = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Objects

- (void)addObject:(id)obj {
	[self.objects addObject:obj];
	[self moveHead:[self.objects lastObject]];
}

- (void)addKey:(NSString *)key {
	[self.keys addObject:key];
}

- (void)setValue:(id)value {
	id key = [self.keys lastObject];
	if ( key ) {
		[self setValue:value forKey:key withObject:self.head];
		[self.keys removeLastObject];
	}
}

- (void)moveHead:(id)obj {
	self.head = obj;
}

- (void)restoreHead {
	self.head = [self.objects lastObject];
}


#pragma mark -
#pragma mark YAJLParserDelegate

- (void)parserDidStartDictionary:(YAJLParser *)parser {
	NSString *key = [self.keys lastObject];
	if ( key ) {
		id obj = [self objectForKey:key withObject:self.head];
		[self addObject:obj];
	}
}

- (void)parserDidEndDictionary:(YAJLParser *)parser {
	if ( [self.keys count] > 0 ) {
		[self setValue:self.head forKey:[self.keys lastObject] withObject:[self.objects objectAtIndex:([self.objects count]-2)]];
		[self.objects removeLastObject];
		[self restoreHead];
	}
}

- (void)parserDidStartArray:(YAJLParser *)parser {
	// ..?
}

- (void)parserDidEndArray:(YAJLParser *)parser {
	[self.keys removeLastObject];
}

- (void)parser:(YAJLParser *)parser didMapKey:(NSString *)key {
	[self addKey:key];
}

- (void)parser:(YAJLParser *)parser didAdd:(id)value {
	[self setValue:value];
}


#pragma mark -
#pragma mark Messages

- (id)objectForKey:(NSString*)key withObject:(id)obj {
    NSString* methodName = [@"object_" stringByAppendingString:key];
	SEL selector = NSSelectorFromString(methodName);
	if ( [obj respondsToSelector:selector] )
		return [obj performSelector:selector];
	else
		return nil;
}

- (void)setValue:(id)value forKey:(NSString*)key withObject:(id)obj {
	NSString* methodName = [NSString stringWithFormat:@"parse_%@:",key];
	SEL selector = NSSelectorFromString(methodName);
	if ( [obj respondsToSelector:selector] )
		[obj performSelector:selector withObject:value];
}


@end
