//
//  ETVideo.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETVideo.h"

@implementation ETVideo

- (id) initWithDict:(NSDictionary*) dict
{
    if (self = [super init])
    {
        for (NSString* key in dict.allKeys) {
            [self setValue:dict[key] forKey:key];
        }
    }
    return self;
}
@end
