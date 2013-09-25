//
//  ETTabbar.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETTabbar : UIView

@property (nonatomic, weak) IBOutlet    UILabel*        scoreLabel;
@property (nonatomic, weak) IBOutlet    UIImageView*    avatarView;
@property (nonatomic, strong)           void (^leftBtnClickBlock)();
@property (nonatomic, strong)           void (^rightBtnClickBlock)();
@property (nonatomic, strong)           void (^middleBtnClickBlock)();

- (IBAction) leftBtnClick:(id)sender;
- (IBAction) rightBtnClick:(id)sender;
- (IBAction) middleBtnClick:(id)sender;

@end
