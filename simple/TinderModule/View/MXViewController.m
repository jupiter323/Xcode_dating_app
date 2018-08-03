//
//  MXViewController.m
//  MXCardsSwipingView
//
//  Created by Scott Kensell on 07/01/2016.
//  Copyright (c) 2016 Scott Kensell. All rights reserved.
//

#import "MXViewController.h"
#import <MXCardsSwipingView/MXCardsSwipingView.h>
#import "MXMemberCardView.h"

@interface MXViewController () <MXCardsSwipingViewDelegate>

@property (nonatomic, strong) MXCardsSwipingView* cardsSwipingView;

@end

@implementation MXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MXCardsSwipingView *cardsSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
    cardsSwipingView.delegate = self;
    self.cardsSwipingView = cardsSwipingView;
    [self addCard];
    [self addCard];
    [self addCard];
    
    UIButton *notNowButton = [[UIButton alloc] init];
    [notNowButton setTitle:@"Not Now" forState:UIControlStateNormal];
    [notNowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    notNowButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    [notNowButton sizeToFit];
    notNowButton.frame = CGRectMake(20, cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height + 12, notNowButton.bounds.size.width, notNowButton.bounds.size.height);
    [notNowButton addTarget:cardsSwipingView action:@selector(dismissTopCardToLeft) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *connectButton = [[UIButton alloc] init];
    [connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    [connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    connectButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    [connectButton sizeToFit];
    connectButton.frame = CGRectMake(self.view.bounds.size.width - (20 + connectButton.bounds.size.width), notNowButton.frame.origin.y, connectButton.bounds.size.width, connectButton.bounds.size.height);
    [connectButton addTarget:cardsSwipingView action:@selector(dismissTopCardToRight) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addConnection = [[UIButton alloc] init];
    [addConnection setImage:[UIImage imageNamed:@"AddConnection"] forState:UIControlStateNormal];
    [addConnection sizeToFit];
   
    addConnection.frame = CGRectMake(self.view.bounds.size.width - (20 + addConnection.bounds.size.width), cardsSwipingView.frame.origin.y + cardsSwipingView.frame.size.height, addConnection.bounds.size.width, addConnection.bounds.size.height);
    [addConnection addTarget:self action:@selector(addButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"newSplashBG"]];
    [self drawRect:self.view.bounds];
 
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,35)];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = view.bounds;
//    gradient.startPoint = CGPointZero;
//    gradient.endPoint = CGPointMake(1, 1);
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:34.0/255.0 green:211/255.0 blue:198/255.0 alpha:1.0] CGColor],(id)[[UIColor colorWithRed:145/255.0 green:72.0/255.0 blue:203/255.0 alpha:1.0] CGColor], nil];
//    [view.layer addSublayer:gradient];
    
//
//    [self.view addSubview:notNowButton];
//    [self.view addSubview:connectButton];
    [self.view addSubview:addConnection];
    [self.view addSubview:cardsSwipingView];

 
    
}
- (void)drawRect:(CGRect)rect {
    
    CGRect topRect = CGRectMake(0, 0, rect.size.width, rect.size.height/2.0);
    // Fill the rectangle with grey
    [[UIColor whiteColor] setFill];
    UIRectFill( topRect );
    
    CGRect bottomRect = CGRectMake(0, rect.size.height/2.0, rect.size.width, rect.size.height/2.0);
    [[UIColor redColor] setFill];
    UIRectFill( bottomRect );
    
}

- (void)addButtonTapped:(UIButton *)sender {
    NSLog(@"Ok button was tapped: dismiss the view controller.");
}


- (BOOL)cardsSwipingView:(MXCardsSwipingView *)cardsSwipingView willDismissCard:(UIView *)card toLeft:(BOOL)toLeft {
    static int i=0;
    if (++i % 5 == 0) return NO;
    [self addCard];
    return YES;
}

- (void)addCard {
    MXMemberCardView* card = [[MXMemberCardView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 40, (self.view.bounds.size.height - 200)/[MXMemberCardView aspectRatio])];
    [card setupWithAModel:nil];
    [card addShadow];
    [self.cardsSwipingView enqueueCard:card];
}

@end
