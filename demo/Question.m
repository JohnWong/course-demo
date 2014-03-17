//
//  Question.m
//  demo
//
//  Created by john on 14-3-14.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize title;
@synthesize type;
@synthesize answer;
@synthesize optionA;
@synthesize optionB;
@synthesize optionC;
@synthesize optionD;

-(id) initWithTrueOrFalse:(NSString *)nTitle withAnswer:(NSInteger)nAnswer
{
    self.title = nTitle;
    self.answer = nAnswer;
    self.type = 1;
    return self;
}

-(id) initWithOptions:(NSString *)nTitle withAnswer:(NSInteger)nAnswer withOptionA:(NSString*)nOptionA withOptionB:(NSString*)nOptionB withOptionC:(NSString*)nOptionC withOptionD:(NSString*)nOptionD
{
    self.title = nTitle;
    self.answer = nAnswer;
    self.type = 2;
    self.optionA = nOptionA;
    self.optionB = nOptionB;
    self.optionC = nOptionC;
    self.optionD = nOptionD;
    return self;
}
@end
