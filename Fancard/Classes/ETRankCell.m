//
//  ETRankCell.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETRankCell.h"
#import <UIColor+Expanded.h>
#import <QuartzCore/QuartzCore.h>

@implementation ETRankCell

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.avatarView.layer.cornerRadius = 25;
    self.avatarView.layer.borderColor = [UIColor colorWithHexString:@"9e7f38"].CGColor;
    self.avatarView.layer.borderWidth = 2.5;
    self.avatarView.layer.masksToBounds = YES;
    
    self.rankLabel.font = [UIFont fontWithName:kDefaultFont size:17];
    self.scoreLabel.font = [UIFont fontWithName:kDefaultFont size:17];;
    self.usernameLabel.font = [UIFont fontWithName:kDefaultFont size:17];
    [self.usernameLabel  setAdjustsFontSizeToFitWidth: YES];
}

@end
