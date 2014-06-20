//
//  Card.h
//  Matchismo
//
//  Created by Harsh Sapra on 09/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
