//
//  MeQuestionViewController.m
//  Korte
//
//  Created by Peace on 9/17/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "MeQuestionViewController.h"

@interface MeQuestionViewController (){
    
    
    MXCardsSwipingView* cardsLeftSwipingView;
    MXCardsSwipingView* cardsRightSwipingView;
    int i;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation MeQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    i=0;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
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
    
    ////   question card views adding
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
    [self.mainView addSubview:swipConent];
    [self addCard];
    

}
-(void)viewWillDisappear:(BOOL)animated{
    for(UIView *subViews in self.mainView.subviews){
        [subViews removeFromSuperview];
    }
    i=0;
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
    
    if (++i % 2 == 0) {
        //////removing super's button(status of page)
        delay(0.3, ^{
            // return
            [self returnFun];
          
        });
        
        //        return NO;
    }
    return YES;
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
