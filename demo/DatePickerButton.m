//
//  DatePickerButton.m
//  demo
//
//  Created by john on 14-3-16.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "DatePickerButton.h"

@implementation DatePickerButton{
    UIDatePicker *_pv;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Picker

- (UIView *)inputView {
    // set up your UIPickerView here
    _pv = [[UIDatePicker alloc] init];
    [_pv setDatePickerMode:UIDatePickerModeTime];
    [_pv setMinuteInterval:30];
    return _pv;
}

- (UIView *)inputAccessoryView {
    // set up your toolbar here
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *ok = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pick:)];
    [tb setItems:[NSArray arrayWithObjects:flex, ok, nil]];
    return tb;
}

- (void)pick:(id)sender {
    // store picker value here before closing inputView
    [self resignFirstResponder];
}

@end
