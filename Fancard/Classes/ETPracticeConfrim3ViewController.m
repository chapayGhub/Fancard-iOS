//
//  ETPracticeConfrim3ViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETPracticeConfrim3ViewController.h"
#import "ETNetworkAdapter.h"
#import "ETGlobal.h"
#import <MBProgressHUD.h>
@implementation ETPracticeConfrim3ViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBtnWithString:@"DONE"];
    self.rightBtn.disabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone5)
    {
        self.imageView.image = [UIImage imageNamed:@"practice_confirm3@2x~568.jpg"];
        self.imageView.frame = CGRectMake(0, 64, 320, 504);
    }
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Sysc With Server"];
    [[ETNetworkAdapter sharedAdapter] watchVideoWithVideoID:self.video.video_id
                                                  challenge:YES
                                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                        NSDictionary* dict = [responseObject objectFromJSONData];
                                                        NSInteger t = [dict[@"addCredit"] integerValue];
                                                        if (t != 0)
                                                        {
                                                            [ETGlobal sharedGlobal].userPointsToday = [ETGlobal sharedGlobal].userPointsToday + t;
                                                            [ETGlobal sharedGlobal].userPointsTotal = [ETGlobal sharedGlobal].userPointsTotal + t;
                                                        }
                                                        [hud hide:YES];
                                                        self.rightBtn.disabled = NO;
                                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                        [hud setLabelText:@"Sync Error"];
                                                        [hud hide:YES afterDelay:1];
                                                        [hud setMode:MBProgressHUDModeText];
                                                    }];
}

- (void) leftSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    
}

- (void) rightBtnClick
{
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

@end
