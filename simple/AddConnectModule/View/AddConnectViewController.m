//
//  AddConnectViewController.m
//  Korte
//
//  Created by Peace on 8/12/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "AddConnectViewController.h"
#import "Utilities.h"
@interface AddConnectViewController ()
@property (weak, nonatomic) IBOutlet UIView *addContainView;
@property (weak, nonatomic) IBOutlet UIView *swipeForMeScroll;
@property (weak, nonatomic) IBOutlet UIView *swipeformeScrollContent;

@end

@implementation AddConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
// add contain View
    self.addContainView.layer.cornerRadius = self.addContainView.frame.size.width/2;
    [self.addContainView setBackgroundColor:[UIColor colorWithRed:240/256 green:124/256 blue:103/256 alpha:0.6]];
    
//    swipe for me scroll adding
    UIScrollView *matches = [[UIScrollView alloc] init];
    [self.swipeForMeScroll setBackgroundColor:UIColorWithHexString(@"#E8E3E3")];    
    CGFloat marginLeft = 0;
    CGFloat ContentScrollHeight = self.swipeformeScrollContent.frame.size.height;
    CGFloat ContentScrollWidth = self.swipeformeScrollContent.frame.size.width;
    CGFloat avatarWidth = self.swipeformeScrollContent.frame.size.height;
    matches.frame = CGRectMake(marginLeft,ContentScrollHeight-avatarWidth-10 , ContentScrollWidth, avatarWidth);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*avatarWidth, avatarWidth);
    for(int i=0;i<sizeOfMatches;i++){
        CGFloat buttonWidth = avatarWidth;
        CGFloat buttonSide = 10;
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+10,0 , buttonWidth, buttonWidth);
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        [avatar addTarget:self action:@selector(goToToMtch:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        
        [matches addSubview:avatar];
    }
    [self.swipeformeScrollContent addSubview:matches];
    [self.swipeformeScrollContent setBackgroundColor:UIColorWithHexString(@"#E8E3E3")];
//    
    
}
-(void)goToToMtch:sender{
    
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
