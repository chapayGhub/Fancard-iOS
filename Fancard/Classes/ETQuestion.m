//
//  ETQuestion.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-26.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETQuestion.h"
#import <JSONKit.h>
@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end

@implementation ETQuestion

- (NSArray*) answers
{
    NSMutableArray* array = [NSMutableArray arrayWithObjects:self.rightAns, self.wrongAns1, self.wrongAns2, nil];
    
    [array shuffle];
    
    return array;
}

- (id) initWithJsonData:(NSData *)data
{
    if (self = [super init])
    {
        NSDictionary* dict = [data objectFromJSONData];
        self.identifier = dict[@"question_id"];
        self.question = dict[@"question_title"];
        self.rightAns = dict[@"question_correct_answer"];
        self.wrongAns1 = dict[@"question_wrong_answer1"];
        self.wrongAns2 = dict[@"question_wrong_answer2"];
    }
    return self;
}
@end
