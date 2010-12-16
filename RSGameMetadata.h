//
//  RSGameMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-11.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSCommendationMetadata.h"
#import "RSEnemiesMetadata.h"
#import "RSMapMetadata.h"
#import "RSMedalMetadata.h"
#import "RSWeaponMetadata.h"

@interface RSGameMetadata : NSObject {
	NSDictionary *commendations;
	NSDictionary *enemies;
	NSDictionary *maps;
	NSDictionary *medals;
	NSDictionary *weapons;
	NSDictionary *gameVariants;
	NSDictionary *ranks;
}


@property (copy,nonatomic) NSDictionary *commendations;
@property (copy,nonatomic) NSDictionary *enemies;
@property (copy,nonatomic) NSDictionary *maps;
@property (copy,nonatomic) NSDictionary *medals;
@property (copy,nonatomic) NSDictionary *weapons;
@property (copy,nonatomic) NSDictionary *gameVariants;
@property (copy,nonatomic) NSDictionary *ranks;


- (id)initWithAPIData:(NSDictionary *)data;
+ (RSGameMetadata *)gameMetadataWithAPIData:(NSDictionary *)data;

- (RSCommendationMetadata *)commendationWithID:(NSUInteger)ID;
- (RSEnemiesMetadata *)enemyWithID:(NSUInteger)ID;
- (RSMapMetadata *)mapWithID:(NSUInteger)ID;
- (RSMedalMetadata *)medalWithID:(NSUInteger)ID;
- (RSWeaponMetadata *)weaponWithID:(NSUInteger)ID;
- (NSString *)gameVariantWithID:(NSUInteger)ID;
- (NSString *)rankWithID:(NSString*)ID;

@end
