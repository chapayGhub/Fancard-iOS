//
//  ETBasedViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-21.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"
#import <UIColor+Expanded.h>
#import "UIImage+UIColor.h"
@implementation ETBasedViewController

- (void) setLeftBtnWithString:(NSString*) str
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:10
] removeFromSuperview];
    if (!str) return;
    ETLeftNavigationBtn* btn = [[NSBundle mainBundle] loadNibNamed:@"ETLeftNavigationBtn"
                                                             owner:self
                                                           options:nil][0];
    btn.txt = str;
    CGRect rect = btn.frame;
    rect.origin.y += 10;
    rect.origin.x += 5;
    btn.frame = rect;
    btn.tag = 10;

    [btn setClick:^{
        [self leftBtnClick];
    }];
    [view addSubview:btn];
    self.leftBtn = btn;
}

- (void) setRightBtnWithString:(NSString*) str
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:11] removeFromSuperview];
    if (!str) return;
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
    self.rightBtn = btn;
    self.rightBtn.disabled = YES;
}

- (void) rightBtnClick
{
    NSLog(@"Right Btn Click");
}

- (void) leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) leftSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableView LifeCycle

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    self.wantsFullScreenLayout = YES;
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(leftSwipeGesture:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

@end
