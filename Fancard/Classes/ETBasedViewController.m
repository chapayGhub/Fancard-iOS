//
//  ETBasedViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-21.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"
#import <UIColor+Expanded.h>
#import "ETLeftNavigationBtn.h"
#import "ETRightNavigationBtn.h"
@implementation ETBasedViewController

#pragma mark - UITableView LifeCycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
    
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title_image"]]];

    self.navigationItem.hidesBackButton = YES;
    
    [self setLeftBtnWithString:@"WELCOME"];
    [self setRightBtnWithString:@"SIGN IN"];
}

- (void) setLeftBtnWithString:(NSString*) str
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:10] removeFromSuperview];
    
    ETLeftNavigationBtn* btn = [[NSBundle mainBundle] loadNibNamed:@"ETLeftNavigationBtn"
                                                             owner:self
                                                           options:nil][0];
    btn.txt = str;
    btn.tag = 10;
    CGRect rect = btn.frame;
    rect.origin.y += 10;
    rect.origin.x += 5;
    btn.frame = rect;
    
    [btn setClick:^{
        [self leftBtnClick];
    }];
    [view addSubview:btn];
}

- (void) setRightBtnWithString:(NSString*) str
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:11] removeFromSuperview];
    
    ETRightNavigationBtn* btn = [[NSBundle mainBundle] loadNibNamed:@"ETRightNavigationBtn"
                                                              owner:self
                                                            options:nil][0];
    btn.txt = str;
    btn.tag = 11;
    CGRect rect = btn.frame;
    rect.origin.y += 5;
    rect.origin.x = 320-rect.size.width-5;
    btn.frame = rect;
    [view addSubview:btn];
    [btn setClick:^{
        [self rightBtnClick];
    }];
}

- (void) rightBtnClick
{
    NSLog(@"Right Btn Click");
}

- (void) leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end
