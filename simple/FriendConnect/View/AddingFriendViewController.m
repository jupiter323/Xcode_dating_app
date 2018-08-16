//
//  MXViewController.m
//  MXCardsSwipingView
//
//  Created by Scott Kensell on 07/01/2018.
//  Copyright (c) 2018 Scott Kensell. All rights reserved.
//

#import "AddingFriendViewController.h"
#import "MXCardsSwipingView.h"
#import "OnCard.h"

@interface AddingFriendViewController () <MXCardsSwipingViewDelegate>

@property (nonatomic, strong) MXCardsSwipingView* cardsLeftSwipingView;
@property (nonatomic, strong) MXCardsSwipingView* cardsRightSwipingView;

@end

@implementation AddingFriendViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];


    
//    card views adding
    MXCardsSwipingView *cardsLeftSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/3, self.view.bounds.size.width/2, self.view.bounds.size.height/3)];
    cardsLeftSwipingView.delegate = self;
    
    MXCardsSwipingView *cardsRightSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/3, self.view.bounds.size.width/2, self.view.bounds.size.height/3)];
    cardsRightSwipingView.delegate = self;
    
    self.cardsLeftSwipingView = cardsLeftSwipingView;
    self.cardsRightSwipingView = cardsRightSwipingView;
    [self addCard];
    
    
    //    ignore button
    //    UIButton *notNowButton = [[UIButton alloc] init];
    //    [notNowButton setTitle:@"Not Now" forState:UIControlStateNormal];
    //    [notNowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    notNowButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    //    [notNowButton sizeToFit];
    //    notNowButton.frame = CGRectMake(20, cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height + 12, notNowButton.bounds.size.width, notNowButton.bounds.size.height);
    //    [notNowButton addTarget:cardsSwipingView action:@selector(dismissTopCardToLeft) forControlEvents:UIControlEventTouchUpInside];
    
    //    connect button
    //    UIButton *connectButton = [[UIButton alloc] init];
    //    [connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    //    [connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    connectButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    //    [connectButton sizeToFit];
    //    connectButton.frame = CGRectMake(self.view.bounds.size.width - (20 + connectButton.bounds.size.width), notNowButton.frame.origin.y, connectButton.bounds.size.width, connectButton.bounds.size.height);
    //    [connectButton addTarget:cardsSwipingView action:@selector(dismissTopCardToRight) forControlEvents:UIControlEventTouchUpInside];
    
      
    
    
    //    adding part
    [self.view addSubview:cardsRightSwipingView];
    [self.view addSubview:cardsLeftSwipingView];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    //description
    UILabel *loremLabel = [[UILabel alloc]init];
    loremLabel.attributedText = attributedString(@"Lorem ipsum dolor sit amet, consectetur adipiscing elit?", UIColorWithHexString(@"898887"));
    loremLabel.numberOfLines = 3;
    [loremLabel setFont:[UIFont systemFontOfSize:18]];
    loremLabel.textAlignment = UITextAlignmentCenter;
    [loremLabel setCenter:CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6)];
    loremLabel.frame = CGRectMake(self.view.frame.size.width/2,self.view.frame.size.height/6,self.view.frame.size.width-60 , self.view.frame.size.height/3);
    [loremLabel setCenter:CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6+20)];
    [self.view addSubview:loremLabel];
}

- (BOOL)cardsSwipingView:(MXCardsSwipingView *)cardsSwipingView willDismissCard:(UIView *)card destination:(MXCardDestination)destination {
    if(card.tag == RightSection)
        NSLog(@"In Right Section");
    else if(card.tag == LeftSecion)
        NSLog(@"In Left Section");
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
    OnCard* leftCard = [[OnCard alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2-20 , self.view.bounds.size.height/3)];
    leftCard.tag = LeftSecion;
    [leftCard setupWithAModel:LeftSecion];
    [leftCard addShadow];
    [self.cardsLeftSwipingView enqueueCard:leftCard];
    
    OnCard* RightCard = [[OnCard alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2-20 , self.view.bounds.size.height/3)];
    RightCard.tag = RightSection;
    [RightCard setupWithAModel:RightSection];
    [RightCard addShadow];
    [self.cardsRightSwipingView enqueueCard:RightCard];
}

@end


