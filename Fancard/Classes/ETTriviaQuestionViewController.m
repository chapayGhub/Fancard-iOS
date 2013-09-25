//
//  ETTriviaQuestionViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTriviaQuestionViewController.h"
#import "UIImage+UIColor.h"
#import <UIColor+Expanded.h>
#import "ETRightNavigationBtn.h"
#import "ETTriviaAnswerViewController.h"
@implementation ETTriviaQuestionViewController

- (void) setRightBtnWithString:(NSString*) str
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:11] removeFromSuperview];
    ETRightNavigationBtn* btn = [[NSBundle mainBundle] loadNibNamed:@"ETRightNavigationBtn"
                                                              owner:self
                                                            options:nil][0];
    btn.txt = str;
    CGRect rect = btn.frame;
    rect.origin.y += 5;
    rect.origin.x = 320-rect.size.width-5;
    btn.frame = rect;
    btn.tag = 11;
    [view addSubview:btn];
    [btn setClick:^{
        [self rightBtnClick];
    }];
    btn.disabled = NO;
}

- (void) rightBtnClick
{
    [self.timer invalidate];
    [self performSegueWithIdentifier:@"answer" sender:nil];
}

- (void) setLeftLabelWithInt:(NSInteger) x
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:10] removeFromSuperview];
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:kDigitalFont size:30];
    label.textColor = [UIColor colorWithHexString:@"56527c"];
    label.frame = CGRectMake(5, 5, 50, 35);
    label.tag = 10;
    
    [view addSubview:label];
    
    label.text = [NSString stringWithFormat:@"%.2d", x];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title_image"]]];
    
    if (iOS7)
    {
        [[self.navigationController navigationBar] setTintColor: [UIColor colorWithHexString:@"56527c"]];
    }
    else
    {
        
        [[self.navigationController navigationBar] setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor whiteColor]]
                                                        forBarMetrics:UIBarMetricsDefault];
    }
    self.navigationItem.hidesBackButton = YES;
    self.questionView.text = self.question.question;
    
    [self setRightBtnWithString:@"ANSWER"];
    
    self.remainTime = 24;
    [self setLeftLabelWithInt:self.remainTime];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:Nil
                                                 repeats:YES];
}

- (void) update
{
    _remainTime --;
    [self setLeftLabelWithInt:self.remainTime];
    
    if (self.remainTime == 18)
    {
        [self.timer invalidate];
        [self performSegueWithIdentifier:@"answer" sender:nil];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"answer"])
    {
        ETTriviaAnswerViewController* viewController = segue.destinationViewController;
        viewController.remainTime = self.remainTime;
        viewController.question = self.question;
    }
}
- (void)viewDidLoad
{
    self.question = [[ETQuestion alloc] init];
    self.question.question = @"The Question displays here for the fist 6 seconds of the countdown?";
    self.question.rightAns = @"Use";
    self.question.wrongAns1 = @"Two Lines Of Text";
    self.question.wrongAns2 = @"When Needed";
    
    [super viewDidLoad];
    self.questionView.font = [UIFont fontWithName:kDefaultFont size:42];
    
    if (iOS7)
        self.automaticallyAdjustsScrollViewInsets = NO;
    else
        self.wantsFullScreenLayout = YES;
}

@end
