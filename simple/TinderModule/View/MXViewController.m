//
//  MXViewController.m
//  MXCardsSwipingView
//
//  Created by Scott Kensell on 07/01/2018.
//  Copyright (c) 2018 Scott Kensell. All rights reserved.
//

#import "MXViewController.h"
#import <MXCardsSwipingView/MXCardsSwipingView.h>
#import "MXMemberCardView.h"
#import "LSFloatingActionMenu.h"
@interface MXViewController () <MXCardsSwipingViewDelegate>

@property (nonatomic, strong) MXCardsSwipingView* cardsSwipingView;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@property (strong, nonatomic) UIButton *notifyButton;

@end

@implementation MXViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    MXCardsSwipingView *cardsSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    cardsSwipingView.delegate = self;
    self.cardsSwipingView = cardsSwipingView;
    [self addCard];
    [self addCard];
    [self addCard];
    
    //    ignore button
    UIButton *notNowButton = [[UIButton alloc] init];
    [notNowButton setTitle:@"Not Now" forState:UIControlStateNormal];
    [notNowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    notNowButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    [notNowButton sizeToFit];
    notNowButton.frame = CGRectMake(20, cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height + 12, notNowButton.bounds.size.width, notNowButton.bounds.size.height);
    [notNowButton addTarget:cardsSwipingView action:@selector(dismissTopCardToLeft) forControlEvents:UIControlEventTouchUpInside];
    
    //    connect button
    UIButton *connectButton = [[UIButton alloc] init];
    [connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    [connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    connectButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    [connectButton sizeToFit];
    connectButton.frame = CGRectMake(self.view.bounds.size.width - (20 + connectButton.bounds.size.width), notNowButton.frame.origin.y, connectButton.bounds.size.width, connectButton.bounds.size.height);
    [connectButton addTarget:cardsSwipingView action:@selector(dismissTopCardToRight) forControlEvents:UIControlEventTouchUpInside];
    
    //    add connect button
    UIButton *addConnection = [[UIButton alloc] init];
    [addConnection setImage:[UIImage imageNamed:@"AddConnection"] forState:UIControlStateNormal];
    [addConnection sizeToFit];
    addConnection.frame = CGRectMake(self.view.bounds.size.width - (20 + addConnection.bounds.size.width), cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height-addConnection.bounds.size.height/2, addConnection.bounds.size.width, addConnection.bounds.size.height);
    [addConnection addTarget:self action:@selector(addButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //    profile button
    UIButton *myProfile = [[UIButton alloc] init];
    myProfile.frame = CGRectMake(self.view.bounds.size.width/2-self.view.bounds.size.width/12, cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height-self.view.bounds.size.width/18, self.view.bounds.size.width/6, self.view.bounds.size.width/6);
    [myProfile setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    myProfile.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [myProfile addTarget:self action:@selector(toProfile:) forControlEvents:UIControlEventTouchUpInside];
    myProfile.layer.cornerRadius = myProfile.frame.size.width / 2;
    myProfile.clipsToBounds = YES;
    myProfile.layer.borderWidth = 5.0f;
    myProfile.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    //    bottom style
    UIView *bottom = [[UIView alloc] init];
    bottom.frame = CGRectMake(0, cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-(cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height));
    bottom.backgroundColor = [UIColor whiteColor];
    
    //    float buttons menu
    UIButton *floatingButton = [[UIButton alloc] init];
    [floatingButton setImage:[UIImage imageNamed:@"pro_menu"] forState:UIControlStateNormal];
    [floatingButton sizeToFit];
    floatingButton.frame = CGRectMake(20,20, floatingButton.bounds.size.width, floatingButton.bounds.size.height);
    [floatingButton addTarget:self action:@selector(tapedToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    //    push notification button
    self.notifyButton = [[UIButton alloc] init];
    [self.notifyButton setImage:[UIImage imageNamed:@"pro_noti"] forState:UIControlStateNormal];
    [self.notifyButton sizeToFit];
    self.notifyButton.frame = CGRectMake(self.view.bounds.size.width-20-self.notifyButton.bounds.size.width, 20, self.notifyButton.bounds.size.width, self.notifyButton.bounds.size.height);
    //    [self.notifyButton addTarget:self action:@selector(tapedToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //    adding part
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newSplashBG"]];
    [self.view addSubview:floatingButton];
    [self.view addSubview:self.notifyButton];
    [self.view addSubview:bottom];
    [self.view addSubview:addConnection];
    [self.view addSubview:myProfile];
    [self.view addSubview:cardsSwipingView];
    
    
    
}
-(void)toProfile:(UIButton *) sender{
    //    for animation navigating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    //    navigating to profile
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    UINavigationController *profileScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idProfile"];
    
    [self.navigationController pushViewController:profileScene animated:NO];
    
}
-(void)tapedToggle:(UIButton *) sender {
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionLeft];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
    self.notifyButton.hidden = YES;
    
    NSArray *menuIcons = @[@"pro_close", @"pro_match", @"pro_location", @"pro_analysis"];
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
                //                location
                [self toLocation];
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
        self.notifyButton.hidden = NO;
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
- (void)addButtonTapped:(UIButton *)sender {
    NSLog(@"Ok button was tapped: dismiss the view controller.");
}


- (BOOL)cardsSwipingView:(MXCardsSwipingView *)cardsSwipingView willDismissCard:(UIView *)card toLeft:(BOOL)toLeft {
    
    if(toLeft)
        NSLog(@"left");
    else
        NSLog(@"Right");
    static int i=0;
    if (++i % 5 == 0) return NO;
    [self addCard];
    return YES;
}

- (void)addCard {
    MXMemberCardView* card = [[MXMemberCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 40, (self.view.bounds.size.height - 250)/[MXMemberCardView aspectRatio])];
    [card setupWithAModel:nil];
    [card addShadow];
    [self.cardsSwipingView enqueueCard:card];
}

@end
