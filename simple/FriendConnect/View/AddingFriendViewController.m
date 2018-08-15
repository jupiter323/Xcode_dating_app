//
//  MXViewController.m
//  MXCardsSwipingView
//
//  Created by Scott Kensell on 07/01/2018.
//  Copyright (c) 2018 Scott Kensell. All rights reserved.
//

#import "AddingFriendViewController.h"
#import "ONCardsSwipingView.h"
#import "OnCard.h"

@interface AddingFriendViewController () <MXCardsSwipingViewDelegate>

@property (nonatomic, strong) ONCardsSwipingView* cardsSwipingView;

@end

@implementation AddingFriendViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    ONCardsSwipingView *cardsSwipingView = [[ONCardsSwipingView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    cardsSwipingView.delegate = self;
    self.cardsSwipingView = cardsSwipingView;
    [self addCard];

    //    remove returnButton 
    self.returnButton.removeFromSuperview;
    
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
    
    
   
    //    adding part 
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



- (BOOL)cardsSwipingView:(ONCardsSwipingView *)cardsSwipingView willDismissCard:(UIView *)card destination:(MXCardDestination)destination {
  
    switch (destination) {
        case MXCardDestinationRight:
            NSLog(@"right");
            break;
        case MXCardDestinationLeft:
            NSLog(@"left");
            break;
        case MXCardDestinationUp:
            NSLog(@"up");
            break;
            
        default:
            break;
    }
 
    
    static int i=0;
    if (++i % 5 == 0) return NO;

    return YES;
}

- (void)addCard {
    OnCard* leftCard = [[OnCard alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2 - 40, (self.view.bounds.size.height - 250)/[OnCard aspectRatio])];
    [leftCard setupWithAModel:nil];
    [leftCard addShadow];
    [self.cardsSwipingView enqueueCard:leftCard];
    
    OnCard* RightCard = [[OnCard alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, 0, self.view.bounds.size.width/2 - 40, (self.view.bounds.size.height - 250)/[OnCard aspectRatio])];
    [RightCard setupWithAModel:nil];
    [RightCard addShadow];
    [self.cardsSwipingView enqueueCard:RightCard];
}

@end
