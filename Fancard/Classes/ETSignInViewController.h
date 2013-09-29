//
//  ETSignInViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"
#import <MBProgressHUD.h>

@interface ETSignInViewController : ETBasedViewController

@property (nonatomic, weak) IBOutlet    UITextField*    usernameField;
@property (nonatomic, weak) IBOutlet    UITextField*    passwordField;
@property (nonatomic, weak) IBOutlet    UIButton*       forgotPasswordBtn;
@property (nonatomic, assign)           NSInteger       requestCnt;
@property (nonatomic, weak)             MBProgressHUD*  hud;
- (IBAction) forgotPwdBtnClick:(id)sender;
- (IBAction) checkDone:(id)sender;
@end
