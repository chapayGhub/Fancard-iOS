//
//  ETRankViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETRankViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet    UISegmentedControl* segControl;
@property (nonatomic, weak) IBOutlet    UITableView*        tableView;
@property (nonatomic, weak) UILabel*                        leftLabel;
@property (nonatomic, weak) UILabel*                        rightLabel;


@end
