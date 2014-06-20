//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Harsh Sapra on 09/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index forGame:(NSUInteger)gameValue;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, strong) NSMutableArray *choosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, readonly) NSInteger score;

@end
