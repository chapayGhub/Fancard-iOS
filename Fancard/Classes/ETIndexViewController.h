//
//  ETIndexViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-20.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETIndexViewController : UIViewController


@property (nonatomic, weak) IBOutlet    UIImageView*    backgroundView;
@property (nonatomic, weak) IBOutlet    UIView*         boxView;
@property (nonatomic, weak) IBOutlet    UIButton*       regBtn;
@property (nonatomic, weak) IBOutlet    UIButton*       signInBtn;
@property (nonatomic, weak) IBOutlet    UILabel*        regLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        signInLabel;

@end
