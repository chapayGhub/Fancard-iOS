//
//  ETSignInViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"

@interface ETSignInViewController : ETBasedViewController

@property (nonatomic, weak) IBOutlet    UITextField*    usernameField;
@property (nonatomic, weak) IBOutlet    UITextField*    passwordField;
@property (nonatomic, weak) IBOutlet    UIButton*       forgotPasswordBtn;

- (IBAction) forgotPwdBtnClick:(id)sender;
@end
