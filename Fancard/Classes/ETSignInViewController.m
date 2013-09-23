//
//  ETSignInViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETSignInViewController.h"

@implementation ETSignInViewController

#pragma mark - UIViewController LifeCycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBtnWithString:@"SIGN IN"];
    [self setLeftBtnWithString:@"WELCOME"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.usernameField setValue:[UIColor colorWithHexString:@"9e7f38"]
                      forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordField setValue:[UIColor colorWithHexString:@"9e7f38"]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:@"Forgot password?"];
    
    [commentString addAttribute:NSUnderlineStyleAttributeName
                          value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                          range:NSMakeRange(0, [commentString length])];
    
    [commentString addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"9e7f38"]
                          range:NSMakeRange(0, [commentString length])];
    
    [self.forgotPasswordBtn setAttributedTitle:commentString
                                      forState:UIControlStateNormal];
}

- (IBAction) forgotPwdBtnClick:(id)sender
{
    
}
@end
