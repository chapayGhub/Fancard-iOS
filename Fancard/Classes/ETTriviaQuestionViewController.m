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
#import "ETNetworkAdapter.h"
#import <MBProgressHUD.h>
#import "SimpleAudioEngine.h"
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
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
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
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Crowd_During_Trivia_Question 2.mp3" loop:NO];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
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
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Getting a Quiz";
    
    [[ETNetworkAdapter sharedAdapter] getNewQuizWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud setHidden:YES];
        self.question = [[ETQuestion alloc] initWithJsonData:responseObject];
        self.questionView.text = self.question.question;
    }
                                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                        if (operation.response.statusCode == 404)
                                                        {
                                                            hud.mode = MBProgressHUDModeText;
                                                            hud.labelText = @"No more questions";
                                                            [hud hide:YES afterDelay:1];
                                                            double delayInSeconds = 1.0;
                                                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                                                                [self dismissViewControllerAnimated:YES completion:Nil];
                                                            });
                                                        }
                                                    }];
    [super viewDidLoad];
    self.questionView.font = [UIFont fontWithName:kDefaultFont size:42];
    
    if (iOS7)
        self.automaticallyAdjustsScrollViewInsets = NO;
    else
        self.wantsFullScreenLayout = YES;
}

@end
