//
//  ETNetworkAdapterTestWithSignUp.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETNetworkAdapterTestWithSignUp.h"
#import "ETQuestion.h"
@implementation ETNetworkAdapterTestWithSignUp

- (void) signUPWithUserName:(NSString*) username
{
    __block BOOL flag = true;
    UIImage* img = [UIImage imageWithContentsOfFile:@"/Users/txx/Desktop/1.jpg"];
    [adapter registerWithUsername:username
                         password:@"12345"
                            email:@"txxx@txx.me"
                         trueName:@"txx"
                           avatar:img
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              NSDictionary* dict = [responseObject objectFromJSONData];
                              XCTAssertEqualObjects(dict[@"msg"], @"OK", @"response ERROR");
                              flag = NO;
                              
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              XCTFail(@"%@", error);
                              flag = NO;
                          }
     ];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) signInWithUserName:(NSString*) username
{
    __block BOOL flag = true;
    [adapter loginWithUsername:username
                      password:@"12345"
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           NSArray* tmp = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
                           XCTAssertTrue(tmp.count!=0, @"No cookie found");
                           flag = false;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTFail(@"%@", error);
                           flag = false;
                       }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) setUp
{
    [super setUp];
    adapter = [ETNetworkAdapter sharedAdapter];
    NSArray* arr = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (id cookie in arr) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    char ch[20];
    for (int i=0; i<20; i++) {
        ch[i] = (arc4random() % 26) + 'a';
    }
    
    NSString* username = [NSString stringWithCString:ch encoding:NSUTF8StringEncoding];
    [self signUPWithUserName:username];
    [self signInWithUserName:username];
}

- (void) testAnswerQuestionRightAnswer
{
    __block BOOL flag = true;
    [adapter answerQuestionWithQuestionID:1
                                   answer:@"3"
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      NSDictionary* dict = [responseObject objectFromJSONData];
                                      NSLog(@"%@", dict);
                                      XCTAssertTrue([dict[@"addCredit"] intValue] == 3, @"return Error");
                                      flag = false;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTFail(@"%@", error);
                                      flag = false;
                                  }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testAnswerQuestionWrongAnswer
{
    __block BOOL flag = true;
    [adapter answerQuestionWithQuestionID:1
                                   answer:@"a"
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      NSDictionary* dict = [responseObject objectFromJSONData];
                                      NSLog(@"%@", dict);
                                      XCTAssertTrue([dict[@"addCredit"] intValue] == 0, @"return Error");
                                      flag = false;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTFail(@"%@", error);
                                      flag = false;
                                  }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) answerQuestionWithQuesitonId:(NSInteger) question_id
                               answer:(NSString*) answer
{
    __block BOOL flag = true;
    [adapter answerQuestionWithQuestionID:question_id
                                   answer:answer
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      flag = false;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTFail(@"%@", error);
                                      flag = false;
                                  }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (ETQuestion*) getNewQuestion
{
    __block BOOL flag = true;
    __block ETQuestion* quiz = nil;
    [adapter getNewQuizWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        quiz = [[ETQuestion alloc] initWithJsonData:responseObject];
        flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTFail(@"%@", error);
        flag = false;
    }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
    return quiz;
}

- (void) testGetNewQuizNotFound
{
    for (int i=0; i<3; i++) {
        ETQuestion* q = [self getNewQuestion];
        [self answerQuestionWithQuesitonId:[q.identifier integerValue]
                                    answer:q.rightAns];
    }
    
    __block BOOL flag = true;

    [adapter getNewQuizWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTFail(@"Bad Access");
        flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTAssertEqual(404, operation.response.statusCode, @"return Error");
        flag = false;
    }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testWatchVideoSuccess
{
    __block BOOL flag = true;
    [adapter watchVideoWithVideoID:1
                         challenge:NO
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                      NSDictionary* dict = [responseObject objectFromJSONData];
                                      NSLog(@"%@", dict);
                                      XCTAssertNotEqual([dict[@"addCredit"] intValue], 0, @"return Error");
                                      flag = false;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTFail(@"%@", error);
                                      flag = false;
                                  }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) watchVideoWithId:(NSInteger) video_id
                challange:(BOOL) challange
{
    __block BOOL flag = true;
    [adapter watchVideoWithVideoID:video_id
                         challenge:challange
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSDictionary* dict = [responseObject objectFromJSONData];
                               XCTAssertNotEqual([dict[@"addCredit"] intValue], 0, @"return Error");
                               flag = false;
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               XCTFail(@"%@", error);
                               flag = false;
                           }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testWatchVideoNoCredit
{
    [self watchVideoWithId:1 challange:NO];
    __block BOOL flag = true;
    [adapter watchVideoWithVideoID:1
                         challenge:NO
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               
                               NSDictionary* dict = [responseObject objectFromJSONData];
                               XCTAssertEqual([dict[@"addCredit"] intValue], 0, @"return Error");
                               flag = false;
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               XCTFail(@"%@", error);
                               flag = false;
                           }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testChanllengeSuccess
{
    __block BOOL flag = true;
    [adapter watchVideoWithVideoID:1
                         challenge:YES
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               
                               NSDictionary* dict = [responseObject objectFromJSONData];
                               XCTAssertNotEqual([dict[@"addCredit"] intValue], 0, @"return Error");
                               flag = false;
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               XCTFail(@"%@", error);
                               flag = false;
                           }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testSameChallengeSuccess
{
    for (int i=0; i<10; i++) {
        [self watchVideoWithId:1 challange:YES];
    }
    
    __block BOOL flag = true;
    [adapter watchVideoWithVideoID:1
                         challenge:YES
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               
                               NSDictionary* dict = [responseObject objectFromJSONData];
                               XCTAssertNotEqual([dict[@"addCredit"] intValue], 0, @"return Error");
                               flag = false;
                           }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               XCTFail(@"%@", error);
                               flag = false;
                           }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testGetCompleteVideos
{
    for (int i=0; i<3; i++) {
        [self watchVideoWithId:i+1 challange:NO];
    }
    
    __block BOOL flag = YES;
    [adapter getCompleteVideosWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary*  dict = [responseObject objectFromJSONData];
        XCTAssertNotNil(dict[@"0"], @"Error");
        XCTAssertNotNil(dict[@"1"], @"Error");
        XCTAssertNotNil(dict[@"2"], @"Error");
        
    }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTFail(@"%@", error);
                                      flag = false;
                                  }];
}

- (void) testGetCompleteVideosEmpty
{
    __block BOOL flag = YES;
    [adapter getCompleteVideosWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary*  dict = [responseObject objectFromJSONData];
        XCTAssertNil(dict[@"0"], @"Error");
        
    }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTFail(@"%@", error);
                                      flag = false;
                                  }];

}

@end
