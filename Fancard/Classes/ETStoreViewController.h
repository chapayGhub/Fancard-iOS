//
//  ETStoreViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETRightNavigationBtn.h"
#import "ETLeftNavigationBtn2.h"

@interface ETStoreViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, weak) ETLeftNavigationBtn2*    leftBtn;
@property (nonatomic, weak) ETRightNavigationBtn*   rightBtn;

- (void) rightBtnClick;
- (void) leftBtnClick;
- (void) setLeftBtnWithString:(NSString*) str;
- (void) setRightBtnWithString:(NSString*) str;

@property (nonatomic, weak) IBOutlet    UIScrollView*   scrollView;

@end
