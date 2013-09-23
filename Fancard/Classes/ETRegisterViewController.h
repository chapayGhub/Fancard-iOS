//
//  ETRegisterViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-21.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"

@interface ETRegisterViewController : ETBasedViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet    UITextField*    userName;
@property (nonatomic, weak) IBOutlet    UITextField*    passWord;
@property (nonatomic, weak) IBOutlet    UIButton*       facebook;
@property (nonatomic, weak) IBOutlet    UITextField*    email;
@property (nonatomic, weak) IBOutlet    UIButton*       camera;
@property (nonatomic, weak) IBOutlet    UILabel*        cameraLabel;
@property (nonatomic, weak) IBOutlet    UITextField*    name;
@property (nonatomic, weak) IBOutlet    UIButton*       privacyPolicy;
@property (nonatomic, weak) IBOutlet    UIButton*       termsOfService;
@property (nonatomic, weak) IBOutlet    UIView*         licenceView;
@property (nonatomic, strong)           UIImage*        avatarImage;

- (IBAction) facebookBtnClick:(id)sender;
- (IBAction) cameraBtnClick:(id) sender;
- (IBAction) privacyPolicyBtnClick:(id)sender;
- (IBAction) termsOfServiceBtnClick:(id) sender;
- (IBAction) closeKeyBoard:(id)sender;
@end
