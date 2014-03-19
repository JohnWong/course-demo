//
//  ExamViewController.m
//  demo
//
//  Created by john on 14-3-13.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "ExamViewController.h"
#import "Question.h"
#define EDGE_INSET 15
#define CELL_CONTENT_MARGIN 10
#define LEN_PER_SEG 60

@interface ExamViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSInteger orientation;

@end

@implementation ExamViewController

@synthesize data;
@synthesize questions;
@synthesize orientation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = data.name;
    //    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height * 3);
    self.questions = [[NSMutableArray alloc]init];
    [self.questions addObject:[[Question alloc] initWithTrueOrFalse:@"1.判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题判断题" withAnswer:1]];
    for(int i=2; i<=10; i++){
        if(i < 6){
            [self.questions addObject:[[Question alloc] initWithTrueOrFalse:[NSString stringWithFormat:@"%d. 判断题", i] withAnswer:1]];
        } else {
            [self.questions addObject:[[Question alloc] initWithOptions:[NSString stringWithFormat:@"%d. 选择题", i] withAnswer:1 withOptionA:@"Option A" withOptionB:@"Option B" withOptionC:@"Option C" withOptionD:@"Option D"]];
        }
    }
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.orientation = 0;
}

-(void)handleOrientation
{
    if(self.orientation == 0 || UIInterfaceOrientationIsPortrait(self.orientation) != UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self.tableView reloadData];
    }
    self.orientation = self.interfaceOrientation;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    
    Question* question = [self.questions objectAtIndex:row];
    NSString *typeId;
    NSArray *segmentedArray;
    NSString* text;
    NSInteger segLen;
    if(question.type == 1){
        typeId = @"examTof";
        segmentedArray = [[NSArray alloc]initWithObjects:@"是", @"否", nil];
        text = question.title;
        segLen = LEN_PER_SEG * 2;
    } else {
        typeId = @"examOption";
        segmentedArray = [[NSArray alloc]initWithObjects:@"A", @"B", @"C", @"D", nil];
        text = [NSString stringWithFormat:@"%@\nA. %@\nB. %@\nC. %@\nD. %@", question.title, question.optionA, question.optionB, question.optionC, question.optionD];
        segLen = LEN_PER_SEG * 4;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             typeId];
    //label高度自适应文本
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString: text
     attributes:@
     {
     NSFontAttributeName: [UIFont systemFontOfSize: 17.0]
     }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.frame.size.width - EDGE_INSET * 2, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:typeId];
        UILabel* label = [[UILabel alloc] init];
        label.tag = 1;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];
        UISegmentedControl* choice = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        choice.tag = 2;
        [cell.contentView addSubview:choice];
    }
    UILabel* label = (UILabel*)[cell viewWithTag:1];
    label.text = text;
    label.frame = CGRectMake(EDGE_INSET, CELL_CONTENT_MARGIN, tableView.frame.size.width - EDGE_INSET * 2, rect.size.height);
    
    UISegmentedControl* choice = (UISegmentedControl*)[cell viewWithTag: 2];
    choice.frame = CGRectMake(tableView.frame.size.width - EDGE_INSET - segLen, CELL_CONTENT_MARGIN * 2 + rect.size.height, segLen, 28);
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Question* question = [self.questions objectAtIndex:indexPath.row];
    NSString* text;
    if(question.type == 1){
        text = question.title;
    } else {
        text = [NSString stringWithFormat:@"%@\nA. %@\nB. %@\nC. %@\nD. %@", question.title, question.optionA, question.optionB, question.optionC, question.optionD];
    }
    //tableCell高度自适应
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: [UIFont systemFontOfSize:17.0]
     }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.frame.size.width - EDGE_INSET * 2, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + CELL_CONTENT_MARGIN * 4 + 28;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questions.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self handleOrientation];
}

@end
