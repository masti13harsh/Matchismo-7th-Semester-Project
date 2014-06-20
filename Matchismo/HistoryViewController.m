//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Harsh Sapra on 18/12/13.
//  Copyright (c) 2013 Harsh Sapra. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.historyTextView.text = [NSString stringWithString:self.historyString];
}

@end
