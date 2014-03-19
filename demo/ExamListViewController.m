//
//  ExamListViewController.m
//  demo
//
//  Created by john on 14-3-12.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "ExamListViewController.h"
#import "Evaluation.h"

@interface ExamListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic, strong) NSMutableArray* list;
@end

@implementation ExamListViewController
@synthesize list;

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
    self.list = [[NSMutableArray alloc] init];
    
    Evaluation* evaluation = [[Evaluation alloc] initWithData:@"职场能力测评" type:@"课前测评"];
    [self.list addObject:evaluation];
    evaluation = [[Evaluation alloc] initWithData:@"逻辑推理测评" type:@"课前测评"];
    [self.list addObject:evaluation];
    evaluation = [[Evaluation alloc] initWithData:@"常识性知识测评" type:@"课前测评"];
    [self.list addObject:evaluation];
    evaluation = [[Evaluation alloc] initWithData:@"心理学抗风险能力测评" type:@"课前测评"];
    [self.list addObject:evaluation];
    evaluation = [[Evaluation alloc] initWithData:@"价值观测评" type:@"课前测评"];
    [self.list addObject:evaluation];
    evaluation = [[Evaluation alloc] initWithData:@"诊断性测评测评" type:@"课前测评"];
    [self.list addObject:evaluation];
    for(int i=0; i<6; i++)
    {   Evaluation* evaluation = [[Evaluation alloc] initWithData:[NSString stringWithFormat:@"测评项目%d", i+1] type:@"课后测评"];
        [self.list addObject:evaluation];
    }
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:TableSampleIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSUInteger row = [indexPath row];
    Evaluation* evaluation = [self.list objectAtIndex:row];
    cell.textLabel.text = evaluation.name;
    cell.detailTextLabel.text = evaluation.type;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    [self performSegueWithIdentifier:@"pushEvaluation" sender: [self.list objectAtIndex:indexPath.row]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* destination = segue.destinationViewController;
    if([destination respondsToSelector:@selector(setData:)]){
        [destination setValue: sender forKey:@"data"];
    }
}
- (IBAction)goRecommendCourse:(id)sender {
    [self performSegueWithIdentifier:@"recommendCourse" sender:self];
}

@end
