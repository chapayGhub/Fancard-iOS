//
//  ETTabbarController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETTabbarController.h"
#import "ETTabbar.h"
#import "SimpleAudioEngine.h"
@implementation ETTabbarController

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.tabBar.hidden = YES;
    self.selectedIndex = 1;
    
    ETTabbar* tabbar = [[NSBundle mainBundle] loadNibNamed:@"ETTabbar" owner:self options:Nil][0];
    CGRect rect = tabbar.frame;
    rect.origin.y = self.view.frame.size.height - rect.size.height;
    tabbar.frame = rect;
    [tabbar setLeftBtnClickBlock:^{
        if (self.selectedIndex != 0)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
        }
        self.selectedIndex = 0;
    }];
    
    [tabbar setRightBtnClickBlock:^{
        if (self.selectedIndex != 2)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
        }
        self.selectedIndex = 2;
    }];
    
    [tabbar setMiddleBtnClickBlock:^{
        if (self.selectedIndex != 1)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
        }
        self.selectedIndex = 1;
    }];
    
    [self.view addSubview:tabbar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
