//
//  RSArmourMetadata.m
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-20.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import "RSArmourMetadata.h"


@implementation RSArmourMetadata

@synthesize ID;
@synthesize cost;
@synthesize name;
@synthesize description;
@synthesize rankToSee;
@synthesize rankToBuy;
@synthesize prerequisites;
@synthesize notes;

- (id)initWithAPIData:(NSDictionary *)data {
    
    if ( (self = [super init]) ) {
        
        self.ID = [[data objectForKey:@"id"] intValue];
        self.cost = [[data objectForKey:@"cost"] intValue];
        self.name = [data objectForKey:@"name"];
        self.description = [data objectForKey:@"description"];
        self.rankToSee = [data objectForKey:@"rank_to_see"];
        self.rankToBuy = [data objectForKey:@"rank_to_buy"];
        self.prerequisites = [data objectForKey:@"prereqs"];
        self.notes = [data objectForKey:@"notes"];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ( (self = [super init]) ) {
        
        self.ID = [aDecoder decodeIntForKey:@"i"];
        self.cost = [aDecoder decodeIntForKey:@"c"];
        self.name = [aDecoder decodeObjectForKey:@"n"];
        self.description = [aDecoder decodeObjectForKey:@"d"];
        self.rankToSee = [aDecoder decodeObjectForKey:@"rTS"];
        self.rankToBuy = [aDecoder decodeObjectForKey:@"rTB"];
        self.prerequisites = [aDecoder decodeObjectForKey:@"p"];
        self.notes = [aDecoder decodeObjectForKey:@"no"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInt:self.ID forKey:@"i"];
    [aCoder encodeInt:self.cost forKey:@"c"];
    [aCoder encodeObject:self.name forKey:@"n"];
    [aCoder encodeObject:self.description forKey:@"d"];
    [aCoder encodeObject:self.rankToSee forKey:@"rTS"];
    [aCoder encodeObject:self.rankToBuy forKey:@"rTB"];
    [aCoder encodeObject:self.prerequisites forKey:@"p"];
    [aCoder encodeObject:self.notes forKey:@"no"];
}

- (void)dealloc {
    [self.name release];
    [self.description release];
    [self.rankToBuy release];
    [self.rankToSee release];
    [self.prerequisites release];
    [self.notes release];
    [super dealloc];
}

@end
