//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Harsh Sapra on 09/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of cards
@end

@implementation CardMatchingGame

- (NSMutableArray *)choosenCards
{
    if(!_choosenCards) _choosenCards = [[NSMutableArray alloc] init];
    return _choosenCards;
}

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
        return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super self];
    
    if(self)
    {
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_FLIP = 1;

- (void)chooseCardAtIndex:(NSUInteger)index forGame:(NSUInteger)gameValue
{
    Card *card = [self cardAtIndex:index];
    self.lastScore = 0;
    
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            for(Card *otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    if(gameValue == 2)
                    {
                        [self.choosenCards addObject:otherCard];
                        int matchScore = [card match:self.choosenCards];
                        if(matchScore)
                        {
                            self.lastScore = matchScore * MATCH_BONUS;
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        }
                        else
                        {
                            self.lastScore -= MISMATCH_PENALTY;
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                    if(gameValue == 3)
                    {
                        [self.choosenCards addObject:otherCard];
                        if([self.choosenCards count] == 2)
                        {
                            int matchScore = [card match:self.choosenCards];
                            if(matchScore)
                            {
                                self.lastScore = matchScore * MATCH_BONUS;
                                self.score += matchScore * MATCH_BONUS;
                                for(Card *card in self.choosenCards)
                                {
                                    card.matched = YES;
                                }
                                card.matched = YES;
                            }
                            else
                            {
                                self.lastScore -= MISMATCH_PENALTY;
                                self.score -= MISMATCH_PENALTY;
                                for(Card *card in self.choosenCards)
                                {
                                    card.chosen = NO;
                                }
                            }
                            break;
                        }
                        else
                        {
                            continue;
                        }
                    }
                }
            }
            [self.choosenCards addObject:card];
            self.score -= COST_TO_FLIP;
            card.chosen = YES;
        }
    }
}

@end
