//
//  Deck.h
//  Matchismo
//
//  Created by Harsh Sapra on 09/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
