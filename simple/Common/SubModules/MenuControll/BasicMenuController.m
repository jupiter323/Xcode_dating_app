//
//  BasicMenuController.m
//  simple
//
//  Created by Peace on 8/8/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "BasicMenuController.h"

@interface BasicMenuController ()

@end

@implementation BasicMenuController

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
    // return button
    self.returnButton = [[UIButton alloc] init];
    [self.returnButton setImage:[UIImage imageNamed:@"pro_close"] forState:UIControlStateNormal];
    [self.returnButton sizeToFit];
    self.returnButton.frame = CGRectMake(20,34, self.returnButton.bounds.size.width, self.returnButton.bounds.size.height);
 
    [self.returnButton addTarget:self action:@selector(returnFun:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.returnButton];
    //    float buttons menu
    self.floatingButton = [[UIButton alloc] init];
    [self.floatingButton setImage:[UIImage imageNamed:@"pro_menu"] forState:UIControlStateNormal];
    [self.floatingButton sizeToFit];
    self.floatingButton.frame = CGRectMake(20,20, self.floatingButton.bounds.size.width, self.floatingButton.bounds.size.height);
    [self.floatingButton addTarget:self action:@selector(tapedToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.floatingButton];
    
    //    Notification buttons menu
    self.notificationButton = [[UIButton alloc] init];
    [self.notificationButton setImage:[UIImage imageNamed:@"pro_noti"] forState:UIControlStateNormal];
    [self.notificationButton sizeToFit];
    self.notificationButton.frame = CGRectMake(self.view.bounds.size.width-20-self.notificationButton.bounds.size.width, 20, self.notificationButton.bounds.size.width, self.notificationButton.bounds.size.height);
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
