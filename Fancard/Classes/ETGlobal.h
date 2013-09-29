//
//  ETGlobal.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETGlobal : NSObject

@property (nonatomic, strong)   NSString*       userName;
@property (nonatomic, strong)   UIImage*        avatar;
@property (nonatomic, assign)   NSInteger       userPointsTotal;
@property (nonatomic, assign)   NSInteger       userPointsToday;
@property (nonatomic, assign)   NSInteger       userNumberCorrectanswer;
@property (nonatomic, assign)   NSInteger       userNumberWatchedvideo;
@property (nonatomic, assign)   NSInteger       videoUnlockCnt;
@property (nonatomic, assign)   NSInteger       quizUnlockCnt;
@property (nonatomic, strong)   NSMutableArray* totalRank;
@property (nonatomic, strong)   NSMutableArray* todayRank;

+ (ETGlobal*) sharedGlobal;
@end
