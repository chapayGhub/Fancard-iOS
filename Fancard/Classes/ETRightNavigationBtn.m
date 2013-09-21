//
//  ETRightNavigationBtn.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETRightNavigationBtn.h"
#import <UIColor+Expanded.h>
@implementation ETRightNavigationBtn

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
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithHexString:@"56527c"].CGColor;
    self.layer.borderWidth = 1;
}

- (void) nomalStatus
{
    self.backgroundColor = [UIColor clearColor];
    [self.img setImage:[UIImage imageNamed:@"right_arrow_normal"]];
}

- (IBAction) touchDown:(id)sender
{
    self.backgroundColor = [UIColor colorWithHexString:@"56527c"];
    [self.img setImage:[UIImage imageNamed:@"right_arrow_highlight"]];
}

- (IBAction) touchCancel:(id)sender
{
    [self nomalStatus];
}

- (IBAction) clicked:(id)sender
{
    [self nomalStatus];
    if (self.click)
        self.click();
}

@end
