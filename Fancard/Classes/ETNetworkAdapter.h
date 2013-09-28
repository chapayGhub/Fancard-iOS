//
//  ETNetworkAdapter.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-27.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <JSONKit.h>
@interface ETNetworkAdapter : NSObject
{
    AFHTTPClient*   client;
}


+ (instancetype) sharedAdapter;
- (void) checkUsernameWith:(NSString*) usrname
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) loginWithUsername:(NSString*) usrname
                  password:(NSString*) password
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) registerWithUsername:(NSString*) username
                     password:(NSString*) password
                        email:(NSString*) email
                     trueName:(NSString*) trueName
                       avatar:(UIImage*) avatar
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getInfoWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) getVideoAndQuizStatusWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) getRankListTotalWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) getRankListTodayWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) getAllVideosWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) getNewQuizWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) answerQuestionWithQuestionID:(NSInteger) question_id
                               answer:(NSString*) answer
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) watchVideoWithVideoID:(NSInteger) video_id
                     challenge:(BOOL) challenge
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void) getCompleteVideosWithsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
