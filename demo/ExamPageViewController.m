//
//  ExamPageViewController.m
//  demo
//
//  Created by john on 14-3-16.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "ExamPageViewController.h"

@interface ExamPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property NSArray* controllers;
@property (nonatomic, strong) UIPageViewController* pageViewController;
@property (nonatomic, strong) UIPageControl * pageControl;
@property NSInteger orientation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;
@end

@implementation ExamPageViewController;
@synthesize pageViewController;
@synthesize pageControl;
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

	// Do any additional setup after loading the view.
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.controllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"ExamList"], [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendExam"]];
    NSRange range;
    range.length = 1;
    range.location = 0;
    
    [self.pageViewController setViewControllers:[self.controllers subarrayWithRange:range] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        
    }];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    
    [self.pageViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    self.pageControl = [[UIPageControl alloc] init];
#define PAGECONTROL_HEIGHT 32
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    self.pageControl.frame = CGRectMake(0, pageViewRect.origin.y + pageViewRect.size.height - PAGECONTROL_HEIGHT, pageViewRect.size.width, PAGECONTROL_HEIGHT);
    UIColor* currentTintColor = [self.view tintColor];
    UIColor* tintColor = [currentTintColor colorWithAlphaComponent:0.3];
    pageControl.pageIndicatorTintColor = tintColor ;
    pageControl.currentPageIndicatorTintColor = currentTintColor ;
    pageControl.backgroundColor = [ UIColor clearColor ] ;
    pageControl.numberOfPages = self.controllers.count;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    [self handlePageChange: 0 viewController:self.controllers[0]];
    [self.pageViewController.view addSubview:pageControl];
    
    self.view.contentMode = UIViewContentModeRedraw;
    self.orientation = 0;
}

- (void) viewDidAppear:(BOOL)animated
{
    [self handleRotation];
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
        self.pageControl.currentPage = currentIndex;
        return newViewController;
    } else {
        return nil;
    }
}

- (void)handlePageChange:(NSInteger) pageIndex viewController: (UIViewController*)viewController
{
    UIBarButtonItem* btn = self.submitButton;
    if(pageIndex == 1){
        btn.style = UIBarButtonItemStyleBordered;
        btn.enabled = true;
        btn.title = @"提交";
    } else {
        btn.style = UIBarButtonItemStyleBordered;
        btn.enabled = false;
        btn.title = nil;
    }
    self.navigationItem.title = viewController.title;
    self.pageControl.currentPage = pageIndex;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger currentIndex = [self.controllers indexOfObject:viewController];
    if(currentIndex < self.controllers.count - 1){
        currentIndex ++;
        UIViewController* newViewController = [self.controllers objectAtIndex: currentIndex];
        self.pageControl.currentPage = currentIndex;
        return newViewController;
    } else {
        return nil;
    }
}

-(void)pageViewController:(UIPageViewController *)viewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController* currentViewController = viewController.viewControllers[0];
    NSInteger currentIndex = [self.controllers indexOfObject: currentViewController];
    [self handlePageChange:currentIndex viewController:currentViewController];
}

-(void)handleRotation
{
    if(self.orientation == 0 || UIInterfaceOrientationIsPortrait(self.orientation) != UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        CGRect pageViewRect = self.view.bounds;
        self.pageControl.frame = CGRectMake(0, pageViewRect.origin.y + pageViewRect.size.height - PAGECONTROL_HEIGHT, pageViewRect.size.width, PAGECONTROL_HEIGHT);
    }
    self.orientation = self.interfaceOrientation;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self handleRotation];
}
@end
