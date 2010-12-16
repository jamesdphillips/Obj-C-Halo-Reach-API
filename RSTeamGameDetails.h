//
//  RSTeamGameDetails.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 10-10-13.
//  Copyright 2010 Aelatis Technology, Inc. All rights reserved.
//

#import <Three20/Three20.h>


typedef enum {
	RSTeamColourRed,
	RSTeamColourBlue,
	RSTeamColourGreen,
	RSTeamColourOrange,
	RSTeamColourPurple,
	RSTeamColourGold,
	RSTeamColourBrown,
	RSTeamColourPink
} RSTeamColour;

@interface RSTeamGameDetails : NSObject <NSCoding> {
	
	// ID
	NSUInteger ID;
	
	// Score
	NSArray *deathsOverTime;
	NSArray *killsOverTime;
	NSArray *medalsOverTime;
	NSInteger score;
	NSUInteger standing;
	NSUInteger metagameScore;
	
	// Totals
	NSUInteger assists;
	NSUInteger betrayals;
	NSUInteger deaths;
	NSUInteger kills;
	NSUInteger medals;
	NSUInteger suicides;
	
	// ..?
	BOOL exists;
	
}

@property (nonatomic) NSUInteger ID;
@property (nonatomic,copy) NSArray *deathsOverTime;
@property (nonatomic,copy) NSArray *killsOverTime;
@property (nonatomic,copy) NSArray *medalsOverTime;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSUInteger standing;
@property (nonatomic) NSUInteger metagameScore;
@property (nonatomic) NSUInteger assists;
@property (nonatomic) NSUInteger betrayals;
@property (nonatomic) NSUInteger deaths;
@property (nonatomic) NSUInteger kills;
@property (nonatomic) NSUInteger medals;
@property (nonatomic) NSUInteger suicides;
@property (nonatomic) BOOL exists;

- (NSString *)colourString;
- (UIColor *)colour;

@end
