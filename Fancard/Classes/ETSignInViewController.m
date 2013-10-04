//
//  ETSignInViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETSignInViewController.h"
#import <MBProgressHUD.h>
#import "ETNetworkAdapter.h"
#import "ETGlobal.h"
#import <JSONKit.h>

@implementation ETSignInViewController

- (IBAction) checkDone:(id)sender
{
    self.rightBtn.disabled = YES;
    if (self.usernameField.text.length == 0) return;
    if (self.passwordField.text.length == 0) return;
    self.rightBtn.disabled = NO;
}

#pragma mark - UIViewController LifeCycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBtnWithString:@"SIGN IN"];
    [self setLeftBtnWithString:@"WELCOME"];
    
    self.rightBtn.disabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.usernameField setValue:[UIColor colorWithHexString:@"9e7f38"]
                      forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordField setValue:[UIColor colorWithHexString:@"9e7f38"]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:@"Forgot password?"];
    
    [commentString addAttribute:NSUnderlineStyleAttributeName
                          value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                          range:NSMakeRange(0, [commentString length])];
    
    [commentString addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"9e7f38"]
                          range:NSMakeRange(0, [commentString length])];
    
    [self.forgotPasswordBtn setAttributedTitle:commentString
                                      forState:UIControlStateNormal];
    
    self.usernameField.font = [UIFont fontWithName:kDefaultFont size:20];
    self.passwordField.font = [UIFont fontWithName:kDefaultFont size:20];
}

- (IBAction) forgotPwdBtnClick:(id)sender
{
    
}

- (void) getInfo
{
    [[ETNetworkAdapter sharedAdapter] getInfoWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dict = [responseObject objectFromJSONData];
        [ETGlobal sharedGlobal].userPointsTotal = [dict[@"user_points_total"] intValue];
        [ETGlobal sharedGlobal].userPointsToday = [dict[@"user_points_today"] intValue];
        [ETGlobal sharedGlobal].userNumberCorrectanswer = [dict[@"user_number_correctanswer"] intValue];
        [ETGlobal sharedGlobal].userNumberWatchedvideo = [dict[@"user_number_watchedvideo"] intValue];
        
        @synchronized(self)
        {
            self.requestCnt = self.requestCnt - 1;
            if (self.requestCnt == 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self requestAllFin];
                });
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void) getAvatar
{
    [[ETNetworkAdapter sharedAdapter] downloadAvatarWithUserName:self.usernameField.text
                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                             UIImage* img = [UIImage imageWithData:responseObject];
                                                             [ETGlobal sharedGlobal].avatar = img;
                                                             
                                                             @synchronized(self)
                                                             {
                                                                 self.requestCnt = self.requestCnt - 1;
                                                                 if (self.requestCnt == 0)
                                                                 {
                                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                                         [self requestAllFin];
                                                                     });
                                                                 }
                                                             }
                                                             
                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                             
                                                         }];
}

- (void) getQuizAndVideosStatus
{
    [[ETNetworkAdapter sharedAdapter] getVideoAndQuizStatusWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dict = [responseObject objectFromJSONData];
        [ETGlobal sharedGlobal].videoUnlockCnt = [dict[@"video_unlock_cnt"] integerValue];
        [ETGlobal sharedGlobal].quizUnlockCnt = [dict[@"quiz_unlock_cnt"] integerValue];
        
        @synchronized(self)
        {
            self.requestCnt = self.requestCnt - 1;
            if (self.requestCnt == 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self requestAllFin];
                });
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void) requestAllFin
{
    [self.hud hide:YES];
    if (false)
    {
        [self performSegueWithIdentifier:@"signin" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"tutorial" sender:nil];
    }
}

- (void) rightBtnClick
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Loading..."];
    self.hud = hud;
    [[ETNetworkAdapter sharedAdapter] loginWithUsername:self.usernameField.text
                                               password:self.passwordField.text
                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    [self.hud setLabelText:@"Getting data"];
                                                    [ETGlobal sharedGlobal].userName = self.usernameField.text;
                                                    self.requestCnt = 3;
                                                    [self getInfo];
                                                    [self getAvatar];
                                                    [self getQuizAndVideosStatus];
                                                }
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    [hud setLabelText:@"Authorization failed"];
                                                    [hud hide:1 afterDelay:1];
                                                }];
}
@end
