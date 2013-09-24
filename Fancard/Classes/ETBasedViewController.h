//
//  ETBasedViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-21.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETLeftNavigationBtn.h"
#import "ETRightNavigationBtn.h"
#import <UIColor+Expanded.h>

@interface ETBasedViewController : UIViewController

@property (nonatomic, weak) ETLeftNavigationBtn*    leftBtn;
@property (nonatomic, weak) ETRightNavigationBtn*   rightBtn;

- (void) rightBtnClick;
- (void) leftBtnClick;
- (void) setLeftBtnWithString:(NSString*) str;
- (void) setRightBtnWithString:(NSString*) str;
- (void) leftSwipeGesture:(UISwipeGestureRecognizer*) gesture;
@end
