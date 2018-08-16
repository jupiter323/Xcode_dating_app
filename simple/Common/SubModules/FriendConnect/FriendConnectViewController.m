//
//  AddingViewController.m
//  simple
//
//  Created by Peace on 8/9/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "FriendConnectViewController.h"

@interface FriendConnectViewController ()

@end

@implementation FriendConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    theme kind
    themKind = StandardTheme;
    //    bottom style
    UIView *bottom = [[UIView alloc] init];
    bottom.frame = CGRectMake(0,self.view.frame.size.height-50, self.view.bounds.size.width, 50);
    bottom.backgroundColor = BottomColor();
    [self.view addSubview:bottom];
    //    add connect button
    self.addConnection = [[UIButton alloc] init];
    [self.addConnection setImage:[UIImage imageNamed:@"AddConnection"] forState:UIControlStateNormal];
    [self.addConnection sizeToFit];
    self.addConnection.frame = CGRectMake(self.view.bounds.size.width - (20 + self.addConnection.bounds.size.width), self.view.frame.size.height-50-self.addConnection.frame.size.height/2, self.addConnection.bounds.size.width, self.addConnection.bounds.size.height);
    [self.addConnection addTarget:self action:@selector(addButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addConnection];
    
    //    message buttons menu
    self.messageButton = [[UIButton alloc] init];
    [self.messageButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.messageButton sizeToFit];
    self.messageButton.frame = CGRectMake(self.view.bounds.size.width-20-self.messageButton.bounds.size.width, 20, self.messageButton.bounds.size.width, self.messageButton.bounds.size.height);
    [self.messageButton addTarget:self action:@selector(tapedNoti:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageButton];
    
    //    Notification buttons menu
    self.notificationButton = [[UIButton alloc] init];
    [self.notificationButton setImage:[UIImage imageNamed:@"noti"] forState:UIControlStateNormal];
    [self.notificationButton sizeToFit];
    self.notificationButton.frame = CGRectMake(20, 20, self.notificationButton.bounds.size.width, self.notificationButton.bounds.size.height);
    [self.notificationButton addTarget:self action:@selector(tapedNoti:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.notificationButton];
    //    background
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    profile button
    self.myProfile = [[UIButton alloc] init];
    self.myProfile.frame = CGRectMake(self.view.bounds.size.width/2-self.view.bounds.size.width/12,
                                 self.view.bounds.size.height-self.view.bounds.size.width/18-50, self.view.bounds.size.width/6, self.view.bounds.size.width/6);
    [self.myProfile setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    self.myProfile.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [self.myProfile addTarget:self action:@selector(toProfile:) forControlEvents:UIControlEventTouchUpInside];
    self.myProfile.layer.cornerRadius = self.myProfile.frame.size.width / 2;
    self.myProfile.clipsToBounds = YES;
    self.myProfile.layer.borderWidth = 5.0f;
    self.myProfile.layer.borderColor = BottomColor().CGColor;
    [self.view addSubview:self.myProfile];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
