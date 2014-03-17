//
//  Pair.h
//  demo
//
//  Created by john on 14-3-15.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pair : NSObject
@property(nonatomic, strong) NSString* v1;
@property(nonatomic, strong) NSString* v2;
-(id)initWithValue: (NSString*)nV1 value2: (NSString*)nV2;
@end
