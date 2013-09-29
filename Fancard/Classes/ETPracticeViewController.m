//
//  ETPracticeViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETPracticeViewController.h"
#import "ETPracticeInnerView.h"
#import "UIImage+UIColor.h"
#import <UIColor+Expanded.h>
#import "ETTabbar.h"
#import "ETGlobal.h"
#import "ETVideo.h"
#import <XCDYouTubeVideoPlayerViewController.h>
#import "ETNetworkAdapter.h"
#import <MBProgressHUD.h>
#import "ETPracticeConfrim1ViewController.h"
@implementation ETPracticeViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title_image"]]];
    
    if (iOS7)
    {
        [[self.navigationController navigationBar] setTintColor: [UIColor colorWithHexString:@"56527c"]];
    }
    else
    {
        
        [[self.navigationController navigationBar] setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor whiteColor]]
                                                        forBarMetrics:UIBarMetricsDefault];
    }
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger len = [ETGlobal sharedGlobal].allVideos.count;
    CGFloat x = 0;
    for (int i=0; i< len; i++) {
        ETPracticeInnerView* inner;
        if (iPhone5)
        {
            inner = [[NSBundle mainBundle] loadNibNamed:@"ETPracticeInnerView_iPhone5"
                                                  owner:self
                                                options:nil][0];
        }
        else
        {
             inner = [[NSBundle mainBundle] loadNibNamed:@"ETPracticeInnerView"
                                                   owner:self
                                                 options:nil][0];
        }
        
        CGRect rect = inner.frame;
        rect.origin.x = x;
        x += 320;
        inner.frame = rect;
        inner.totalPages = len;
        inner.currentPage = i;
        [inner setVideo:[ETGlobal sharedGlobal].allVideos[i]];
        __weak ETVideo* video = [ETGlobal sharedGlobal].allVideos[i];
        
        __block NSString* identifier = nil;
        NSArray* arr = [[video.video_url componentsSeparatedByString:@"?"][1] componentsSeparatedByString:@"&"];
        for (NSString* str in arr) {
            NSArray* _a = [str componentsSeparatedByString:@"="];
            if ([_a[0] isEqualToString:@"v"])
            {
                identifier = _a[1];
                break;
            }
        }
        
        [inner setChallangeBtnClickBlock:^{
            self.video = video;
            [self performSegueWithIdentifier:@"confirm" sender:nil];
        }];
        
        [inner setPlayBtnClickBlock:^{
            __block MBProgressHUD* hud;
            dispatch_async(dispatch_get_main_queue(), ^{
                hud = [MBProgressHUD showHUDAddedTo:self.view
                                           animated:YES];
                [hud setLabelText:@"Getting Videos"];
            });
            
            [[ETNetworkAdapter sharedAdapter] watchVideoWithVideoID:video.video_id
                                                          challenge:NO
                                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                NSDictionary* dict = [responseObject objectFromJSONData];
                                                                NSInteger t = [dict[@"addCredit"] integerValue];
                                                                if (t != 0)
                                                                {
                                                                    [ETGlobal sharedGlobal].userPointsToday = [ETGlobal sharedGlobal].userPointsToday + t;
                                                                    [ETGlobal sharedGlobal].userPointsTotal = [ETGlobal sharedGlobal].userPointsTotal + t;
                                                                    [ETGlobal sharedGlobal].userNumberWatchedvideo = [ETGlobal sharedGlobal].userNumberWatchedvideo + 1;
                                                                    [[ETGlobal sharedGlobal].watchedVideos addObject:[NSString stringWithFormat:@"%d", video.video_id]];
                                                                }
                                                                [hud hide:YES];
                                                                
                                                                XCDYouTubeVideoPlayerViewController* vc =[[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:identifier];
                                                                [self presentViewController:vc
                                                                                   animated:YES
                                                                                 completion:nil];
                                                                
                                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                [hud setLabelText:@"Getting error"];
                                                                [hud hide:YES afterDelay:1];
                                                            }];
        }];
        [self.scrollView addSubview:inner];
    }
    
    [self.scrollView setContentSize:CGSizeMake(x, self.scrollView.frame.size.height)];
    
    if (iOS7)
        self.automaticallyAdjustsScrollViewInsets = NO;
    self.wantsFullScreenLayout = YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"confirm"])
    {
        ETPracticeConfrim1ViewController* vc = [segue destinationViewController];
        vc.video = self.video;
    }
}
@end
