//
//  PlayingCard.h
//  Matchismo
//
//  Created by Harsh Sapra on 09/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
