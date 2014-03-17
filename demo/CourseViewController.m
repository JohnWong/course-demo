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
@property NSInteger orientation;
@property UIImageView* coverImageView;
@property(nonatomic, strong) MPMoviePlayerController* moviePlayer;

@end

@implementation CourseViewController

@synthesize orientation;
@synthesize coverImageView;
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
    coverImageView=[[UIImageView alloc]init];
    coverImageView.image = [UIImage imageNamed:@"videoviewdemo.png"];
    [self.view addSubview:coverImageView];
    self.orientation = 0;
    
    NSURL *url = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"videoviewdemo" ofType:@"mp4"]];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.view addSubview:moviePlayer.view];
//    moviePlayer set
    [moviePlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self handleRotation];
}

-(void) handleRotation
{
    NSLog(@"%d %d", self.orientation, self.interfaceOrientation);
    if(self.orientation == 0 || UIInterfaceOrientationIsPortrait(self.orientation) != UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        CGSize imageSize = self.coverImageView.image.size;
        CGRect frame = self.view.bounds;
        CGSize viewSize;
        if(imageSize.width/imageSize.height >= frame.size.width/frame.size.height)
        {
            viewSize.width = frame.size.width;
            viewSize.height = viewSize.width * imageSize.height / imageSize.width;
        } else {
            viewSize.height = frame.size.height;
            viewSize.width = viewSize.height * imageSize.width / imageSize.height;
        }
        CGRect playerRect = CGRectMake(frame.origin.x + (frame.size.width - viewSize.width) / 2 , frame.origin.y + (frame.size.height - viewSize.height) / 2, viewSize.width, viewSize.height);
        coverImageView.frame = playerRect;
        self.moviePlayer.view.frame = playerRect;
        NSLog(@"%@", NSStringFromCGRect(coverImageView.frame));
    }
    self.orientation = self.interfaceOrientation;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self handleRotation];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.moviePlayer stop];
}
@end
