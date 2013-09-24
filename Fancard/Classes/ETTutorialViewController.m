//
//  ETTutorialViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTutorialViewController.h"
#define tutorialCnt 5

@implementation ETTutorialViewController

#pragma mark - ETBasedViewController Overload
- (void) leftBtnClick
{
    [self performSegueWithIdentifier:@"signin" sender:nil];
}

- (void) rightBtnClick
{
    
}

- (void) leftSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    
}


#pragma mark - UIViewController LifeCycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftBtnWithString:@"SKIP"];
    [self setRightBtnWithString:@"NEXT"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FXPageControl* pageControl = [[FXPageControl alloc] init];
    [pageControl setDotImage:[UIImage imageNamed:@"pagecontrol_normal"]];
    [pageControl setSelectedDotImage:[UIImage imageNamed:@"pagecontrol_select"]];
    [pageControl setNumberOfPages:tutorialCnt];
    self.pageControl = pageControl;
    if (iOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    CGFloat width = 0, height = 0;
    for (int i=0; i<tutorialCnt; i++) {
        UIImage* image = [UIImage imageNamed:@"tutorial_1"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [imageView sizeToFit];
        CGRect rect = imageView.frame;
        rect.origin.x = width;
        rect.origin.y = 0;
        width += rect.size.width;
        height = rect.size.height;
        imageView.frame = rect;
        [self.scrollView addSubview:imageView];
    }
    
    [self.scrollView setContentSize:CGSizeMake(width, self.scrollView.frame.size.height)];
    
    CGSize size = [pageControl sizeForNumberOfPages:10];
    size.width += 10;
    CGRect rect = CGRectZero;
    rect.size = size;
    rect.origin.x = 160-rect.size.width/2;
    if (iPhone5)
    {
        rect.origin.y = 510;
    }
    else
    {
        rect.origin.y = 450;
    }
    
    pageControl.frame = rect;
    pageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 320 * (tutorialCnt-1))
    {
        scrollView.userInteractionEnabled = NO;
        [self performSegueWithIdentifier:@"signin" sender:nil];
    }
    else
    {
        NSLog(@"%f", scrollView.contentOffset.x / 320);
        
        self.pageControl.currentPage = scrollView.contentOffset.x / 320;
    }
} 
@end
