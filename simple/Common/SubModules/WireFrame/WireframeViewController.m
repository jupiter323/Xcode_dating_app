//
//  WireframeViewController.m
//  Korte
//
//  Created by Peace on 8/15/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "WireframeViewController.h"

@interface WireframeViewController ()

@end

@implementation WireframeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)addButtonTapped:(UIButton *)sender {
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionUp];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
    
    NSArray *menuIcons;
    if(button==self.addConnection)
        menuIcons = @[@"AddConnection", @"pro_match", @"pro_location", @"addCon"];
    else
        menuIcons = @[@"pro_close", @"pro_match", @"pro_location", @"addCon"];
    NSMutableArray *menus = [NSMutableArray array];
    
    CGSize itemSize = button.frame.size;
    for (NSString *icon in menuIcons) {
        LSFloatingActionMenuItem *item = [[LSFloatingActionMenuItem alloc] initWithImage:[UIImage imageNamed:icon] highlightedImage:[UIImage imageNamed:[icon stringByAppendingString:@"pro_menu"]]];
        item.itemSize = itemSize;
        [menus addObject:item];
    }
    
    self.actionMenu = [[LSFloatingActionMenu alloc] initWithFrame:self.view.bounds direction:direction menuItems:menus menuHandler:^(LSFloatingActionMenuItem *item, NSUInteger index) {
        //TODO
        
        switch (index) {
            case 1:
                NSLog(@"1 clicked");
                break;
            case 2:
                // to location
                [self toLocation];
                break;
            case 3:
                // to add connecting
                [self toAddConnection];
                break;
            default:
                break;
        }
        
    } closeHandler:^{
        [self.actionMenu removeFromSuperview];
        self.actionMenu = nil;
        button.hidden = NO;
    }];
    
    self.actionMenu.itemSpacing = 12;
    self.actionMenu.startPoint = button.center;
    if(button==self.addConnection)
        self.actionMenu.rotateStartMenu = YES;
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
}
-(void)returnFun:(UIButton *) sender {
    //    animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    //    navigating
    [self.navigationController popViewControllerAnimated:NO];
}
-(void) navAnimating:(NSString *) type subtype:(NSString *) subtype{
    //    for animation navigating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = type; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = subtype; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
}
-(void)toProfile:(UIButton *) sender{
  //for animation navigating
    [self navAnimating:kCATransitionPush subtype:kCATransitionFromTop];
    
    //    navigating to profile
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    UINavigationController *profileScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idProfile"];
    
    [self.navigationController pushViewController:profileScene animated:NO];
    
}
-(void)toLocation {

    //for animation navigating
    [self navAnimating:kCATransitionFade subtype:kCATransitionFromLeft];
    
    //        navigating to location
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Location" bundle:nil];
    UINavigationController *locationScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idLocation"];
    
    [self.navigationController pushViewController:locationScene animated:NO];
    
}
-(void)toAddConnection {

    //for animation navigating
    [self navAnimating:kCATransitionFade subtype:kCATransitionFromLeft];
    //        navigating to addconnection
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AddConnectScreen" bundle:nil];
    UINavigationController *addScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idAddConnection"];
    
    [self.navigationController pushViewController:addScene animated:NO];
    
}

-(void)tapedNoti:(UIButton *) sender {
    [self showNotiFromButton:sender withDirection:LSFloatingActionMenuDirectionDown];
}
- (void)showNotiFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
    NSArray *menuIcons;
    if(button==self.notificationButton){
        if(themKind==StandardTheme)
            menuIcons = @[@"noti", @"sunglassesGirl",@"cityStudent"];
        else menuIcons = @[@"pro_noti_acti", @"sunglassesGirl",@"cityStudent"];
    }
    else {
        if(themKind==StandardTheme)
            menuIcons = @[@"message", @"sunglassesGirl",@"cityStudent"];
        else
            menuIcons = @[@"pro_message", @"sunglassesGirl",@"cityStudent"];
    }
    NSMutableArray *menus = [NSMutableArray array];
    
    CGSize itemSize = button.frame.size;
    for (NSString *icon in menuIcons) {
        UIImage *IconImage = [UIImage imageNamed:icon];
        if([menuIcons indexOfObject:icon]!=0){
            ////cropping and radius UIimage
            UIImage *croppedImg = nil;
            float rectWidth = (IconImage.size.width>IconImage.size.height)?IconImage.size.height:IconImage.size.width;
            CGRect cropRect = CGRectMake(0, 0, rectWidth, rectWidth); //set your rect size.
            croppedImg = croppIngimageByImageName(IconImage, cropRect);
            IconImage = makeRoundedImage(croppedImg,rectWidth/2);
            //        IconImage = imageWithBorderFromImage(IconImage);
        }
        LSFloatingActionMenuItem *item = [[LSFloatingActionMenuItem alloc] initWithImage:IconImage highlightedImage:[UIImage imageNamed:[icon stringByAppendingString:@"pro_menu"]]];
        item.itemSize = itemSize;
        [menus addObject:item];
    }
    
    self.actionMenu = [[LSFloatingActionMenu alloc] initWithFrame:self.view.bounds direction:direction menuItems:menus menuHandler:^(LSFloatingActionMenuItem *item, NSUInteger index) {
        //TODO
        
        switch (index) {
            case 1:
                NSLog(@"1 clicked");
                break;
            case 2:
                //                location
                //                [self toLocation];
                break;
            case 3:
                NSLog(@"3 clicked");
                break;
            default:
                break;
        }
        
    } closeHandler:^{
        [self.actionMenu removeFromSuperview];
        self.actionMenu = nil;
        button.hidden = NO;
        //        self.notifyButton.hidden = NO;
    }];
    
    self.actionMenu.itemSpacing = 2;
    self.actionMenu.startPoint = button.center;
    //    self.actionMenu.frame = CGRectMake(button.frame.origin.x,button.frame.origin.y+button.frame.size.width, button.frame.size.width+5, 10+button.frame.size.height*(sizeof(menuIcons))-1);
    //    self.actionMenu.layer.cornerRadius=button.frame.size.width/2;
    //    self.actionMenu.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
