//
//  ETPracticeViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETVideo.h"
@interface ETPracticeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView*  scrollView;
@property (nonatomic ,strong)        ETVideo*       video;
@end
