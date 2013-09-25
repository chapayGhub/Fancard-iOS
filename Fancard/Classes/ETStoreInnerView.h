//
//  ETStoreInnerView.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-25.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXPageControl.h>

@interface ETStoreInnerView : UIView

@property (nonatomic, weak) IBOutlet    UIImageView*    imageView;
@property (nonatomic, weak) IBOutlet    UILabel*        titleLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        buyValueLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        redeemValueLabel;
@property (nonatomic, weak) IBOutlet    UILabel*        shareValueLabel;
@property (nonatomic, strong)           void (^buyBtnClickBlock)();
@property (nonatomic, strong)           void (^redeemBtnClickBlock)();
@property (nonatomic, strong)           void (^shareBtnClickBlock)();

@property (nonatomic, assign)           NSInteger       currentPage;
@property (nonatomic, assign)           NSInteger       totalPages;
@property (nonatomic, weak)             FXPageControl*  pageControl;

- (IBAction) buyBtnClick:(id)sender;
- (IBAction) redeemBtnClick:(id)sender;
- (IBAction) shareBtnClick:(id)sender;

@end
