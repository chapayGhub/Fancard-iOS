//
//  ETLeftNavigationBtn.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETLeftNavigationBtn.h"

@implementation ETLeftNavigationBtn

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
}

- (IBAction) clicked:(id)sender
{
    if (self.click)
        self.click();
}
@end
