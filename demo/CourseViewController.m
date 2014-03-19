//
//  CourseViewController.m
//  demo
//
//  Created by john on 14-3-17.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "CourseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CourseViewController ()
@property(nonatomic, strong) MPMoviePlayerController* moviePlayer;

@end

@implementation CourseViewController

@synthesize moviePlayer;

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
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"videoviewdemo" ofType:@"mp4"]];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    [moviePlayer.view setFrame:self.tabBarController.view.bounds];
    [self.tabBarController.view addSubview:moviePlayer.view];
    moviePlayer.view.backgroundColor = [UIColor whiteColor];
    moviePlayer.shouldAutoplay=YES;

    moviePlayer.controlStyle=MPMovieControlStyleFullscreen;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    [moviePlayer prepareToPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self handleOrientation];
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.moviePlayer.view.frame = self.tabBarController.view.bounds;
}

- (void)MPMoviePlayerDidExitFullscreen:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:nil];
    
    [self.moviePlayer stop];
    [self.moviePlayer.view removeFromSuperview];
}
@end
