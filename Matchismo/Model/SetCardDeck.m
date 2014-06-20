//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Harsh Sapra on 18/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        for(NSString *shape in [SetCard validShapes])
        {
            for(NSUInteger i = 1; i <= [SetCard maxColor]; i++)
            {
                for(NSUInteger j = 1; j <= [SetCard maxCount]; j++)
                {
                    for(NSUInteger k = 1; k <= [SetCard maxShade]; k++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.color = i;
                        card.count = j;
                        card.shade = k;
                        [self addCard:card atTop:NO];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
