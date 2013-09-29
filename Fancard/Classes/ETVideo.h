//
//  ETVideo.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETVideo : NSObject

@property (nonatomic, assign)   NSInteger               video_id;
@property (nonatomic, strong)   NSString*               video_title;
@property (nonatomic, assign)   NSInteger               video_points_watching;
@property (nonatomic, strong)   NSString*               video_challenge;
@property (nonatomic, assign)   NSInteger               video_points_challenge;
@property (nonatomic, strong)   NSString*               video_healthtip;
@property (nonatomic, strong)   NSString*               video_screenshot;
@property (nonatomic, strong)   NSString*               video_url;

- (id) initWithDict:(NSDictionary*) dict;

@end
