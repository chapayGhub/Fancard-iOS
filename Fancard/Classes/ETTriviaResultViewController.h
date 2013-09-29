//
//  ETTriviaResultViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"
#import "ETTriviaAnswerViewController.h"
#import "ETQuestion.h"
@interface ETTriviaResultViewController : ETBasedViewController

@property (nonatomic, assign)           ETTriviaResult  result;
@property (nonatomic, strong)           ETQuestion*     question;
@property (nonatomic, strong)           NSString*       answer;
@property (nonatomic, weak) IBOutlet    UIImageView*    background;
@property (nonatomic, weak)             UISwipeGestureRecognizer* swipe;
@end
