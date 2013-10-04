//
//  ETStoreViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETStoreViewController.h"
#import "ETStoreInnerView.h"
#import "UIImage+UIColor.h"
#import <UIColor+Expanded.h>
#import "SimpleAudioEngine.h"

#define kTotalCnt 6
@implementation ETStoreViewController

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
    self.rightBtn.disabled = NO;
}

- (void) setLeftBtnWithString:(NSString*) str
{
    UIView* view = self.navigationController.navigationBar;
    [[view viewWithTag:10
      ] removeFromSuperview];
    if (!str) return;
    ETLeftNavigationBtn2* btn = [[NSBundle mainBundle] loadNibNamed:@"ETLeftNavigationBtn2"
                                                             owner:self
                                                           options:nil][0];
    btn.txt = str;
    CGRect rect = btn.frame;
    rect.origin.y += 5;
    rect.origin.x += 5;
    btn.frame = rect;
    btn.tag = 10;
    
    [btn setClick:^{
        [self leftBtnClick];
    }];
    [view addSubview:btn];
    self.leftBtn = btn;
    self.leftBtn.disabled = NO;
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
    

    [self setLeftBtnWithString:@"BACK"];
    [self setRightBtnWithString:@"NEXT"];
    [self updateBtnStatus];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOS7)
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat x = 0;
    for (int i=0; i<kTotalCnt; i++) {
        ETStoreInnerView* innerView = [[NSBundle mainBundle] loadNibNamed:@"ETStoreInnerView"
                                                                    owner:self
                                                                  options:nil][0];
        CGRect rect = CGRectZero;
        rect.origin.x = x;
        rect.size = self.scrollView.frame.size;
        
        innerView.totalPages = kTotalCnt;
        innerView.currentPage = i;
        
        innerView.frame = rect;
        innerView.imageView.image = [UIImage imageNamed:@"store_demo.jpg"];
        [self.scrollView addSubview:innerView];
        x += 320;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, 0);
    self.scrollView.delegate = self;
    self.wantsFullScreenLayout = YES;
}

- (void) rightBtnClick
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + 320, 0) animated:YES];
}

- (void) leftBtnClick
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - 320, 0) animated:YES];
}

- (void) updateBtnStatus
{
    self.leftBtn.disabled = NO;
    self.rightBtn.disabled = NO;
    
    if (self.scrollView.contentOffset.x <= 0)
    {
        self.leftBtn.disabled = YES;
    }
    
    if (self.scrollView.contentOffset.x >= self.scrollView.contentSize.width-320)
    {
        self.rightBtn.disabled = YES;
    }
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateBtnStatus];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateBtnStatus];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Swipe_FloorSqueaks.mp3"];
}

@end
