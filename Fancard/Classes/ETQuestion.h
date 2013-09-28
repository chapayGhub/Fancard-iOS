//
//  ETQuestion.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETQuestion : NSObject

@property (nonatomic, strong)   NSString*   identifier;
@property (nonatomic, strong)   NSString*   question;
@property (nonatomic, strong)   NSString*   rightAns;
@property (nonatomic, strong)   NSString*   wrongAns1;
@property (nonatomic, strong)   NSString*   wrongAns2;

- (NSArray*) answers;
- (id) initWithJsonData:(NSData*) data;
@end
