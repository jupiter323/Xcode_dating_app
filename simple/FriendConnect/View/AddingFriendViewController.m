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

@interface AddingFriendViewController () <MXCardsSwipingViewDelegate>{
    MXCardsSwipingView* cardsLeftSwipingView;
    MXCardsSwipingView* cardsRightSwipingView;
    MXCardsSwipingView* cardsSwipingView;
    UIView *leftView;
    UIView *rightView;
    UIView *centerView;
    UIView *bottomView;
    UIView *layer;
    UIScrollView * forBottomScrollView;
    CGFloat cardWidth;
    CGFloat cardRatio;
}


@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation AddingFriendViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    for(UIView * subViews in self.pageScrollView.subviews){
        subViews.removeFromSuperview;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    //    scroll
    CGFloat width = self.pageScrollView.frame.size.width;
    CGFloat height = self.pageScrollView.frame.size.height;
    cardWidth = self.view.bounds.size.width - 38*2;
    cardRatio = 299.88/466.48;
    
    ////slide pages
    //////
    leftView = [[UIView alloc] init];
    rightView = [[UIView alloc] init];
    centerView = [[UIView alloc] init];
    bottomView = [[UIView alloc] init];
    
    leftView.frame = CGRectMake(0, 0, width,height);
    centerView.frame = CGRectMake(width, 0, width,height);
    rightView.frame = CGRectMake(2*width, 0, width,height);
    bottomView.frame = CGRectMake(0, height, width,height);
    
    
    
    ////content size
    self.pageScrollView.contentSize = CGSizeMake(width*3, height);
    self.pageScrollView.delegate = self;
    
    [self.pageScrollView addSubview:leftView];
    [self.pageScrollView addSubview:centerView];
    [self.pageScrollView addSubview:rightView];
    
    
    
    //scroll for bottom
    forBottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    forBottomScrollView.showsVerticalScrollIndicator = NO;
    forBottomScrollView.pagingEnabled = YES;
    ////center top view
    UIView *centerTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    layer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    //////centertopview background
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.frame;
    gradient.colors = @[
                        (id)[[UIColor colorWithRed:0.98 green:0.49 blue:0.38 alpha:1] CGColor],
                        (id)[[UIColor colorWithRed:0.85 green:0.49 blue:0.45 alpha:1] CGColor]
                        ];
    gradient.locations = @[@(0), @(1)];
    gradient.startPoint = CGPointMake(0.5, 0);
    gradient.endPoint = CGPointMake(0.5, 0.98);
    [[layer layer] addSublayer:gradient];
    [centerTopView insertSubview:layer atIndex:0];
    
    //////adding card to centertopview

    cardsSwipingView = [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(38, 119, cardWidth, cardWidth / cardRatio)];
    UIView *coverCard = [[UIView alloc]initWithFrame:CGRectMake(38, 119, cardWidth, cardWidth / cardRatio)];
    
    cardsSwipingView.delegate = self;
    OnCard* card = [[OnCard alloc] initWithFrame:CGRectMake(0, 0, cardWidth, cardWidth / cardRatio)];
    [card setup:Center];
    [card setupWithAModel:Center];
//    [card addShadow];
    [cardsSwipingView enqueueCard:card];
    
    [centerTopView addSubview:cardsSwipingView];
    [centerTopView addSubview:coverCard];
    /////// return button on centertopview
    self.returnButton = [[UIButton alloc] init];
    [self.returnButton setImage:[UIImage imageNamed:@"pro_close"] forState:UIControlStateNormal];
    [self.returnButton sizeToFit];
    self.returnButton.frame = CGRectMake(20,20, self.returnButton.bounds.size.width, self.returnButton.bounds.size.height);
    [self.returnButton addTarget:self action:@selector(returnFun:) forControlEvents:UIControlEventTouchUpInside];
    [centerTopView addSubview:self.returnButton];
    /////// avatar on entertopview
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(width/2-30, 30, 45, 45)];
    [imageButton setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    imageButton.layer.cornerRadius = 45/2;
    imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageButton.clipsToBounds = YES;
    [centerTopView addSubview:imageButton];
    
    //////removing super's button(status of page)
    [self initStatusOfPage];
    //adding three card
    [self threeViewCard];
    [forBottomScrollView setContentSize:CGSizeMake(width, 2*height)];
    forBottomScrollView.delegate = self;
    forBottomScrollView.tag = 1;
    [forBottomScrollView addSubview:bottomView];
    [forBottomScrollView addSubview:centerTopView];
    [centerView addSubview:forBottomScrollView];
    
    //for template
    bottomView.removeFromSuperview;
    forBottomScrollView.contentSize = CGSizeMake(width, height);
    
}

