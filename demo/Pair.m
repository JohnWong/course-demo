//
//  Pair.m
//  demo
//
//  Created by john on 14-3-15.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "Pair.h"

@implementation Pair
@synthesize v1;
@synthesize v2;

-(id)initWithValue: (NSString*)nV1 value2: (NSString*)nV2
{
    self.v1 = nV1;
    self.v2 = nV2;
    return self;
}
@end
