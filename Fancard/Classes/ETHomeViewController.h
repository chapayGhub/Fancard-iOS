//
//  ETHomeViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ETStoreViewController.h"
#import <MBProgressHUD.h>
@interface ETHomeViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet    UIImageView*    background;
@property (nonatomic, weak) ETStoreViewController*      storeViewController;

@property (nonatomic, weak) IBOutlet    UIView*         viewGroup1;
@property (nonatomic, weak) IBOutlet    UIView*         viewGroup2;
@property (nonatomic, weak) IBOutlet    UIView*         viewGroup3;

@property (nonatomic, weak) IBOutlet    UILabel*        group1CompleteLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        group1UnlockedLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        group1LockedLabel;

@property (nonatomic, weak) IBOutlet    UILabel*        group2CompleteLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        group2UnlockedLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        group2LockedLabel;

@property (nonatomic, weak) IBOutlet    UILabel*        group3CompleteLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        group3UnlockedLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        group3LockedLabel;

@property (atomic, assign)              NSInteger       requestCnt;
@property (nonatomic, weak)             MBProgressHUD*  hud;

- (IBAction) group1BtnClick:(id)sender;
@end
