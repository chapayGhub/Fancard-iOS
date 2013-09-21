//
//  ETRightNavigationBtn.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETRightNavigationBtn : UIView

@property (nonatomic, weak) IBOutlet    UIButton*       btn;
@property (nonatomic, weak) IBOutlet    UIImageView*    img;
@property (nonatomic, strong)           NSString*       txt;
@property (nonatomic, strong)           void            (^ click)();

- (IBAction) touchDown:(id)sender;
- (IBAction) touchCancel:(id)sender;
- (IBAction) clicked:(id)sender;
@end
