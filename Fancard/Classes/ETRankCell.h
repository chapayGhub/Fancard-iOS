//
//  ETRankCell.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETRankCell : UITableViewCell

@property (nonatomic, weak) IBOutlet    UIImageView*    avatarView;
@property (nonatomic, weak) IBOutlet    UILabel*        rankLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        usernameLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        scoreLabel;

@end
