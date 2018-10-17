//
//  ProfileCollectionViewCell.m
//  Korte
//
//  Created by Peace on 9/18/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}
- (void) setupCell {
    
    //Create image
    self.avatarImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImage];
    
    // Create subbutton
    self.subButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.subButton];
    
    self.tapVideo = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, self.contentView.bounds.size.width-40,self.contentView.bounds.size.height-40)];
    [self.tapVideo addTarget:self action:@selector(actionPlayVideo:) forControlEvents:UIControlEventTouchDown];
    [self.tapVideo setImage:[UIImage imageNamed:@"videoPlay"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.tapVideo];
    
    self.isVideo = false;
}
-(void) actionPlayVideo:(id) sender {
    NSURL *vedioURL =[NSURL fileURLWithPath:self.fileUrl];
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:vedioURL];
    AVPlayer* playVideo = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    self.playerViewController = [[AVPlayerViewController alloc] init];
    self.playerViewController.player = playVideo;
    self.playerViewController.player.volume = 0;
    self.playerViewController.view.frame = self.bounds;
    [self addSubview:self.playerViewController.view];
    [playVideo play]; 

}
-(void) setVideo{
    self.tapVideo.hidden = NO;
    self.isVideo = true;
}

-(void) setImage{
    self.tapVideo.hidden = YES;    
    self.isVideo = false;
}
-(void) flagIsVideo{
    self.isVideo = true;
}
- (void) enableGestureC:(BOOL) enable{
    [self enableGesture:enable];
}
@end
