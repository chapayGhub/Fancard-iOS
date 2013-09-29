//
//  ETTabbar.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTabbar.h"
#import <QuartzCore/QuartzCore.h>
#import <UIColor+Expanded.h>
#import "ETGlobal.h"
@implementation ETTabbar

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.avatarView.layer.borderColor = [UIColor colorWithHexString:@"9e7f38"].CGColor;
    self.avatarView.layer.borderWidth = 3;
    self.avatarView.layer.cornerRadius = 35;
    self.avatarView.layer.masksToBounds = YES;
    
    self.scoreLabel.adjustsFontSizeToFitWidth = YES;
    self.scoreLabel.font = [UIFont fontWithName:kDefaultFont size:22];
    
    self.avatarView.image = [ETGlobal sharedGlobal].avatar;
    [self refreshTabbarScore];
    
    [[ETGlobal sharedGlobal] addObserver:self
                              forKeyPath:@"userPointsTotal"
                                 options:NSKeyValueObservingOptionNew
                                 context:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self refreshTabbarScore];
}


- (void) refreshTabbarScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d pts", [ETGlobal sharedGlobal].userPointsTotal];
}

- (IBAction) leftBtnClick:(id)sender
{
    if (self.leftBtnClickBlock)
    {
        self.leftBtnClickBlock();
    }
}

- (IBAction) rightBtnClick:(id)sender
{
    if (self.rightBtnClickBlock)
    {
        self.rightBtnClickBlock();
    }
}

- (IBAction) middleBtnClick:(id)sender
{
    if (self.middleBtnClickBlock)
    {
        self.middleBtnClickBlock();
    }
}

- (void) dealloc
{
    [[ETGlobal sharedGlobal] removeObserver:self forKeyPath:@"userPointsTotal"];
}
@end
