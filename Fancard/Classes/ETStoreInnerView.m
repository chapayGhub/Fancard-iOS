//
//  ETStoreInnerView.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETStoreInnerView.h"

@implementation ETStoreInnerView
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
- (void) awakeFromNib
{
    [super  awakeFromNib];
    
    self.titleLabel.font = [UIFont fontWithName:kDefaultFont size:20];
    self.buyValueLabel.font = [UIFont fontWithName:kDefaultFont size:17];
    self.redeemValueLabel.font = [UIFont  fontWithName:kDefaultFont size:17];
    self.shareValueLabel.font = [UIFont fontWithName:kDefaultFont size:17];
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
    rect.origin.y = 140;
    rect.origin.x = 160 - rect.size.width/2;
    pageControl.frame = rect;
    pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:pageControl];
    
    self.pageControl = pageControl;
}

- (IBAction) buyBtnClick:(id)sender
{
    if (self.buyBtnClickBlock)
        self.buyBtnClickBlock();
}

- (IBAction) redeemBtnClick:(id)sender
{
    if (self.redeemBtnClickBlock)
        self.redeemBtnClickBlock();
}

- (IBAction) shareBtnClick:(id)sender
{
    if (self.shareBtnClickBlock)
        self.shareBtnClickBlock();
}

@end
