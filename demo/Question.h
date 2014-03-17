//
//  Question.h
//  demo
//
//  Created by john on 14-3-14.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property(nonatomic, strong) NSString* title;
@property(nonatomic) NSInteger type;
@property(nonatomic, strong) NSString* optionA;
@property(nonatomic, strong) NSString* optionB;
@property(nonatomic, strong) NSString* optionC;
@property(nonatomic, strong) NSString* optionD;
@property(nonatomic) NSInteger answer;

-(id)initWithTrueOrFalse: (NSString*)title withAnswer:(NSInteger) answer;
-(id) initWithOptions:(NSString *)title withAnswer:(NSInteger) answer withOptionA:(NSString*)optionA withOptionB:(NSString*)optionB withOptionC:(NSString*)optionC withOptionD:(NSString*)optionD;
@end
