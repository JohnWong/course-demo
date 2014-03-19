//
//  CourseSearchListViewController.m
//  demo
//
//  Created by john on 14-3-17.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "CourseListViewController.h"
#import "Pair.h"
#define SEARCH_BAR_HEIGHT 44

@interface CourseListViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray* items;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation CourseListViewController
@synthesize items;
@synthesize searchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items = [[NSArray alloc] initWithObjects:[[Pair alloc] initWithValue:@"财务分析与决策" value2:@"这门课程用财务语言解构企业的价值创造过程"], [[Pair alloc] initWithValue:@"简单统计学" value2:@"本课程主要目标是让学习者能学习到统计学的基础概念及各种不同的统计方法"], [[Pair alloc] initWithValue:@"生物信息学: 导论与方法" value2:@"生物信息学是一门新兴的生命科学与计算科学前沿交叉学科"], [[Pair alloc] initWithValue:@"怪诞行为学" value2:@"著名心理学家 Dan Ariely 带领我们认识人类的非理性，并学会解决由非理性而产生的问题"], [[Pair alloc] initWithValue:@"佛教与现代心理学" value2:@"The Dalai Lama has said that Buddhism and science are deeply compatible and has encouraged Western scholars to critically examine both the meditative practice and Buddhist ideas about the human mind"], [[Pair alloc] initWithValue:@"迎接改变：提升自我的一大步" value2:@"在整个课程中，将新的心理学理论应用于个人的改变来实现你自己进步的目标"], nil];
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Pair* pair = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = pair.v1;
    cell.detailTextLabel.text = pair.v2;
    return cell;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)uiSearchBar;
{
    uiSearchBar.showsCancelButton = true;
    for(UIView* view in self.searchBar.subviews)
    {
        for(UIView* subview in view.subviews){
            if([subview isKindOfClass:[UIButton class]])
            {
                UIButton* btn = (UIButton*)subview;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
            
        }
        
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)uiSearchBar
{
    [uiSearchBar resignFirstResponder];
    uiSearchBar.showsCancelButton = false;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"CourseInfo" sender:self];
}

@end
