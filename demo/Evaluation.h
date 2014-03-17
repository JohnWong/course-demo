//
//  Evaluation.h
//  demo
//
//  Created by john on 14-3-13.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evaluation : NSObject

@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* type;

- (id)initWithData:(NSString *)name type:(NSString *)type;

@end
