//
//  SetCard.m
//  Matchismo
//
//  Created by Harsh Sapra on 18/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


@synthesize shape = _shape;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    SetCard *firstCard = [otherCards objectAtIndex:0];
    SetCard *secondCard = [otherCards objectAtIndex:1];
    
    if([firstCard.shape isEqualToString:secondCard.shape] && [firstCard.shape isEqualToString:self.shape])
       {
           score = 1;
       }
    else if((firstCard.color == secondCard.color) && (firstCard.color == self.color))
       {
           score = 1;
       }
    else if((firstCard.count == secondCard.count) && (firstCard.count == self.count))
    {
        score = 1;
    }
    else if ((firstCard.shade == secondCard.shade) && (firstCard.shade == self.shade))
    {
        score = 1;
    }
    else if(![firstCard.shape isEqualToString:secondCard.shape] && ![firstCard.shape isEqualToString:secondCard.shape] && (firstCard.color != secondCard.color) && (firstCard.color != self.color)&& (firstCard.count != secondCard.count) && (firstCard.count != self.count) && (firstCard.shade != secondCard.shade) && (firstCard.shade != self.shade))
    {
        score = 1;
    }
    else
    {
        score = 0;
    }
    
    return score;
}

- (NSString *)contents
{
    NSMutableString *setCardContents = [[NSMutableString alloc] init];
    
    //Count
    [setCardContents appendString:[NSString stringWithFormat:@"%lu ", (unsigned long)self.count]];
    
    //Color
    NSArray *color = [SetCard validColors];
    [setCardContents appendString:color[self.color + 1]];
    
    //Shade
    NSArray *shade = [SetCard validShade];
    [setCardContents appendString:shade[self.shade + 1]];
    
    //Shape
    [setCardContents appendString:self.shape];
        
    return setCardContents;
}

+ (NSArray *)validShapes
{
    return @[@"◼︎", @"▲", @"●"];
}

- (void)setShape:(NSString *)shape
{
    if([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"";
}

+ (NSInteger)maxColor
{
    return 3;
}

- (void)setColor:(NSUInteger)color
{
    if(color <= [SetCard maxColor])
    {
        _color = color;
    }
}

+ (NSInteger)maxCount
{
    return 3;
}

- (void)setCount:(NSUInteger)count
{
    if(count <= [SetCard maxCount])
    {
        _count = count;
    }
}

+ (NSInteger)maxShade
{
    return 3;
}

- (void)setShade:(NSUInteger)shade
{
    if(shade <= [SetCard maxShade])
    {
        _shade = shade;
    }
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validShade
{
    return @[@"solid", @"striped", @"open"];
}

@end
