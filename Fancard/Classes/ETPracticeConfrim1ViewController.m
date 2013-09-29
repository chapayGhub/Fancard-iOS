//
//  ETPracticeConfrim1ViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETPracticeConfrim1ViewController.h"
#import "ETPracticeConfrim2ViewController.h"
@implementation ETPracticeConfrim1ViewController
- (void) rightBtnClick
{
    ETPracticeConfrim2ViewController* vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"ETPracticeConfrim2ViewController"];
    vc.video = self.video;
    [[self navigationController] pushViewController:vc animated:NO];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftBtnWithString:@"LESSION"];
    [self setRightBtnWithString:@"DONE"];
    self.rightBtn.disabled = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone5)
    {
        self.imageView.image = [UIImage imageNamed:@"practice_confirm1@2x~568.jpg"];
        self.imageView.frame = CGRectMake(0, 64, 320, 504);
    }
}
@end
