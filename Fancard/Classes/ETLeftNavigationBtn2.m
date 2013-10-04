//
//  ETLeftNavigationBtn2.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETLeftNavigationBtn2.h"
#import <UIColor+Expanded.h>
@implementation ETLeftNavigationBtn2

- (void) setDisabled:(BOOL)disabled
{
    _disabled = disabled;
    if (disabled)
    {
        [self disabledStatus];
    }
    else
    {
        [self normalStatus];
    }
}

- (void) setTxt:(NSString *)txt
{
    _txt = txt;
    [self.btn setTitle:txt forState:UIControlStateNormal];
    CGSize size1 = self.btn.frame.size;
    [self.btn sizeToFit];
    CGSize size2 = self.btn.frame.size;
    
    CGFloat delta = size2.width - size1.width;
    CGRect rect = self.frame;
    
    rect.size.width += delta;
    self.frame = rect;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    if (!iOS7)
    {
        CGRect rect = self.btn.frame;
        rect.origin.y += 5;
        self.btn.frame = rect;
    }
    
    self.btn.titleLabel.font = [UIFont fontWithName:kDefaultFont size:17];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithHexString:@"56527c"].CGColor;
    self.layer.borderWidth = 1;
}

- (void) disabledStatus
{
    self.backgroundColor = [UIColor clearColor];
    [self.img setImage:[UIImage imageNamed:@"left_arrow"]];
    [self.btn setEnabled:NO];
}

- (void) normalStatus
{
    self.backgroundColor = [UIColor colorWithHexString:@"56527c"];
    UIImage* img = [UIImage imageNamed:@"left_arrow_highlight"];
    [self.img setImage: img];
    [self.btn setEnabled:YES];
}

- (IBAction) clicked:(id)sender
{
    if (self.click)
        self.click();
}

@end
