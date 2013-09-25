//
//  ETTriviaQuestionViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETQuestion.h"
@interface ETTriviaQuestionViewController : UIViewController

@property (nonatomic, strong)           ETQuestion*     question;
@property (nonatomic, weak) IBOutlet    UITextView*     questionView;
@property (nonatomic, assign)           NSInteger       remainTime;
@property (nonatomic, strong)           NSTimer*        timer;

@end
