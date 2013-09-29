//
//  ETPracticeInnerView.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXPageControl.h>
#import "ETVideo.h"
@interface ETPracticeInnerView : UIView

@property (nonatomic, weak) IBOutlet    UILabel*        lessionTitleLabel;
@property (nonatomic, weak) IBOutlet    UIImageView*    videoPreview;
@property (nonatomic, weak) IBOutlet    UIView*         watchVideoAddScoreBgView;
@property (nonatomic, weak) IBOutlet    UILabel*        watchVideoAddScoreLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        challengeTitleLabel;
@property (nonatomic, weak) IBOutlet    UIView*         challengeAddScoreBgView;
@property (nonatomic, weak) IBOutlet    UILabel*        challengeAddScoreLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        healthHint;
@property (nonatomic, weak)             FXPageControl*  pageControl;
@property (nonatomic, assign)           NSInteger       currentPage;
@property (nonatomic, assign)           NSInteger       totalPages;

@property (nonatomic, strong)           void            (^playBtnClickBlock)();
@property (nonatomic, strong)           void            (^challangeBtnClickBlock)();

- (void) setVideo:(ETVideo*) video;

@end
