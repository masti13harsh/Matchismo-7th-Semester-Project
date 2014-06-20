//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Harsh Sapra on 18/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetCardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (NSMutableString *)historyText
{
    if(_historyText) _historyText = [[NSMutableString alloc]init];
    return _historyText;
}

- (IBAction)touchDealButton:(UIButton *)sender
{
    self.game = nil;
    self.deck = nil;
    [self.historyText appendString:@"\n\nNew game\n"];
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:self.deck];
    return _game;
}

- (Deck *)deck
{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    unsigned long chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chooseButtonIndex forGame:3];
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        unsigned long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
        UIColor *cardColor;
        if(card.color == 1)
        {
            if(card.shade == 1)
            {
                cardColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
            }
            else if(card.shade == 2)
            {
                cardColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
            }
            else
            {
                cardColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
            }
        }
        else if(card.color == 2)
        {
            if(card.shade == 1)
            {
                cardColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
            }
            else if(card.shade == 2)
            {
                cardColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
            }
            else
            {
                cardColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];
            }
        }
        else
        {
            if(card.shade == 1)
            {
                cardColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
            }
            else if(card.shade == 2)
            {
                cardColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
            }
            else
            {
                cardColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
            }
        }
        
        if(card.chosen)
        {
            [cardButton setAlpha:0.8];
        }
        
        NSString *cardShape = [NSString stringWithFormat:@"%@", card.shape];
        NSMutableString *cardTitle = [[NSMutableString alloc]initWithString:cardShape];
        if(card.count == 2)
        {
            [cardTitle appendString:cardShape];
        }
        else if(card.count == 3)
        {
            [cardTitle appendString:cardShape];
            [cardTitle appendString:cardShape];
        }
        
        NSAttributedString *cardContent = [[NSAttributedString alloc]initWithString:cardTitle attributes:@{NSForegroundColorAttributeName : cardColor}];
        
        [cardButton setAttributedTitle:cardContent forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

@end
