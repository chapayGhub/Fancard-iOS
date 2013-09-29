//
//  ETHomeViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETHomeViewController.h"
#import "UIImage+UIColor.h"
#import <UIColor+Expanded.h>
#import "ETGlobal.h"
#import "ETNetworkAdapter.h"
#import <MBProgressHUD.h>
#import "ETVideo.h"
@implementation ETHomeViewController

#pragma mark - IBAction
- (void) requestAllFin
{
    [self.hud hide:YES];
    self.tabBarController.selectedIndex = 3;
}

- (void) getAllVideos
{
    [[ETNetworkAdapter sharedAdapter] getAllVideosWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dict = [responseObject objectFromJSONData];
        
        for (int i=0; i<dict.allKeys.count; i++) {
            NSString* key = [NSString stringWithFormat:@"%d", i];
            if (dict[key])
            {
                [[ETGlobal sharedGlobal].allVideos addObject:[[ETVideo alloc] initWithDict:dict[key]]];
            }
        }

        @synchronized(self)
        {
            self.requestCnt = self.requestCnt - 1;
            if (_requestCnt == 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self requestAllFin];
                });
            }
        }
    }
                                                      failure:nil];
}

- (void) getWatchedVideos
{
    [[ETNetworkAdapter sharedAdapter] getCompleteVideosWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject)  {
        NSDictionary* dict = [responseObject objectFromJSONData];
        for (int i=0; i<dict.allKeys.count; i++) {
            NSString* key = [NSString stringWithFormat:@"%d", i];
            if (dict[key])
            {
                [[ETGlobal sharedGlobal].watchedVideos addObject:dict[key][@"video_id"]];
            }
        }
        @synchronized(self)
        {
            self.requestCnt = self.requestCnt - 1;
            if (_requestCnt == 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self requestAllFin];
                });
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (IBAction) group1BtnClick:(id)sender
{
    self.requestCnt = 0;
    self.hud = nil;
    if (![ETGlobal sharedGlobal].watchedVideos)
    {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"loading...";
        
        [ETGlobal sharedGlobal].watchedVideos = [NSMutableArray array];
        self.requestCnt ++;
        [self getWatchedVideos];
    }
    
    if (![ETGlobal sharedGlobal].allVideos)
    {
        if (!self.hud)
        {
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.labelText = @"loading...";
        }
        
        [ETGlobal sharedGlobal].allVideos = [NSMutableArray array];
        self.requestCnt ++;
        [self getAllVideos];
    }
    
    if (!self.hud)
    {
        self.tabBarController.selectedIndex = 3;
    }
}
- (void) rightBtnClick
{
    [[[UIAlertView alloc] initWithTitle:@"Attention"
                                message:@"Are you sure you want to sign out?"
                               delegate:self
                      cancelButtonTitle:@"No"
                        otherButtonTitles:@"Yes", nil] show];
}

- (void) refreshData
{
    self.group1CompleteLabel.text = [NSString stringWithFormat:@"%d", [ETGlobal sharedGlobal].userNumberWatchedvideo];
    self.group1UnlockedLabel.text = [NSString stringWithFormat:@"%d", [ETGlobal sharedGlobal].videoUnlockCnt];
    self.group1LockedLabel.text = @"20";

    self.group2CompleteLabel.text = [NSString stringWithFormat:@"%d", [ETGlobal sharedGlobal].userNumberCorrectanswer];
    self.group2UnlockedLabel.text = [NSString stringWithFormat:@"%d", [ETGlobal sharedGlobal].quizUnlockCnt];
    self.group2LockedLabel.text = @"100";

    self.group3CompleteLabel.text = @"1";
    self.group3UnlockedLabel.text = @"4";
    self.group3LockedLabel.text = @"0";

}
#pragma mark - UIViewController LifeCycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    [self refreshData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!iOS7)
    {
        self.wantsFullScreenLayout = YES;
    }
    
    if (iPhone5)
    {
        self.background.image = [UIImage imageNamed:@"home_background@2x~568.jpg"];
        CGRect rect = self.background.frame;
        rect.size.height += 88;
        self.background.frame = rect;
        
        rect = self.viewGroup1.frame;
        rect.origin.y += 36;
        self.viewGroup1.frame = rect;
        
        rect = self.viewGroup2.frame;
        rect.origin.y += 36;
        self.viewGroup2.frame = rect;
        
        rect = self.viewGroup3.frame;
        rect.origin.y += 36;
        self.viewGroup3.frame = rect;
    }
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"home_setting"]
         forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self
            action:@selector(rightBtnClick)
  forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    self.group1CompleteLabel.font = [UIFont fontWithName:kNumberFont
                                                    size:30];
    self.group1UnlockedLabel.font = [UIFont fontWithName:kNumberFont
                                                    size:30];
    self.group1LockedLabel.font   = [UIFont fontWithName:kNumberFont
                                                    size:30];

    self.group2CompleteLabel.font = [UIFont fontWithName:kNumberFont
                                                    size:30];
    self.group2UnlockedLabel.font = [UIFont fontWithName:kNumberFont
                                                    size:30];
    self.group2LockedLabel.font   = [UIFont fontWithName:kNumberFont
                                                    size:30];

    self.group3CompleteLabel.font = [UIFont fontWithName:kNumberFont
                                                    size:30];
    self.group3UnlockedLabel.font = [UIFont fontWithName:kNumberFont
                                                    size:30];
    self.group3LockedLabel.font   = [UIFont fontWithName:kNumberFont
                                                    size:30];
}

#pragma mark - UIAlertView Delegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        [self performSegueWithIdentifier:@"signout" sender:nil];
    }
}
@end
