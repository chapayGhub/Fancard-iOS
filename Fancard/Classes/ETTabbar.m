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
@end
