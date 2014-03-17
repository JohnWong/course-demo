//
//  RecommendViewController.m
//  demo
//
//  Created by john on 14-3-15.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "RecommendViewController.h"
#import "Pair.h"
#import "DatePickerButton.h"

@interface RecommendViewController ()<UIActionSheetDelegate>
@property NSMutableArray* items;
@property NSMutableArray* teachers;
@property NSMutableArray* courses;
@end

@implementation RecommendViewController

@synthesize teachers;
@synthesize items;
@synthesize courses;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.items = [[NSMutableArray alloc]init];
    [self.items addObject: [[Pair alloc] initWithValue:@"导师" value2:@"请选择"]];
    [self.items addObject:[[Pair alloc] initWithValue:@"课程" value2:@"请选择"]];
    [self.items addObject:[[Pair alloc] initWithValue:@"时间安排" value2:@"请选择"]];
    self.teachers = [[NSMutableArray alloc] initWithObjects:@"王大雷", @"李师师", @"王晶", @"Linus Torvalds", @"Android", @"Apple", @"John Lennon", @"John Tian", @"John Hilton", @"Shelton", @"Tailor", nil];
    self.courses = [[NSMutableArray alloc] initWithObjects:@"Java", @"Android", @"iOS", @"Javascript", nil];
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
    static NSString *CellIdentifier = @"RecCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    NSInteger row = indexPath.row;
    Pair* pair = [self.items objectAtIndex: row];
    cell.textLabel.text = pair.v1;
    cell.detailTextLabel.text = pair.v2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle: nil
                                          delegate:self
                                          cancelButtonTitle: nil
                                          destructiveButtonTitle: nil
                                          otherButtonTitles:nil];
            for(NSString* s in self.teachers){
                [actionSheet addButtonWithTitle:s];
            }
            [actionSheet addButtonWithTitle: @"取消"];
            actionSheet.cancelButtonIndex = self.teachers.count;
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            actionSheet.tag = indexPath.row;
            [actionSheet showFromTabBar:self.tabBarController.tabBar];
        }
            break;
        case 1:
        {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle: nil
                                          delegate:self
                                          cancelButtonTitle: nil
                                          destructiveButtonTitle: nil
                                          otherButtonTitles: nil];
            
            for(NSString* s in self.courses){
                [actionSheet addButtonWithTitle:s];
            }
            [actionSheet addButtonWithTitle:@"取消"];
            [actionSheet setCancelButtonIndex:self.courses.count];
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            actionSheet.tag = indexPath.row;
            [actionSheet showFromTabBar:self.tabBarController.tabBar];
        }
            break;
        case 2:
        {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle: (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)? @"\n\n\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n")
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle: @"确定"
                                          otherButtonTitles: nil];
            UIDatePicker* datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
            datePicker.datePickerMode = UIDatePickerModeDate;
#define DATEPICKER_TAG 101
            datePicker.tag = DATEPICKER_TAG;
//            [datePicker addTarget:self action:@selector(setDate:) forControlEvents:UIControlEventValueChanged];
            [actionSheet addSubview:datePicker];
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            actionSheet.tag = indexPath.row;
            [actionSheet setDelegate:self];
            [actionSheet showFromTabBar:self.tabBarController.tabBar];
        }
        default:
            break;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 0:
        {
            if (buttonIndex >= self.teachers.count) {
                break;
            }
            Pair* pair = [self.items objectAtIndex:actionSheet.tag];
            [self.items setObject:[[Pair alloc] initWithValue:pair.v1 value2: [self.teachers objectAtIndex:buttonIndex]] atIndexedSubscript:actionSheet.tag];
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            if (buttonIndex >= self.courses.count) {
                break;
            }
            Pair* pair = [self.items objectAtIndex:actionSheet.tag];
            [self.items setObject:[[Pair alloc] initWithValue:pair.v1 value2: [self.courses objectAtIndex:buttonIndex]] atIndexedSubscript:actionSheet.tag];
            [self.tableView reloadData];
        }
            break;
        case 2:
        {
            if (buttonIndex > 0) {
                break;
            }
            UIDatePicker* datePicker = (UIDatePicker*)[actionSheet viewWithTag:DATEPICKER_TAG];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString* dateSel = [formatter stringFromDate:datePicker.date];
            NSInteger dateIndex = 2;
            Pair* pair = [self.items objectAtIndex:dateIndex];
            [self.items setObject:[[Pair alloc] initWithValue:pair.v1 value2: dateSel] atIndexedSubscript: dateIndex];
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
