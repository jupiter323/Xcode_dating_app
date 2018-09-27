//
//  MXViewController.m
//  MXCardsSwipingView
//
//  Created by Scott Kensell on 07/01/2018.
//  Copyright (c) 2018 Scott Kensell. All rights reserved.
//

#import "MXViewController.h"
#import "MXCardsSwipingView.h"
#import "MXMemberCardView.h"

@interface MXViewController () <MXCardsSwipingViewDelegate>{
    CGFloat cardWidth;
    CGFloat cardRatio;
    int forQuesCount;


}

@property (nonatomic, strong) MXCardsSwipingView* cardsSwipingView;

@end

@implementation MXViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad]; 
    
    forQuesCount = 0;
    themKind = ProTheme;
    cardWidth = self.view.bounds.size.width - 38*2;
    cardRatio = 299.88/466.48;
    MXCardsSwipingView *cardsSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(38, 82, cardWidth, cardWidth / cardRatio)];
    cardsSwipingView.delegate = self;
    self.cardsSwipingView = cardsSwipingView;
    [self addCard];
    [self addCard];
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
    CGFloat profileWidth = 62 -9.03*2;
    UIButton *myProfile = [[UIButton alloc] init];
    myProfile.frame = CGRectMake(self.view.bounds.size.width/2-profileWidth/2, self.view.bounds.size.height - 72 +9.03 , profileWidth,profileWidth);
    [myProfile setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    myProfile.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [myProfile addTarget:self action:@selector(toProfile:) forControlEvents:UIControlEventTouchUpInside];
    myProfile.layer.cornerRadius = myProfile.frame.size.width / 2;
    myProfile.clipsToBounds = YES;
    
    UIView *forBorder = [[UIView alloc] init];
    forBorder.frame = CGRectMake(self.view.bounds.size.width/2-profileWidth/2-9.03, self.view.bounds.size.height - 72 , profileWidth+9.03*2,profileWidth+9.03*2);
    [forBorder setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:forBorder];
    forBorder.layer.cornerRadius = forBorder.frame.size.width / 2;
   
    //    adding part 
    [self.view addSubview:myProfile];
    [self.view addSubview:cardsSwipingView];
  
    
    
}
- (BOOL)cardsSwipingView:(MXCardsSwipingView *)cardsSwipingView willDismissCard:(UIView *)card destination:(MXCardDestination)destination {
  
    switch (destination) {
        case MXCardDestinationRight:
            forQuesCount = random()%3;
            if(forQuesCount ==2){
                NSLog(@"question appeared");
                [self appearQuestion];
            }
            NSLog(@"right");
            break;
        case MXCardDestinationLeft:
            
            forQuesCount = random()%3;
            if(forQuesCount ==2){
                NSLog(@"question appeared");
                [self appearQuestion];
            }
            NSLog(@"left");
            break;
        case MXCardDestinationUp:
            forQuesCount = random()%3;
            if(forQuesCount ==2){
                NSLog(@"question appeared");
                [self appearQuestion];
            }
            NSLog(@"up");
            break;
            
        default:
            break;
    }
 
    
    static int i=0;
    if (++i % 5 == 0) return NO;
    [self addCard];
    return YES;
}
-(void)appearQuestion{
    [self navAnimating:kCATransitionFade subtype:kCATransitionFromTop];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MeQuestion" bundle:nil];
    UINavigationController *mProfileScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idMeQuestion"];
    
    [self.navigationController pushViewController:mProfileScene animated:NO];
}
- (void)addCard {
    MXMemberCardView* card = [[MXMemberCardView alloc] initWithFrame:CGRectMake(0, 0, cardWidth, cardWidth/cardRatio)];
    [card setupWithAModel:nil];
//    [card addShadow];
    [self.cardsSwipingView enqueueCard:card];
}

@end
