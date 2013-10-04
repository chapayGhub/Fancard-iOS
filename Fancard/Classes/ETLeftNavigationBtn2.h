//
//  ETLeftNavigationBtn2.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-22.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETLeftNavigationBtn2 : UIView

@property (nonatomic, weak) IBOutlet    UIButton*       btn;
@property (nonatomic, weak) IBOutlet    UIImageView*    img;
@property (nonatomic, strong)           NSString*       txt;
@property (nonatomic, strong)           void            (^ click)();
@property (nonatomic, assign)           BOOL            disabled;

- (IBAction) clicked:(id)sender;
@end
