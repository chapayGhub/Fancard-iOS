//
//  ETPracticeInnerView.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETPracticeInnerView.h"
#import "ETGlobal.h"
#import <UIImageView+AFNetworking.h>
@implementation ETPracticeInnerView

- (void) setVideo:(ETVideo *)video
{
    self.lessionTitleLabel.text = video.video_title;
    self.challengeTitleLabel.text = video.video_challenge;
    if (iPhone5)
        self.healthHint.text = video.video_healthtip;
    else
        self.healthHint.text = [NSString stringWithFormat:@"HEALTH TIP - %@", video.video_healthtip];
    
    self.watchVideoAddScoreLabel.text = [NSString stringWithFormat:@"+%d", video.video_points_watching];
    self.challengeAddScoreLabel.text = [NSString stringWithFormat:@"+%d", video.video_points_challenge];
    
    for (NSString* str in [ETGlobal sharedGlobal].watchedVideos) {
        if (video.video_id == [str integerValue])
        {
            self.watchVideoAddScoreBgView.hidden = YES;
            break;
        }
    }
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", kServerURL, video.video_url]);
    [self.videoPreview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kServerURL, video.video_screenshot]]];
    
}

- (void) setTotalPages:(NSInteger)totalPages
{
    _totalPages = totalPages;
    self.currentPage = 0;
    [self initPageControl];
}

- (void) setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    self.pageControl.currentPage = currentPage;
}

- (void) initPageControl
{
    FXPageControl* pageControl = [[FXPageControl alloc] init];
    [pageControl setDotImage:[UIImage imageNamed:@"pagecontrol_normal"]];
    [pageControl setSelectedDotImage:[UIImage imageNamed:@"pagecontrol_select"]];
    [pageControl setNumberOfPages:self.totalPages];
    [pageControl setCurrentPage:self.currentPage];
    CGSize size = [pageControl sizeForNumberOfPages:self.totalPages];
    CGRect rect = pageControl.frame;
    size.width += 10;
    rect.size = size;
    rect.origin.y = 25;
    rect.origin.x = 160 - rect.size.width/2;
    pageControl.frame = rect;
    pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:pageControl];
    
    self.pageControl = pageControl;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.watchVideoAddScoreBgView.layer.borderWidth = 1;
    self.watchVideoAddScoreBgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.challengeAddScoreBgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.challengeAddScoreBgView.layer.borderWidth = 1;
    
    self.healthHint.font = [UIFont fontWithName:kDefaultFont
                                           size:13];
    self.challengeTitleLabel.font = [UIFont fontWithName:kDefaultFont
                                                    size:25];
    self.lessionTitleLabel.font = [UIFont fontWithName:kDefaultFont
                                                  size:17];
}

- (IBAction)playBtnClick:(id)sender {
    if (self.playBtnClickBlock)
        self.playBtnClickBlock();
}
- (IBAction)challengeBtnClick:(id)sender {
    if (self.challangeBtnClickBlock)
        self.challangeBtnClickBlock();
}

@end
