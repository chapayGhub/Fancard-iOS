//
//  ETTutorialViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"
#import <FXPageControl.h>

@interface ETTutorialViewController : ETBasedViewController<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet    UIScrollView*   scrollView;
@property (nonatomic, weak) IBOutlet    UILabel*        hintLabel;
@property (nonatomic, weak) IBOutlet    UIImageView*    arrowImage;

@property (nonatomic, weak)             FXPageControl*  pageControl;

@end
