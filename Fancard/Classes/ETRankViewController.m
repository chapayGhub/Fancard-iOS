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
@implementation ETRankViewController

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
    
    self.leftLabel.text = @"#0";
    self.rightLabel.text = @"20 pts.";
}

- (void) refreshData
{
    
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
    
    self.todayRank = NO;
    
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
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
