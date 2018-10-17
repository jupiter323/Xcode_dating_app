//
//  VideoPlayViewController.m
//  Korte
//
//  Created by Peace on 10/16/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "VideoPlayViewController.h"

@interface VideoPlayViewController (){
    NSURL *videoUrl;
}
@property (strong, nonatomic) AVPlayerViewController *playerViewController;

@end

@implementation VideoPlayViewController
@synthesize videoUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    AVPlayer* playVideo = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    self.playerViewController = [[AVPlayerViewController alloc] init];
    self.playerViewController.player = playVideo;
    self.playerViewController.player.volume = 0;
    self.playerViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.playerViewController.view];
    [playVideo play];
    
    //close button
    UIButton *closeVideo = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30,30)];
    [closeVideo addTarget:self action:@selector(returnFun:) forControlEvents:UIControlEventTouchDown];
    [closeVideo setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.view addSubview:closeVideo];
    
}
-(void)returnFun:(id) sender{
    //    navigating
    [self.navigationController popViewControllerAnimated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
