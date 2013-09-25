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

#define kTotalCnt 6
@implementation ETStoreViewController
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
    
    self.wantsFullScreenLayout = YES;
}

@end
