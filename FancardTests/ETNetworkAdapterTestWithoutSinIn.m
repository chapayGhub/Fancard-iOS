//
//  ETNetworkAdapterTestWithoutSinIn.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-27.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETNetworkAdapterTestWithoutSinIn.h"

@implementation ETNetworkAdapterTestWithoutSinIn

- (void) setUp
{
    [super setUp];
    adapter = [ETNetworkAdapter sharedAdapter];
    NSArray* arr = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (id cookie in arr) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (void) testInit
{
    XCTAssertNotNil(adapter, @"adapter is Nil!");
}

- (void) testCheckUserNameSuccess
{
    __block BOOL flag = true;
    [adapter checkUsernameWith:@"check"
                       success:^(AFHTTPRequestOperation *operation, id responseObject){
                           NSDictionary* dict = [responseObject objectFromJSONData];
                           XCTAssertEqualObjects(dict[@"msg"], @"OK", @"response ERROR");
                           flag = NO;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTFail(@"%@", error);
                           flag = NO;
                       }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testCheckUserNameAlreadExist
{
    __block BOOL flag = true;
    [adapter checkUsernameWith:@"txx"
                       success:^(AFHTTPRequestOperation *operation, id responseObject){
                           NSDictionary* dict = [responseObject objectFromJSONData];
                           XCTAssertEqualObjects(dict[@"msg"], @"Username already exists", @"response ERROR");
                           flag = NO;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTFail(@"%@", error);
                           flag = NO;
                       }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testCheckUserNameBadRequest
{
    __block BOOL flag = true;
    id null =[NSNull null];
    [adapter checkUsernameWith:null
                       success:^(AFHTTPRequestOperation *operation, id responseObject){
                           XCTFail(@"bad access");
                           flag = NO;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTAssertEqual(operation.response.statusCode, 400, @"statusCode error");
                           flag = NO;
                       }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testLoginSuccess
{
    NSArray* arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    XCTAssertTrue(arr.count == 0, @"cookie not clean");
    
    __block BOOL flag = true;
    [adapter loginWithUsername:@"txx"
                      password:@"12345"
                       success:^(AFHTTPRequestOperation *operation, id responseObject){
                           NSDictionary* dict = [responseObject objectFromJSONData];
                           XCTAssertEqualObjects(dict[@"msg"], @"OK", @"response ERROR");
                           XCTAssertNotEqual([[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies].count, 0, @"not get cookie");
                           flag = NO;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTFail(@"%@", error);
                           flag = NO;
                       }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testLoginFailed
{
    __block BOOL flag = true;
    [adapter loginWithUsername:@"txx"
                      password:@"123456"
                       success:^(AFHTTPRequestOperation *operation, id responseObject){
                           XCTFail(@"Bad Access");
                           flag = NO;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTAssertEqual(operation.response.statusCode, 401, @"error status code");
                           flag = NO;
                       }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testLoginBadAccess
{
    id null = [NSNull null];
    __block BOOL flag = true;
    [adapter loginWithUsername:null
                      password:@"123456"
                       success:^(AFHTTPRequestOperation *operation, id responseObject){
                           XCTFail(@"Bad Access");
                           flag = NO;
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           XCTAssertEqual(operation.response.statusCode, 400, @"error status code");
                           flag = NO;
                       }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testRegisterSuccess
{
    __block BOOL flag = true;
    UIImage* img = [UIImage imageWithContentsOfFile:@"/Users/txx/Desktop/1.jpg"];
    [adapter registerWithUsername:[NSString stringWithFormat:@"%d", arc4random()]
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

- (void) testRegisterExist
{
    __block BOOL flag = true;
    UIImage* img = [UIImage imageWithContentsOfFile:@"/Users/txx/Desktop/1.jpg"];
    [adapter registerWithUsername:@"txx"
                         password:@"12345"
                            email:@"txxx@txx.me"
                         trueName:@"txx"
                           avatar:img
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              NSDictionary* dict = [responseObject objectFromJSONData];
                              XCTAssertEqualObjects(dict[@"msg"], @"Username already exists", @"response ERROR");
                              flag = NO;
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              XCTAssertEqual(operation.response.statusCode, 401, @"error status code");
                              flag = NO;
                          }
     ];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testRegisterBadAccess
{
    id null = [NSNull null];
    __block BOOL flag = true;
    UIImage* img = [UIImage imageWithContentsOfFile:@"/Users/txx/Desktop/1.jpg"];
    [adapter registerWithUsername:null
                         password:@"12345"
                            email:@"txxx@txx.me"
                         trueName:@"txx"
                           avatar:img
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              XCTFail(@"Bad Access");
                              flag = NO;
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              XCTAssertEqual(operation.response.statusCode, 400, @"error status code");
                              flag = NO;
                          }
     ];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}


- (void) testGetInfoFailed
{
    NSArray* arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    XCTAssertTrue(arr.count == 0, @"cookie not clean");
    __block BOOL flag = true;
    [adapter getInfoWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTFail(@"Bad Access");
        flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTAssertEqual(operation.response.statusCode, 401, @"error status code");
        flag = false;
    }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testGetVideoAndQuizStatus
{
    __block BOOL flag = true;
    [adapter getVideoAndQuizStatusWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTAssertEqualObjects([responseObject objectFromJSONData][@"msg"], @"OK", @"ERROR");
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

- (void) testGetRankListToday
{
    __block BOOL flag = true;
    [adapter getRankListTodayWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTAssertEqualObjects([responseObject objectFromJSONData][@"msg"], @"OK", @"ERROR");
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

- (void) testGetRankListTotal
{
    __block BOOL flag = true;
    [adapter getRankListTotalWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTAssertEqualObjects([responseObject objectFromJSONData][@"msg"], @"OK", @"ERROR");
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

- (void) testAllVideos
{
    __block BOOL flag = true;
    [adapter getAllVideosWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTAssertEqualObjects([responseObject objectFromJSONData][@"msg"], @"OK", @"ERROR");
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

- (void) testGetNewQuizFailed
{
    __block BOOL flag = true;
    NSArray* arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    XCTAssertTrue(arr.count == 0, @"cookie not clean");
    [adapter getNewQuizWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        XCTFail(@"%@", @"Bad Access");
        flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTAssertEqual(operation.response.statusCode, 401, @"error status code");
        flag = false;
    }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}

- (void) testWatchVideoFailed
{
    __block BOOL flag = true;
    NSArray* arr = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    XCTAssertTrue(arr.count == 0, @"cookie not clean");
    [adapter watchVideoWithVideoID:1
                         challenge:NO
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               XCTFail(@"%@", @"Bad Access");
                               flag = false;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XCTAssertEqual(operation.response.statusCode, 401, @"error status code");
        flag = false;
    }];
    
    while (flag) {
        [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                              beforeDate:[NSDate distantFuture]];
    }
}
@end
