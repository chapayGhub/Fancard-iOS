//
//  ETPracticeViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETVideo.h"
#import "ETLeftNavigationBtn2.h"
#import "ETRightNavigationBtn.h"

@interface ETPracticeViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, weak) ETLeftNavigationBtn2*    leftBtn;
@property (nonatomic, weak) ETRightNavigationBtn*   rightBtn;

- (void) rightBtnClick;
- (void) leftBtnClick;
- (void) setLeftBtnWithString:(NSString*) str;
- (void) setRightBtnWithString:(NSString*) str;

@property (weak, nonatomic) IBOutlet UIScrollView*  scrollView;
@property (nonatomic ,strong)        ETVideo*       video;
@end
