//
//  ETTriviaAnswerViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTriviaAnswerViewController.h"
#import "ETRightNavigationBtn.h"
#import "UIImage+UIColor.h"
#import <UIColor+Expanded.h>
#import "ETTriviaResultViewController.h"
@implementation ETTriviaAnswerViewController

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

- (IBAction)  btnClick:(id)sender
{
    NSInteger tag = [sender tag];
    NSString* str = [NSString stringWithFormat:@"answer%d", tag];
    UILabel* label = [self valueForKey:str];
    [self.timer invalidate];
    
    if ([label.text isEqualToString:self.question.rightAns])
    {
        self.result = kTriviaResultRight;
    }
    else
    {
        self.result = kTriviaResultWrong;
    }
    
    [self performSegueWithIdentifier:@"result" sender:label.text];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"result"])
    {
        ETTriviaResultViewController* vc = segue.destinationViewController;
        vc.result = self.result;
        vc.question = self.question;
        vc.answer = sender;
    }
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
    
    [self setRightBtnWithString:@"2 T.O LEFT"];
    [self setLeftLabelWithInt:self.remainTime];
    
    NSArray* arr = [self.question answers];
    for (int i=1; i<4; i++) {
        UILabel* label = [self valueForKey:[NSString stringWithFormat:@"answer%d", i]];
        label.text = arr[i-1];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:Nil
                                                 repeats:YES];
    
    self.groupMovedDeltaY = (self.group.frame.origin.y - 64)/self.remainTime;
}

- (void) update
{
    _remainTime --;
    [self setLeftLabelWithInt:self.remainTime];
    
    CGRect rect = self.group.frame;
    rect.origin.y -= self.groupMovedDeltaY;
    self.group.frame = rect;
    
    if (self.remainTime == 0)
    {
        [self.timer invalidate];
        self.result = kTriviaResultTimeOut;
        [self performSegueWithIdentifier:@"result" sender:Nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7)
        self.automaticallyAdjustsScrollViewInsets = NO;
    else
        self.wantsFullScreenLayout = YES;
    
    if (iPhone5)
    {
        self.backgroundView.image = [UIImage imageNamed:@"trivia_background@2x~568.jpg"];
    }
}
@end
