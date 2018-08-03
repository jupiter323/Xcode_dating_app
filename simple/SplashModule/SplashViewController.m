//
//  SplashViewController.m
//  simple
//
//  Created by Peace on 8/2/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "SplashViewController.h"
#import "MXViewController.h"
@interface SplashViewController ()


@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goTinder:(UIButton *)sender {
    NSLog(@"log button");
    [self.navigationController pushViewController:[MXViewController new] animated:YES];
    
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
