//
//  PlayingCard.m
//  Matchismo
//
//  Created by Harsh Sapra on 09/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank)
        {
            score = 4;
        }
        else if([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
    }
    else if([otherCards count] == 2)
    {
        PlayingCard *firstCard = [otherCards objectAtIndex:0];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        
        if(firstCard.rank == secondCard.rank || secondCard.rank == self.rank || firstCard.rank == self.rank)
        {
            if(secondCard.rank == self.rank && firstCard.rank == secondCard.rank)
            {
                score = 16;
            }
            else
            {
                score = 4;
            }
        }
        else if([firstCard.suit isEqualToString:secondCard.suit] || [secondCard.suit isEqualToString:self.suit] || [self.suit isEqualToString:firstCard.suit])
        {
            if([secondCard.suit isEqualToString:self.suit] && [firstCard.suit isEqualToString:secondCard.suit])
            {
                score = 3;
            }
            else
            {
                score = 1;
            }
        }
    }
        
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♦︎", @"♣︎", @"♠︎"];
}


- (void)setSuit:(NSString *)suit
{
    if([ [PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if( rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

+ (NSUInteger) maxRank { return [[self rankStrings] count] - 1; }

@end