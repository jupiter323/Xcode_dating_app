//
//  BasicMenuController.m
//  simple
//
//  Created by Peace on 8/8/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "BasicMenuController.h"

@interface BasicMenuController ()
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;

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
    self.returnButton.frame = CGRectMake(20,20, self.returnButton.bounds.size.width, self.returnButton.bounds.size.height);
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
-(void)tapedNoti:(UIButton *) sender {
    [self showNotiFromButton:sender withDirection:LSFloatingActionMenuDirectionDown];
}
- (void)showNotiFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
    
    
    NSArray *menuIcons = @[@"pro_noti_acti", @"sunglassesGirl",@"cityStudent"];
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

-(void)tapedToggle:(UIButton *) sender {
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionLeft];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
    self.notificationButton.hidden = YES;
    
    NSArray *menuIcons = @[@"pro_close", @"pro_match", @"pro_location", @"addCon"];
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
                // location
                [self toLocation];
                break;
            case 3:
                // add connection
                [self toAddConnection];
                break;
            default:
                break;
        }
        
    } closeHandler:^{
        [self.actionMenu removeFromSuperview];
        self.actionMenu = nil;
        button.hidden = NO;
        self.notificationButton.hidden = NO;
    }];
    
    self.actionMenu.itemSpacing = 12;
    self.actionMenu.startPoint = button.center;
    
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
}
-(void)toLocation {
    NSLog(@"location");
    //    for animation navigating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    //        navigating to location
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Location" bundle:nil];
    UINavigationController *locationScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idLocation"];
    
    [self.navigationController pushViewController:locationScene animated:NO];
    
}
-(void)toAddConnection {
    NSLog(@"addconnection");
    //    for animation navigating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    //        navigating to addconnection
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AddConnectScreen" bundle:nil];
    UINavigationController *addScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idAddConnection"];
    
    [self.navigationController pushViewController:addScene animated:NO];
    
}



@end
