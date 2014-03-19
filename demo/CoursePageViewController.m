//
//  CoursePageViewController.m
//  demo
//
//  Created by john on 14-3-16.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "CoursePageViewController.h"

@interface CoursePageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property NSArray* controllers;
@property (nonatomic, strong) UIPageViewController* pageViewController;
@property (strong, nonatomic) UIPageControl *pageControl;
@property NSInteger currentIndex;

@end

@implementation CoursePageViewController

@synthesize pageViewController;
@synthesize pageControl;
@synthesize currentIndex;

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
    
	// Do any additional setup after loading the view.
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.controllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"CourseList"], [self.storyboard instantiateViewControllerWithIdentifier:@"CourseDownload"]];
    NSRange range;
    range.length = 1;
    range.location = 0;
    
    [self.pageViewController setViewControllers:[self.controllers subarrayWithRange:range] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    
    [self.pageViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    self.pageViewController.view.frame = self.view.bounds;
    UIColor* currentTintColor = [self.view tintColor];
    UIColor* tintColor = [currentTintColor colorWithAlphaComponent:0.3];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(140, 418, 39, 37)];
    pageControl.pageIndicatorTintColor = tintColor ;
    pageControl.currentPageIndicatorTintColor = currentTintColor ;
    pageControl.numberOfPages = self.controllers.count;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    [pageControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pageControl];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    UIViewController* viewController = self.controllers[0];
    [self handlePageChange: 0 withTitle: viewController.title];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handlePageControl:(UIPageControl*)sender
{
    UIViewController* viewController = self.controllers[sender.currentPage];
    [self.pageViewController setViewControllers:@[viewController] direction:(sender.currentPage > self.currentIndex? UIPageViewControllerNavigationDirectionForward: UIPageViewControllerNavigationDirectionReverse) animated:YES completion:nil];
    [self handlePageChange:sender.currentPage withTitle: viewController.title];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if(index > 0 ){
        index --;
        UIViewController* newViewController = [self.controllers objectAtIndex: index];
        self.pageControl.currentPage = index;
        return newViewController;
    } else {
        return nil;
    }
}

- (void)handlePageChange:(NSInteger) pageIndex withTitle: (NSString*)title
{
    self.navigationItem.title = title;
    self.pageControl.currentPage = pageIndex;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if(index < self.controllers.count - 1){
        index ++;
        UIViewController* newViewController = [self.controllers objectAtIndex: index];
        self.pageControl.currentPage = index;
        return newViewController;
    } else {
        return nil;
    }
}

-(void)pageViewController:(UIPageViewController *)viewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController* currentViewController = viewController.viewControllers[0];
    self.currentIndex = [self.controllers indexOfObject: currentViewController];
    [self handlePageChange:currentIndex withTitle:currentViewController.title];
}
@end
