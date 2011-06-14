//
//  RSArmourMetadata.h
//  ReachStatsiPhone
//
//  Created by James Phillips on 11-03-20.
//  Copyright 2011 Aelatis Technology, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSArmourMetadata : NSObject <NSCoding> {
    
    NSUInteger ID;
    NSString *name;
    NSString *description;
    NSUInteger cost;
    NSString *rankToSee;
    NSString *rankToBuy;
    NSString *prerequisites;
    NSString *notes;
}

@property (nonatomic) NSUInteger ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *description;
@property (nonatomic) NSUInteger cost;
@property (nonatomic,copy) NSString *rankToSee;
@property (nonatomic,copy) NSString *rankToBuy;
@property (nonatomic,copy) NSString *prerequisites;
@property (nonatomic,copy) NSString *notes;

- (id)initWithAPIData:(NSDictionary *)data;

@end
