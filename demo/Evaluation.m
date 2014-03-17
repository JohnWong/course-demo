//
//  Evaluation.m
//  demo
//
//  Created by john on 14-3-13.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "Evaluation.h"

@implementation Evaluation

@synthesize name;
@synthesize type;


- (id)initWithData:(NSString *)nName type:(NSString *)nType
{
    [self setName: nName];
    [self setType: nType];
    return self;
}

@end
