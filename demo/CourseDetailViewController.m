//
//  CourseDetailViewController.m
//  demo
//
//  Created by john on 14-3-19.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "CourseDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Pair.h"

@interface CourseDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSArray* items;
@property(nonatomic, strong) MPMoviePlayerController* player;
@end

@implementation CourseDetailViewController
@synthesize items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = [[NSArray alloc] initWithObjects:[[Pair alloc] initWithValue:@"第一课 概览" value2:@"概览"], [[Pair alloc] initWithValue:@"第二课 摘要" value2:@"摘要"], [[Pair alloc] initWithValue:@"第三课 目录" value2:@"目录"], [[Pair alloc] initWithValue:@"第四课 相关技术介绍" value2:@"相关技术介绍"], [[Pair alloc] initWithValue:@"第五课" value2:@"相关研究现状"], [[Pair alloc] initWithValue:@"第六课" value2:@"应用"], nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 1:
            return 1;
        case 2:
            return self.items.count;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
        NSString* cellIdentifier = @"Top";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 135, 135)];
            imageView.image = [UIImage imageNamed:@"course.png"];
            [cell addSubview:imageView];
            UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(170, 20, 130, 21)];
            
            label1.text = @"评分：10";
            [cell addSubview:label1];
            UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(170, 49, 130, 21)];
            label2.text = @"难度：简单";
            [cell addSubview:label2];
            UILabel* label3 = [[UILabel alloc] initWithFrame:CGRectMake(170, 77, 130, 21)];
            label3.text = @"讲师：李明";
            [cell addSubview:label3];
            UILabel* label4 = [[UILabel alloc] initWithFrame:CGRectMake(170, 105, 130, 21)];
            label4.text = @"分类：经济";
            [cell addSubview:label4];
            UILabel* label5 = [[UILabel alloc] initWithFrame:CGRectMake(170, 133, 130, 21)];
            label5.text = @"时间：2周";
            [cell addSubview:label5];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    } else if(indexPath.section == 1){
        NSString* cellIdentifier = @"Abstract";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            cell.textLabel.numberOfLines = 5;
            
        }
        cell.textLabel.text = @"这门课程用财务语言解构企业的价值创造过程，从而帮助学习者理解影响价值创造的各种因素，建立财务思维，并具备将其应用于商业决策的能力。借助财务信息，企业的管理者可以进行有效的战略定位、监控和管理企业的经营业绩、制定更有助于与外部投资者沟通的财务政策，以及对并购目标做出评价；政府管理者可以预测未来产业的兴衰变化；投资人可以判断谁将在未来复杂多变的市场中生存下来并发展壮大；证券分析师和投资银行可以评价公司的价值；商业银行可以评估偿债风险并做出贷款决策；咨询公司可以为客户进行竞争分析。这虽然是一门研究生课程，但是学习者不需要具备会计基础。我们将从认识财务报表开始，逐步了解财务信息的架构体系，讨论财务数据与行业、战略定位与战略执行的关系，剖析企业的价值创造过程，在此基础上，讨论如何运用财务数据进行商业决策。";
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }else if(indexPath.section == 2){
        NSString* cellIdentifier = @"Course";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        Pair* pair = self.items[indexPath.row];
        cell.textLabel.text = pair.v1;
        cell.detailTextLabel.text = pair.v2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 175;
        case 1:
            return 100;
        case 2:
            return 44;
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 2:
            return @"课程列表";
        case 1:
            return @"课程简介";
        default:
            return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            //Popover
        }
            break;
        case 2:
        {
            [self playMovie];
        }
            break;
        default:
            break;
    }
}

-(void)playMovie
{
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"videoviewdemo" ofType:@"mp4"]];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerWillExitFullscreenNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [self.view addSubview:self.player.view];
    [self.player setFullscreen:YES];
    [self.player prepareToPlay];
}

- (void)MPMoviePlayerWillExitFullscreenNotification:(NSNotification *)notification
{
    NSLog(@"did");
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:nil];
    
    [self.player stop];
    [self.player.view removeFromSuperview];
}
@end
