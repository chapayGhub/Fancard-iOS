//
//  ETTriviaResultViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTriviaResultViewController.h"
#import "ETNetworkAdapter.h"
#import <MBProgressHUD.h>
#import <JSONKit.h>
#import "ETGlobal.h"
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
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    [hud setLabelText:@"Sync With Server"];
    [[ETNetworkAdapter sharedAdapter] answerQuestionWithQuestionID:[self.question.identifier integerValue]
                                                            answer:self.answer
                                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                               NSDictionary* dict = [responseObject objectFromJSONData];
                                                               NSInteger t = [dict[@"addCredit"] integerValue];
                                                               if (t != 0)
                                                               {
                                                                   [ETGlobal sharedGlobal].userPointsToday = [ETGlobal sharedGlobal].userPointsToday + t;
                                                                   [ETGlobal sharedGlobal].userPointsTotal = [ETGlobal sharedGlobal].userPointsTotal + t;
                                                                   [ETGlobal sharedGlobal].userNumberCorrectanswer = [ETGlobal sharedGlobal].userNumberCorrectanswer + 1;
                                                               }
                                                               [hud hide:YES];
                                                           }
                                                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                               
                                                           }];
}


@end
