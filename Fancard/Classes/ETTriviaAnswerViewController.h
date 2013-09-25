//
//  ETTriviaAnswerViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETQuestion.h"

enum _ETTriviaResult {
    kTriviaResultTimeOut,
    kTriviaResultRight,
    kTriviaResultWrong
    };
typedef enum _ETTriviaResult ETTriviaResult;

@interface ETTriviaAnswerViewController : UIViewController


@property (nonatomic, assign)           NSInteger       remainTime;
@property (nonatomic, strong)           NSTimer*        timer;
@property (nonatomic, weak) IBOutlet    UILabel*        questionView;
@property (nonatomic, weak) IBOutlet    UILabel*        answer1;
@property (nonatomic, weak) IBOutlet    UILabel*        answer2;
@property (nonatomic, weak) IBOutlet    UILabel*        answer3;
@property (nonatomic, weak) IBOutlet    UIView*         group;
@property (nonatomic, weak) IBOutlet    UIImageView*    backgroundView;
@property (nonatomic, strong)           ETQuestion*     question;
@property (nonatomic, assign)           ETTriviaResult  result;
@property (nonatomic, assign)           CGFloat         groupMovedDeltaY;

- (IBAction)  btnClick:(id)sender;

@end
