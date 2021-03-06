//
//  ETRankViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETRankViewController.h"
#import "UIImage+UIColor.h"
#import <UIColor+Expanded.h>
#import "ETRankCell.h"
#import "ETGlobal.h"

#import "ETNetworkAdapter.h"
#import <MBProgressHUD.h>
#import "SimpleAudioEngine.h"
@implementation ETRankViewController
- (IBAction) segValueChanged
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    if (self.segControl.selectedSegmentIndex)
    {
        [self selectRight];
    }
    else
    {
        [self selectLeft];
    }
}
- (void) refreshData
{
    if (self.todayRank)
    {
        NSLog(@"%@", [ETGlobal sharedGlobal].userName);
        for (int i=0; i<[ETGlobal sharedGlobal].todayRank.count; i++) {
            if ([[ETGlobal sharedGlobal].todayRank[i][@"user_name"] isEqualToString:[ETGlobal sharedGlobal].userName])
            {
                self.leftLabel.text = [NSString stringWithFormat:@"#%d", i+1];
                break;
            }
        }
        
        self.rightLabel.text = [NSString stringWithFormat:@"%d pts.", [ETGlobal sharedGlobal].userPointsToday];
    }
    else
    {
        for (int i=0; i<[ETGlobal sharedGlobal].totalRank.count; i++) {
            if ([[ETGlobal sharedGlobal].totalRank[i][@"user_name"] isEqualToString:[ETGlobal sharedGlobal].userName])
            {
                self.leftLabel.text = [NSString stringWithFormat:@"#%d", i+1];
                break;
            }
        }
        
        self.rightLabel.text = [NSString stringWithFormat:@"%d pts.", [ETGlobal sharedGlobal].userPointsTotal];
    }
    
    [[self tableView ] reloadData];
}

- (void) selectLeft
{
    self.todayRank = NO;
    [ETGlobal sharedGlobal].totalRank = nil;
    if ([ETGlobal sharedGlobal].totalRank == nil)
    {
        __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Loading..."];
        [ETGlobal sharedGlobal].totalRank = [NSMutableArray array];
        
        [[ETNetworkAdapter sharedAdapter] getRankListTotalWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary* dict = [responseObject objectFromJSONData];
            for (int i=0; i<dict.allKeys.count; i++) {
                NSString* key = [NSString stringWithFormat:@"%d", i];
                if (dict[key])
                {
                    [[ETGlobal sharedGlobal].totalRank addObject:dict[key]];
                }
            }
            
            [hud hide:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshData];
            });
        }
                                                              failure:nil];
    }
    else
    {
        [self refreshData];
    }
}

- (void) selectRight
{
    self.todayRank = YES;
    [ETGlobal sharedGlobal].todayRank = nil;
    if ([ETGlobal sharedGlobal].todayRank == nil)
    {
        __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Loading..."];
        [ETGlobal sharedGlobal].todayRank = [NSMutableArray array];
        
        [[ETNetworkAdapter sharedAdapter] getRankListTodayWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary* dict = [responseObject objectFromJSONData];
            for (int i=0; i<dict.allKeys.count; i++) {
                NSString* key = [NSString stringWithFormat:@"%d", i];
                if (dict[key])
                {
                    [[ETGlobal sharedGlobal].todayRank addObject:dict[key]];
                }
            }
            [hud hide:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshData];
            });
        }
                                                              failure:nil];
    }
    else
    {
        [self refreshData];
    }
}

#pragma mark - UIViewController LifeCycle
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
    
    if (!self.leftLabel)
    {
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:kDefaultFont size:22];
        label.textColor = [UIColor colorWithHexString:@"56527c"];
        label.frame = CGRectMake(5, 10, 50, 25);
        [self.navigationController.navigationBar addSubview:label];
        self.leftLabel = label;
    }
    
    if (!self.rightLabel)
    {
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:kDefaultFont size:22];
        label.textColor = [UIColor colorWithHexString:@"56527c"];
        label.frame = CGRectMake(215, 10, 100, 25);
        label.textAlignment = NSTextAlignmentRight;
        [self.navigationController.navigationBar addSubview:label];
        self.rightLabel = label;
    }

    [self selectLeft];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (iOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    else
        self.wantsFullScreenLayout = YES;
}

#pragma mark - UITableView DataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.todayRank)
        return [ETGlobal sharedGlobal].todayRank.count;
    else
        return [ETGlobal sharedGlobal].totalRank.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* key = @"default";
    ETRankCell* cell = [tableView dequeueReusableCellWithIdentifier:key];
    if (indexPath.row % 2)
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"56527c"];
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"56527c"];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"454263"];
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"454263"];
    }
    
    cell.rankLabel.text = [NSString stringWithFormat:@"#%d", indexPath.row+1];
    NSDictionary* dict;
    if (self.todayRank)
    {
        dict = [ETGlobal sharedGlobal].todayRank[indexPath.row];
        cell.scoreLabel.text = dict[@"user_points_today"];
    }
    else
    {
        dict = [ETGlobal sharedGlobal].totalRank[indexPath.row];
        cell.scoreLabel.text = dict[@"user_points_total"];
    }
    
    cell.usernameLabel.text = dict[@"user_name"];
    
    __block NSString* str =[NSTemporaryDirectory() stringByAppendingFormat:@"%@.jpg", dict[@"user_name"]];
    __block NSIndexPath* index = indexPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:str])
    {
        [[ETNetworkAdapter sharedAdapter] downloadAvatarWithUserName:dict[@"user_name"]
                                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                 NSData* data= responseObject;
                                                                 
                                                                 NSLog(@"%@", data);
                                                                 
                                                                 [data writeToFile:str atomically:YES];
                                                                 [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                             }
                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                 UIImage* image = [UIImage imageNamed:@"icon.jpg"];
                                                                 [UIImageJPEGRepresentation(image, 1) writeToFile:str
                                                                                                       atomically:YES];
                                                                 [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                             }];
        cell.avatarView.image = nil;
    }
    else
    {
        cell.avatarView.image = [UIImage imageWithContentsOfFile:str];
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
