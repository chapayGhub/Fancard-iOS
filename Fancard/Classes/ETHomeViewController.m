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

@implementation ETHomeViewController

#pragma mark - IBAction

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
    self.group1CompleteLabel.text = @"0";
    self.group1UnlockedLabel.text = @"3";
    self.group1LockedLabel.text = @"20";

    self.group2CompleteLabel.text = @"2";
    self.group2UnlockedLabel.text = @"10";
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
