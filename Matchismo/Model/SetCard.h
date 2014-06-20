//
//  SetCard.h
//  Matchismo
//
//  Created by Harsh Sapra on 18/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shade;

+ (NSArray *)validShapes;
+ (NSInteger)maxCount;
+ (NSInteger)maxColor;
+ (NSInteger)maxShade;
@end
