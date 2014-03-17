//
//  CoursePageViewController.m
//  demo
//
//  Created by john on 14-3-16.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "CoursePageViewController.h"

@interface CoursePageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property NSArray* controllers;
@property (nonatomic, strong) UIPageViewController* pageViewController;
@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation CoursePageViewController

@synthesize pageViewController;
@synthesize pageControl;

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
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.controllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"CourseList"]];
    NSRange range;
    range.length = 1;
    range.location = 0;
    
    [self.pageViewController setViewControllers:[self.controllers subarrayWithRange:range] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        
    }];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    UIViewController* currentViewController = self.controllers[0];
    self.navigationItem.title = currentViewController.title;
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
#define PAGECONTROL_HEIGHT 28
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageViewRect.origin.y + pageViewRect.size.height - PAGECONTROL_HEIGHT, pageViewRect.size.width, PAGECONTROL_HEIGHT)];
    UIColor* currentTintColor = [self.view tintColor];
    UIColor* tintColor = [currentTintColor colorWithAlphaComponent:0.3];
    pageControl.pageIndicatorTintColor = tintColor ;
    pageControl.currentPageIndicatorTintColor = currentTintColor ;
    pageControl.backgroundColor = [ UIColor clearColor ] ;
    pageControl.numberOfPages = self.controllers.count;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    [self.pageViewController.view addSubview:pageControl];
}

-(void)submit
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger currentIndex = [self.controllers indexOfObject:viewController];
    if(currentIndex > 0 ){
        currentIndex --;
        UIViewController* newViewController = [self.controllers objectAtIndex: currentIndex];
        self.navigationItem.title = newViewController.title;
        self.pageControl.currentPage = currentIndex;
        return newViewController;
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger currentIndex = [self.controllers indexOfObject:viewController];
    if(currentIndex < self.controllers.count - 1){
        currentIndex ++;
        UIViewController* newViewController = [self.controllers objectAtIndex: currentIndex];
        self.navigationItem.title = newViewController.title;
        self.pageControl.currentPage = currentIndex;
        return newViewController;
    } else {
        return nil;
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSInteger currentIndex = [self.controllers indexOfObject: pendingViewControllers[0]];
    self.pageControl.currentPage = currentIndex;
}
@end
