//
//  RSGameMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import "RSGameMetadata.h"


@implementation RSGameMetadata

@synthesize commendations;
@synthesize enemies;
@synthesize maps;
@synthesize medals;
@synthesize weapons;
@synthesize gameVariants;
@synthesize ranks;


#pragma mark -
#pragma mark Initialize
- (id)initWithAPIData:(NSDictionary *)data {
	
	if ( (self = [super init]) ) {
		
		/**
		 ** Commendations
		 */
		
		// Iterate 
		NSArray *cData = [data objectForKey:@"AllCommendationsById"];
		NSMutableDictionary *cMetadata = [[NSMutableDictionary alloc] initWithCapacity:[cData count]];
		for ( NSDictionary *c in cData ) {
			NSNumber *key = [NSNumber numberWithInt:[[c objectForKey:@"Key"] intValue]];
			NSDictionary *value = [c objectForKey:@"Value"];
			[cMetadata setObject:[[[RSCommendationMetadata alloc] initWithAPIData:value] autorelease]
						  forKey:key];
		}
		
		// Set
		self.commendations = cMetadata;
		[cMetadata release];
		
		
		/**
		 ** Enemies
		 */
		
		// Iterate
		NSArray *eData = [data objectForKey:@"AllEnemiesById"];
		NSMutableDictionary *eMetadata = [[NSMutableDictionary alloc] initWithCapacity:[eData count]];
		for ( NSDictionary *e in eData ) {
			NSNumber *key = [NSNumber numberWithInt:[[e objectForKey:@"Key"] intValue]];
			NSDictionary *value = [e objectForKey:@"Value"];
			[eMetadata setObject:[[[RSEnemiesMetadata alloc] initWithAPIData:value] autorelease]
						  forKey:key];
		}
		
		// Set
		self.enemies = eMetadata;
		[eMetadata release];
		
		
		/**
		 ** Maps
		 */
		
		// Iterate
		NSArray *mData = [data objectForKey:@"AllMapsById"];
		NSMutableDictionary *mMetadata = [[NSMutableDictionary alloc] init];
		for ( NSDictionary *m in mData ) {
			NSNumber *key = [NSNumber numberWithInt:[[m objectForKey:@"Key"] intValue]];
			NSDictionary *value = [m objectForKey:@"Value"];
			[mMetadata setObject:[RSMapMetadata mapMetadataWithAPIData:value]
						  forKey:key];
		}
		
		// Set
		self.maps = mMetadata;
		[mMetadata release];
		
		
		/**
		 ** Medals
		 */
		
		// Iterate
		NSArray *meData = [data objectForKey:@"AllMedalsById"];
		NSMutableDictionary *meMetadata = [[NSMutableDictionary alloc] initWithCapacity:[meData count]];
		for ( NSDictionary *me in meData ) {
			NSNumber *key = [NSNumber numberWithInt:[[me objectForKey:@"Key"] intValue]];
			NSDictionary *value = [me objectForKey:@"Value"];
			[meMetadata setObject:[RSMedalMetadata medalMetadataWithAPIData:value]
						   forKey:key];
		}
		
		// Set
		self.medals = meMetadata;
		[meMetadata release];
		
		
		/**
		 ** Weapons
		 */
		
		// Iterate
		NSArray *wData = [data objectForKey:@"AllWeaponsById"];
		NSMutableDictionary *wMetadata = [[NSMutableDictionary alloc] initWithCapacity:[wData count]];
		for ( NSDictionary *w in wData ) {
			NSNumber *key = [NSNumber numberWithInt:[[w objectForKey:@"Key"] intValue]];
			NSDictionary *value = [w objectForKey:@"Value"];
			[wMetadata setObject:[RSWeaponMetadata weaponMetadataWithAPIData:value]
						  forKey:key];
		}
		
		// Set
		self.weapons = wMetadata;
		[wMetadata release];
		
		
		/** 
		 ** Game Variants
		 */
		
		// Iterate
		NSArray *gData = [data objectForKey:@"GameVariantClassesKeysAndValues"];
		NSMutableDictionary *gMetadata = [[NSMutableDictionary alloc] init];
		for ( NSDictionary *g in gData ) {
			NSString *key = [[g objectForKey:@"Value"] stringValue];
			NSString *metadata = [g objectForKey:@"Key"];
			[gMetadata setObject:metadata
						  forKey:key];
		}
		
		// Set
		self.gameVariants = gMetadata;
		[gMetadata release];
		
		
		/**
		 ** Ranks
		 */
		
		// Iterate
		NSArray *rData = [data objectForKey:@"GlobalRanksById"];
		NSMutableDictionary *rMetadata = [[NSMutableDictionary alloc] initWithCapacity:[rData count]];
		for ( NSDictionary *r in rData ) {
			NSString *key = [r objectForKey:@"Key"];
			NSString *metadata = [r objectForKey:@"Value"];
			[rMetadata setObject:metadata forKey:key];
		}
		
		// Set
		self.ranks = rMetadata;
		[rMetadata release];
	}
	
	return self;
}

+ (RSGameMetadata *)gameMetadataWithAPIData:(NSDictionary *)data {
	return [[[RSGameMetadata alloc] initWithAPIData:data] autorelease];
}


#pragma mark -
#pragma mark Deallocate
- (void)dealloc {
	[self.commendations release];
	[self.enemies release];
	[self.maps release];
	[self.medals release];
	[self.weapons release];
	[self.gameVariants release];
	[self.ranks release];
	[super dealloc];
}


#pragma mark -
#pragma mark data
- (RSCommendationMetadata *)commendationWithID:(NSUInteger)ID {
	return [self.commendations objectForKey:[NSNumber numberWithInt:ID]];
}

- (RSEnemiesMetadata *)enemyWithID:(NSUInteger)ID {
	return [self.enemies objectForKey:[NSNumber numberWithInt:ID]];
}

- (RSMapMetadata *)mapWithID:(NSUInteger)ID {
	return [self.maps objectForKey:[NSNumber numberWithInt:ID]];
}

- (RSMedalMetadata *)medalWithID:(NSUInteger)ID {
	return [self.medals objectForKey:[NSNumber numberWithInt:ID]];
}

- (RSWeaponMetadata *)weaponWithID:(NSUInteger)ID {
	return [self.weapons objectForKey:[NSNumber numberWithInt:ID]];
}

- (NSString *)gameVariantWithID:(NSUInteger)ID {
	return [self.gameVariants objectForKey:[[NSNumber numberWithInt:ID] stringValue]];
}

- (NSString *)rankWithID:(NSString*)ID {
	return [self.ranks objectForKey:ID];
}

@end
