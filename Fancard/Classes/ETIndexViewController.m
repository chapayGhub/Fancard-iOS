//
//  ETIndexViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-20.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETIndexViewController.h"
#import "UIImage+UIColor.h"
#import <QuartzCore/QuartzCore.h>
#import "SimpleAudioEngine.h"
@implementation ETIndexViewController

#pragma mark - UIViewController LifeCycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    if (self.view.frame.size.height > 480)
    {
        self.backgroundView.image = [UIImage imageNamed:@"index_background@2x~568.jpg"];
        CGRect rect = self.boxView.frame;
        rect.origin.y = 449;
        self.boxView.frame = rect;
    }
    
    [self.regBtn setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor colorWithWhite:219/255. alpha:1]]
                           forState:UIControlStateHighlighted];
    [self.signInBtn setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor colorWithWhite:219/255. alpha:1]]
                              forState:UIControlStateHighlighted];
    self.regBtn.layer.cornerRadius = 5;
    self.regBtn.layer.masksToBounds = YES;
    
    self.signInBtn.layer.cornerRadius = 5;
    self.signInBtn.layer.masksToBounds = YES;
    
    self.title = @"WELCOME";
    
    [self.signInLabel setFont:[UIFont fontWithName:kDefaultFont size:17]];
    [self.regLabel setFont:[UIFont fontWithName:kDefaultFont size:17]];
}

@end
