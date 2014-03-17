//
//  ResultViewController.m
//  demo
//
//  Created by john on 14-3-15.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "ResultViewController.h"
#import "RTLabel.h"
#define MARGIN 15

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) RTLabel *resultLabel;

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *sample_text = @"<b>Lorem ipsum dolor</b> sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation <i>ullamco laboris</i> nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    self.resultLabel = [[RTLabel alloc]init];
    self.resultLabel.frame = CGRectMake(MARGIN, MARGIN, self.scrollView.frame.size.width - MARGIN * 2, CGFLOAT_MAX);
    self.resultLabel.lineSpacing = 10.0;
    self.resultLabel.text = sample_text;
    CGSize optimumSize = [self.resultLabel optimumSize];
    self.resultLabel.frame = CGRectMake(MARGIN, MARGIN, optimumSize.width, optimumSize.height + MARGIN);
    [self.scrollView addSubview:self.resultLabel];
    optimumSize.height += MARGIN * 2;
    optimumSize.width += MARGIN * 2;
    [self.scrollView setContentSize:optimumSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
