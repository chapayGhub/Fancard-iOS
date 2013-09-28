//
//  ETNetworkAdapterTestWithSignIn.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETNetworkAdapterTestWithSignIn.h"

@implementation ETNetworkAdapterTestWithSignIn

- (void) setUp
{
    [super setUp];
    adapter = [ETNetworkAdapter sharedAdapter];
    NSArray* arr = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (id cookie in arr) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    __block BOOL flag = true;
    [adapter loginWithUsername:@"txx"
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

- (void) tearDown
{
    [super tearDown];
    __weak NSArray* arr = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (id cookie in arr) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (void) testGetInfoSuccess
{
    __block BOOL flag = true;
    [adapter getInfoWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject objectFromJSONData]);
        flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTFail(@"%@", error);
        flag = false;
    }];

    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testGetNewQuizSuccess
{
    __block BOOL flag = true;
    [adapter getNewQuizWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject objectFromJSONData]);
        flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTFail(@"%@", error);
        flag = false;
    }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testAnswerQuestionNotFound
{
    __block BOOL flag = true;
    [adapter answerQuestionWithQuestionID:100
                                   answer:@"Hello"
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      XCTFail(@"Bad Access");
                                      flag = false;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTAssertEqual(operation.response.statusCode, 404, @"error status code");
                                      flag = false;
                                  }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testVideoNotFound
{
    __block BOOL flag = true;
    [adapter watchVideoWithVideoID:100
                         challenge:YES
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      XCTFail(@"Bad Access");
                                      flag = false;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      XCTAssertEqual(operation.response.statusCode, 404, @"error status code");
                                      flag = false;
                                  }];
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}
@end
