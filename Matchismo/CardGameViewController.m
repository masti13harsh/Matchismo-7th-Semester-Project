//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Harsh Sapra on 08/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int selectedGame;
@property (weak, nonatomic) IBOutlet UILabel *gameText;
@end

@implementation CardGameViewController

//Abstract
- (NSMutableString *)historyText
{
    if(!_historyText) _historyText = [[NSMutableString alloc]init];
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
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    unsigned long chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chooseButtonIndex forGame:2];
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        unsigned long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    NSString *cards = [NSString stringWithFormat:@""];
    
    for(Card *card in self.game.choosenCards)
    {
        cards = [cards stringByAppendingString:card.contents];
    }
    if(self.game.lastScore > 0)
    {
        self.gameText.text = [NSString stringWithFormat:@"%@ matched for %ld points!", cards, (long)self.game.lastScore];
        [self.historyText appendString:self.gameText.text];
        [self.historyText appendString:@"\n"];
    }
    else if(self.game.lastScore < 0)
    {
        self.gameText.text = [NSString stringWithFormat:@"%@ mismatched for %ld points!", cards, (long)self.game.lastScore];
        [self.historyText appendString:self.gameText.text];
        [self.historyText appendString:@"\n"];
    }
    else
    {
        Card *card = [self.game.choosenCards lastObject];
        self.gameText.text = [NSString stringWithFormat:@"%@", card.contents ? card.contents : @""];
    }
    self.game.lastScore = 0;
    self.game.choosenCards = nil;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

//Abstract
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"History"])
    {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController *hVC = (HistoryViewController *)segue.destinationViewController;
            hVC.historyString = [NSString stringWithString:self.historyText];
        }
    }
}

@end
