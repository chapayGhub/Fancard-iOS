//
//  ETTriviaResultViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTriviaResultViewController.h"

@implementation ETTriviaResultViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftBtnWithString:@"HOME"];
    [self setRightBtnWithString:@"NEXT"];
    self.rightBtn.disabled = NO;
    
    if (self.result == kTriviaResultRight)
    {
        if (iPhone5)
        {
            self.background.image = [UIImage imageNamed:@"trivia_result_win@2x~568.jpg"];
        }
        else
        {
            self.background.image = [UIImage imageNamed:@"trivia_result_win.jpg"];
        }
    }
    
    if (self.result == kTriviaResultTimeOut)
    {
        if (iPhone5)
        {
            self.background.image = [UIImage imageNamed:@"trivia_result_timeout@2x~568.jpg"];
        }
        else
        {
            self.background.image = [UIImage imageNamed:@"trivia_result_timeout.jpg"];
        }
    }
    
    if (self.result == kTriviaResultWrong)
    {
        if (iPhone5)
        {
            self.background.image = [UIImage imageNamed:@"trivia_result_lose@2x~568.jpg"];
        }
        else
        {
            self.background.image = [UIImage imageNamed:@"trivia_result_lose.jpg"];
        }
    }
}

- (void) rightBtnClick
{
    [self performSegueWithIdentifier:@"restart" sender:nil];
}

- (void) leftBtnClick
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void) leftSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer* s = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(rightBtnClick)];
    s.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:s];
    self.swipe = s;
}


@end