-(void) threeViewCard{
    //    scroll
    CGFloat width = self.pageScrollView.frame.size.width;
    CGFloat height = self.pageScrollView.frame.size.height;
    //swipe adding to scroll views
    for(int i=0;i<3;i++){
        // swip content
        UIView *swipConent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
        
        ////description
        UILabel *loremLabel = [[UILabel alloc]init];
        loremLabel.attributedText = attributedString(@"Lorem ipsum dolor sit amet, consectetur adipiscing elit?", UIColorWithHexString(@"898887"), 2.22f);
        loremLabel.numberOfLines = 3;
        [loremLabel setFont:[UIFont systemFontOfSize:18]];
        loremLabel.textAlignment = UITextAlignmentCenter;
        [loremLabel setCenter:CGPointMake(width/2,height/6)];
        loremLabel.frame = CGRectMake(width/2,height/6,width-60 , height/3);
        [loremLabel setCenter:CGPointMake(width/2,height/6+20)];
        
        
        [swipConent addSubview:loremLabel];
        
        ////    card views adding
        MXCardsSwipingView * lefttempcards;
        MXCardsSwipingView * righttempcards;
        lefttempcards= [[MXCardsSwipingView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/3, self.view.bounds.size.width/2, self.view.bounds.size.height/3)];
        
        
        righttempcards=[[MXCardsSwipingView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/3, self.view.bounds.size.width/2, self.view.bounds.size.height/3)];
        cardsRightSwipingView = righttempcards;
        cardsRightSwipingView.delegate = self;
        cardsLeftSwipingView = lefttempcards;
        cardsLeftSwipingView.delegate = self;
        [swipConent addSubview:cardsRightSwipingView];
        [swipConent addSubview:cardsLeftSwipingView];
        switch (i) {
            case 0:
                
                [rightView addSubview:swipConent];
                break;
            case 1:
                
                [leftView addSubview:swipConent];
                break;
            case 2:
                [bottomView addSubview:swipConent];
                break;
            default:
                [leftView addSubview:swipConent];
                break;
        }
        [self addCard];
        
    }
    
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.tag==1){
        NSLog(@"vertical");
        CGFloat pageHeight = scrollView.frame.size.height;
        int currentPage = (int)floor((scrollView.contentOffset.y-pageHeight/2)/pageHeight)+1;
        
        if(currentPage == 1){
            [scrollView setContentOffset:CGPointMake(0, scrollView.frame.size.height) animated:YES];
            scrollView.scrollEnabled = NO;
            self.pageScrollView.scrollEnabled = NO;
            self.notificationButton.hidden = NO;
            self.messageButton.hidden = NO;
            self.addConnection.hidden = NO;
            self.bottom.hidden = NO;
            self.myProfile.hidden = NO;
            layer.hidden = YES;
            
        }
        else
           [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else{
        // Test the offset and calculate the current page after scrolling ends
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = (int)floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
        // Change the indicator
        self.pageControl.currentPage = currentPage;
        if(currentPage!=1){
            scrollView.scrollEnabled = NO;
            self.pageScrollView.scrollEnabled = NO;
            self.notificationButton.hidden = NO;
            self.messageButton.hidden = NO;
            self.addConnection.hidden = NO;
            self.bottom.hidden = NO;
            self.myProfile.hidden = NO;            
        }
        
        // Change the text accordingly
    }
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
    
    if (++i % 2 == 0) {
        //////removing super's button(status of page)
        delay(0.3, ^{
            [self initStatusOfPage];
            self->leftView.subviews[0].removeFromSuperview;
            self->bottomView.subviews[0].removeFromSuperview;
            self->rightView.subviews[0].removeFromSuperview;
            [self threeViewCard];
        });
        
//        return NO;
    }
    return YES;
}
-(void)initStatusOfPage{
    self.notificationButton.hidden = YES;
    self.messageButton.hidden = YES;
    self.addConnection.hidden = YES;
    self.bottom.hidden = YES;
    self.myProfile.hidden = YES;
    self.pageScrollView.scrollEnabled = YES;
    forBottomScrollView.scrollEnabled = YES;
    self.pageControl.currentPage = 1;
    [self.pageScrollView setContentOffset:CGPointMake(centerView.frame.size.width, 0) animated:NO];
    [forBottomScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    layer.hidden = NO;
}
- (void)addCard {
    OnCard* leftCard = [[OnCard alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2-20 , self.view.bounds.size.height/3)];
    [leftCard setup:LeftSecion];
    leftCard.tag = LeftSecion;
    [leftCard setupWithAModel:LeftSecion];
    [leftCard addShadow];
    [cardsLeftSwipingView enqueueCard:leftCard];
    
    OnCard* RightCard = [[OnCard alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2-20 , self.view.bounds.size.height/3)];
    [RightCard setup:RightSection];
    RightCard.tag = RightSection;
    [RightCard setupWithAModel:RightSection];
    [RightCard addShadow];
    [cardsRightSwipingView enqueueCard:RightCard];
    
}

@end




