//
//  ETGlobal.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETGlobal.h"

static ETGlobal* _sharedGlobal = nil;
@implementation ETGlobal

+ (ETGlobal*) sharedGlobal
{
    if (!_sharedGlobal)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedGlobal = [[ETGlobal alloc] init];
        });
    }
    
    return _sharedGlobal;
}

@end
