//
//  GettingForFriendSwipingViewController.m
//  Korte
//
//  Created by Peace on 8/21/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "GettingForFriendSwipingViewController.h"

@interface GettingForFriendSwipingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gettingForFriendLabel;
@end

@implementation GettingForFriendSwipingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //    with friends connect
    self.gettingForFriendLabel.attributedText = attributedString(@"Request to Swipe for Friends",StandardColor(), 2.22f);
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
