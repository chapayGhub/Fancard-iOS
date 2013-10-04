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
#import "SimpleAudioEngine.h"
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
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"Swish_ CorrectAnswer.mp3"];
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
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"incorrect_answer_aww.mp3"];
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
        [[SimpleAudioEngine sharedEngine] playEffect:@"incorrect_answer_aww.mp3"];
    }
}

- (void) rightBtnClick
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    [self performSegueWithIdentifier:@"restart" sender:nil];
}

- (void) leftBtnClick
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void) leftSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    
}

- (void) viewDidLoad
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [super viewDidLoad];
    UISwipeGestureRecognizer* s = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(rightBtnClick)];
    s.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:s];
    self.swipe = s;
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    [hud setLabelText:@"Sync With Server"];
    
    if (!self.answer)
    {
        self.answer = [NSString stringWithFormat:@"%d", arc4random()];
    }
    
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
