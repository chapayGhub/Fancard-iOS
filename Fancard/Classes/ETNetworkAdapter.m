//
//  ETNetworkAdapter.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-27.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETNetworkAdapter.h"

static ETNetworkAdapter* _sharedAdapter = nil;
#define kServerBasedURL @"http://localhost:8888/fancard/index.php"

@implementation ETNetworkAdapter

+ (instancetype) sharedAdapter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAdapter = [[ETNetworkAdapter alloc] init];
    });
    
    return _sharedAdapter;
}


- (void) checkUsernameWith:(NSString *)usrname
                   success:(void (^)(AFHTTPRequestOperation *, id))success
                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"check_username", @"username":usrname}
             success: success
             failure: failure];
}

- (void) loginWithUsername:(NSString *)usrname
                  password:(NSString *)password
                   success:(void (^)(AFHTTPRequestOperation *, id))success
                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"login", @"username": usrname, @"password": password}
             success:success
             failure:failure];
}

- (void) registerWithUsername:(NSString*) username
                     password:(NSString*) password
                        email:(NSString*) email
                     trueName:(NSString*) trueName
                       avatar:(UIImage*) avatar
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest* request =[client multipartFormRequestWithMethod:@"POST"
                                                                    path:nil
                                                              parameters:@{@"command":@"register", @"username":username, @"password":password, @"email":email, @"truename":trueName}
                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                   [formData appendPartWithFormData:UIImageJPEGRepresentation(avatar, 0.1)
                                                                               name:@"avatar"];
                                               }];
    [[client HTTPRequestOperationWithRequest:request
                                    success:success
                                    failure:failure] start];
}

- (void) getInfoWithsuccess:(void (^)(AFHTTPRequestOperation *, id))success
                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"self_info"}
             success:success
             failure:failure];
}

- (void) getVideoAndQuizStatusWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [client postPath:nil
          parameters:@{@"command":@"video_quiz_status"}
             success:success
             failure:failure];
}

- (void) getRankListTotalWithsuccess:(void (^)(AFHTTPRequestOperation *, id))success
                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"rank_list_total"}
             success:success
             failure:failure];
}

- (void) getRankListTodayWithsuccess:(void (^)(AFHTTPRequestOperation *, id))success
                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"rank_list_today"}
             success:success
             failure:failure];
}

- (void) getAllVideosWithsuccess:(void (^)(AFHTTPRequestOperation *, id))success
                         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"get_all_videos"}
             success:success
             failure:failure];
}

- (void) getNewQuizWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [client postPath:nil
          parameters:@{@"command":@"get_new_quiz"}
             success:success
             failure:failure];
}

- (void) answerQuestionWithQuestionID:(NSInteger)question_id
                               answer:(NSString *)answer
                              success:(void (^)(AFHTTPRequestOperation *, id))success
                              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"answer_question",
                       @"question_id":[NSNumber numberWithInteger:question_id],
                       @"answer":answer}
             success:success
             failure:failure];
}

- (void) watchVideoWithVideoID:(NSInteger)video_id
                     challenge:(BOOL)challenge
                       success:(void (^)(AFHTTPRequestOperation *, id))success
                       failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"watch_video",
                       @"video_id":[NSNumber numberWithInteger:video_id],
                       @"challenge":[NSNumber numberWithBool:challenge]}
             success:success
             failure:failure];
}

- (void) getCompleteVideosWithsuccess:(void (^)(AFHTTPRequestOperation *, id))success
                              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [client postPath:nil
          parameters:@{@"command":@"get_complete_videos"}
             success:success
             failure:failure];
}

- (id) init
{
    if ( self = [super init] )
    {
        client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kServerBasedURL]];
    }
    return self;
}
@end
