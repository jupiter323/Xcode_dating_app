//
//  AddingViewController.m
//  simple
//
//  Created by Peace on 8/9/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "AddingViewController.h"

@interface AddingViewController ()
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;

@end

@implementation AddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //top background
    UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = @[
                        (id)[[UIColor colorWithRed:0.98 green:0.49 blue:0.38 alpha:1] CGColor],
                        (id)[[UIColor colorWithRed:0.85 green:0.49 blue:0.45 alpha:1] CGColor]
                        ];
    gradient.locations = @[@(0), @(1)];
    gradient.startPoint = CGPointMake(0.5, 0);
    gradient.endPoint = CGPointMake(0.5, 0.98);
    [[layer layer] addSublayer:gradient];
    [[self view] insertSubview:layer atIndex:0];
    //    bottom style
    UIView *bottom = [[UIView alloc] init];
    bottom.frame = CGRectMake(0,self.view.frame.size.height-56, self.view.bounds.size.width, 56);
    bottom.layer.cornerRadius = 3;
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    //    add connect button
    self.addConnection = [[UIButton alloc] init];
    [self.addConnection setImage:[UIImage imageNamed:@"AddConnection"] forState:UIControlStateNormal];
    [self.addConnection sizeToFit];
    self.addConnection.frame = CGRectMake(self.view.bounds.size.width - (23 + self.addConnection.frame.size.width), self.view.bounds.size.height-56-33, self.addConnection.frame.size.width, self.addConnection.frame.size.width);
    [self.addConnection addTarget:self action:@selector(addButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addConnection];
    // return button
    self.returnButton = [[UIButton alloc] init];
    [self.returnButton setImage:[UIImage imageNamed:@"pro_close"] forState:UIControlStateNormal];
    [self.returnButton sizeToFit];
    self.returnButton.frame = CGRectMake(20,20, self.returnButton.bounds.size.width, self.returnButton.bounds.size.height);
    [self.returnButton addTarget:self action:@selector(returnFun:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.returnButton];
    //    message buttons menu
    self.messageButton = [[UIButton alloc] init];
    [self.messageButton setImage:[UIImage imageNamed:@"pro_message"] forState:UIControlStateNormal];
    [self.messageButton sizeToFit];
    self.messageButton.frame = CGRectMake(self.view.bounds.size.width-15-self.messageButton.bounds.size.width, 33, self.messageButton.bounds.size.width, self.messageButton.bounds.size.height);
    [self.messageButton addTarget:self action:@selector(toMatches:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageButton];
    
    //    Notification buttons menu
    self.notificationButton = [[UIButton alloc] init];
    [self.notificationButton setImage:[UIImage imageNamed:@"pro_noti"] forState:UIControlStateNormal];
    [self.notificationButton sizeToFit];
    self.notificationButton.frame = CGRectMake(18, 36, self.notificationButton.bounds.size.width, self.notificationButton.bounds.size.height);
    [self.notificationButton addTarget:self action:@selector(tapedNoti:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.notificationButton];
    //    background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newSplashBG"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
