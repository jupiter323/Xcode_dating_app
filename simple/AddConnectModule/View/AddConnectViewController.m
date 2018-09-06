//
//  AddConnectViewController.m
//  Korte
//
//  Created by Peace on 8/12/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "AddConnectViewController.h"
#import "Utilities.h"

@interface AddConnectViewController (){
    int count;
    UIScrollView *matches;
    UIView *layer;
    UIView *smalllayer;
    UIButton *imageButton;
}
@property (weak, nonatomic) IBOutlet UIView *addContainView;
@property (weak, nonatomic) IBOutlet UIView *swipeForMeScroll;
@property (weak, nonatomic) IBOutlet UIView *swipeformeScrollContent;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@property (weak, nonatomic) IBOutlet UILabel *connectWithFriendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *swipeForMeLabel;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@end

@implementation AddConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.returnButton addTarget:self action:@selector(returnFun:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.s
}
-(void)returnFun:(UIButton *) sender {
    //    animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    //    navigating
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated {
    //avatars remove
    matches.removeFromSuperview;
    //remove layers
    for(UIView *subView in self.view.subviews){
        if(subView == layer || subView==smalllayer || subView==imageButton)
            [subView removeFromSuperview];
    }
    for(UIView *subView in self.addContainView.subviews){
       
            [subView removeFromSuperview];
    }
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    
    //    with friends connect
    self.connectWithFriendsLabel.attributedText = attributedString(@"Connect with Friends",StandardColor(),2.22f);
    
    //swipe for me label
    self.swipeForMeLabel.attributedText = attributedString(@"Swipe for me",StandardColor(),2.22f);
    
    //    info Button
    
    self.infoButton.backgroundColor = [UIColor colorWithRed:0.98 green:0.74 blue:0.48 alpha:1];
    self.infoButton.layer.cornerRadius = self.infoButton.frame.size.width/2;
    
    // contain circle
    
    CGFloat originX = self.view.frame.size.width/2;
    CGFloat originY = self.addContainView.frame.origin.y+self.addContainView.frame.size.height/2;
    CGFloat smallR = 81;
    CGFloat R =self.addContainView.frame.size.width/2;
    
    [self.addContainView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6]];
    self.addContainView.layer.cornerRadius= R;
    //// add friends connect
    CGFloat r = 30;
    CGFloat rSR = (R-smallR-r*2)/2;
    for(int i = 0;i<10;i++){
        i = -i;
        ////// avatar
        CGFloat x = originX+ cosf(i*M_PI/5) * (R-r-rSR) - r;
        CGFloat y = originY+ sinf(i*M_PI/5) * (R-r-rSR) - r;
        UIButton * avatar = [[UIButton alloc]init];
        avatar.frame = CGRectMake(x, y, 2*r, 2*r);
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.layer.cornerRadius = r;
        avatar.imageView.contentMode = UIViewContentModeScaleAspectFill;
        avatar.clipsToBounds = YES;
        
        ////// name
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(x+15, y-13, avatar.frame.size.width, avatar.frame.size.height)];
        name.textColor = [UIColor whiteColor];
        name.lineBreakMode = NSLineBreakByWordWrapping;
        name.numberOfLines = 0;
        name.textColor = [UIColor whiteColor];
        NSString *textContent = @"Ashley";
        NSRange textRange = NSMakeRange(0, textContent.length);
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
        UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        [textString addAttribute:NSFontAttributeName value:font range:textRange];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1.2;
        [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        name.attributedText = textString;
        [name sizeToFit];
        
        
        ////// adding delete button
        CGFloat subbuttonR = 10;
        UIButton * subCloseButton = [[UIButton alloc]init];
        subCloseButton.frame = CGRectMake(x+r+cosf((i-1)*M_PI/5)*r - subbuttonR, y+r+sinf((i-1)*M_PI/5)*r - subbuttonR, 2*subbuttonR, 2*subbuttonR);
        [subCloseButton setImage:[UIImage imageNamed:@"closeAvatar"] forState:UIControlStateNormal];
        subCloseButton.layer.cornerRadius = subbuttonR;
        subCloseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        subCloseButton.clipsToBounds = YES;
        
        
        ////// adding connect button
        CGFloat subbuttonX = x+r-cosf(i*M_PI/5)*r-subbuttonR;
        CGFloat subbuttonY = y+r-sinf(i*M_PI/5)*r-subbuttonR;
        UIButton * subConnectButton = [[UIButton alloc]init];
        subConnectButton.frame = CGRectMake(subbuttonX, subbuttonY, 2*subbuttonR, 2*subbuttonR);
        [subConnectButton setImage:[UIImage imageNamed:@"connectFriends"] forState:UIControlStateNormal];
        subConnectButton.layer.cornerRadius = subbuttonR;
        subConnectButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        subConnectButton.clipsToBounds = YES;
        
        
        //////// line
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x+r-cosf(i*M_PI/5)*r, y+r-sinf(i*M_PI/5)*r)];
        [path addLineToPoint:CGPointMake(x+r-cosf(i*M_PI/5)*r - ((rSR-3)*cosf(i*M_PI/5)), y+r-sinf(i*M_PI/5)*r- ((rSR-3)*sinf(i*M_PI/5)))];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 4.0;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        shapeLayer.cornerRadius = 2;
        
        
        ////// percentage show view
        UIView *percentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*r, 2*r)];
        [percentView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        UILabel *textLayer = [[UILabel alloc] initWithFrame:percentView.frame];
        textLayer.textColor = [UIColor colorWithRed:0.92 green:0.91 blue:0.91 alpha:1];
        textLayer.textAlignment = UITextAlignmentCenter;
        textLayer.text = @"50%";
        [percentView addSubview:textLayer];
        
        
        ////// tap to connect button
        UIButton *tapToButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 2*r, 2*r)];
        [tapToButton setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
        UILabel *tapTotextLayer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2*r, r)];
        tapTotextLayer.textColor = [UIColor grayColor];
        tapTotextLayer.textAlignment = UITextAlignmentCenter;
        tapTotextLayer.text = @"Tap to connect";
        tapTotextLayer.numberOfLines = 2;
        [tapTotextLayer setFont:[UIFont systemFontOfSize:10]];
        
        UILabel *expireTextLayer = [[UILabel alloc] initWithFrame:CGRectMake(8, r-5, 2*r-16, r)];
        expireTextLayer.textColor = [UIColor colorWithRed:0.82 green:0.02 blue:0.02 alpha:1];
        expireTextLayer.textAlignment = UITextAlignmentCenter;
        expireTextLayer.text = @"Expires in 24 HRS";
        expireTextLayer.numberOfLines = 2;
        [expireTextLayer setFont:[UIFont systemFontOfSize:7]];
        
        [tapToButton addSubview:tapTotextLayer];
        [tapToButton addSubview:expireTextLayer];
        
      
        
        i=-i;
        switch (i) {
            case 0://////adding connect button
                [self.view addSubview: avatar];
                [avatar setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
               
//                avatar.layer.frame = CGRectMake(0, 0, 2*r, 2*r);
                avatar.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.17].CGColor;
                avatar.layer.borderWidth = 2;
                avatar.layer.borderColor = [[UIColor whiteColor] CGColor];
                avatar.layer.cornerRadius = r;
                [avatar addTarget:self action:@selector(goToMeSwiping:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [self.view addSubview: avatar];
                [[self view] addSubview:name];
                [avatar addSubview:percentView];
                break;
            case 2:
                [self.view addSubview: avatar];
                [[self view] addSubview:name];
                [self.view.layer addSublayer:shapeLayer];
                [self.view addSubview: subConnectButton];
                break;
            case 3:
                [self.view addSubview: avatar];
                [[self view] addSubview:name];
                [self.view addSubview:subCloseButton];
                [self.view.layer addSublayer:shapeLayer];
                [self.view addSubview: subConnectButton];
                break;
            case 4:
                [self.view addSubview: avatar];
                [[self view] addSubview:name];
                [avatar addSubview:tapToButton];
                break;
            default:
                break;
        }
        
        
        
    }
    
    
    //// add small contain collect view
    
    layer = [[UIView alloc] initWithFrame:CGRectMake(originX-smallR, originY-smallR, smallR*2, smallR*2)];
    layer.backgroundColor = [UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6];
    layer.layer.cornerRadius = smallR;
    //////add the smallest contain collect view
    smalllayer = [[UIView alloc] initWithFrame:CGRectMake(originX-55, originY-55, 110, 110)];
    smalllayer.backgroundColor = [UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6];
    smalllayer.layer.cornerRadius = 55;
    ////////image button
    imageButton = [[UIButton alloc] initWithFrame:CGRectMake(originX-30, originY-30, 60, 60)];
    [imageButton setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    imageButton.layer.cornerRadius = 30;
    imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageButton.clipsToBounds = YES;
    
    [[self view] addSubview:layer];
    [[self view] addSubview:smalllayer];
    [[self view] addSubview:imageButton];
    
    
    //    swipe for me scroll adding
    matches = [[UIScrollView alloc] init];
    [self.swipeForMeScroll setBackgroundColor:UIColorWithHexString(@"#f4f2f2")];
    CGFloat marginLeft = 80;
    CGFloat ContentScrollHeight = self.swipeformeScrollContent.frame.size.height;
    CGFloat ContentScrollWidth = self.swipeformeScrollContent.frame.size.width-marginLeft;
    CGFloat avatarWidth = 70;
    matches.frame = CGRectMake(marginLeft,ContentScrollHeight-avatarWidth-10 , ContentScrollWidth, avatarWidth+10);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*(avatarWidth+10)+10, avatarWidth+10);
    
    ////    adding add matches button
    CGFloat buttonWidth = avatarWidth;
    UIButton *addMatchButton = [[UIButton alloc] init];
    addMatchButton.frame = CGRectMake(10,ContentScrollHeight-avatarWidth-10,buttonWidth,buttonWidth);
    [addMatchButton setImage:[UIImage imageNamed:@"swipadd"] forState:UIControlStateNormal];
    [addMatchButton addTarget:self action:@selector(goToGettingFriendsSwiping:) forControlEvents:UIControlEventTouchUpInside];
    addMatchButton.layer.cornerRadius = addMatchButton.frame.size.width / 2;
    addMatchButton.clipsToBounds = YES;
    [self.swipeformeScrollContent addSubview:addMatchButton];
    
    
    ////scroll
    for(int i=0;i<sizeOfMatches;i++){
        CGFloat buttonSide = 10;
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+10,0 , buttonWidth, buttonWidth);
        
        
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        avatar.tag = i;
        
        [avatar addTarget:self action:@selector(goToFriendsSwiping:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        [matches addSubview:avatar];
        
        //////avatar's subbutton
        CGFloat subbuttonWidth = 18;
        UIButton * closeLeftTopButton=[[UIButton alloc] init];
        closeLeftTopButton.frame=CGRectMake(avatar.frame.origin.x,avatar.frame.origin.y, subbuttonWidth, subbuttonWidth);
        [closeLeftTopButton setImage:[UIImage imageNamed:@"closeAvatar"] forState:UIControlStateNormal];
        if(i==0)
            [matches addSubview:closeLeftTopButton];
        
        UIButton * closeLeftBottomButton=[[UIButton alloc] init];
        closeLeftBottomButton.frame=CGRectMake(avatar.frame.origin.x,avatar.frame.origin.y+ avatarWidth - subbuttonWidth, subbuttonWidth, subbuttonWidth);
        [closeLeftBottomButton setImage:[UIImage imageNamed:@"closeLeftBottom"] forState:UIControlStateNormal];
        if(i!=0)
            [matches addSubview:closeLeftBottomButton];
        
        UIButton * closeRightBottomButton=[[UIButton alloc] init];
        closeRightBottomButton.frame=CGRectMake(avatar.frame.origin.x+avatarWidth-subbuttonWidth,avatar.frame.origin.y+avatarWidth - subbuttonWidth, subbuttonWidth, subbuttonWidth);
        [closeRightBottomButton setImage:[UIImage imageNamed:@"connectRightBottom"] forState:UIControlStateNormal];
        if(i!=0)
            [matches addSubview:closeRightBottomButton];
        
        ////// name
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x , avatarWidth , avatarWidth, 10)];
        name.textColor = [UIColor grayColor];
        name.textAlignment = UITextAlignmentCenter;
        name.text = @"Reema";
        name.numberOfLines = 2;
        [name setFont:[UIFont systemFontOfSize:10]];
        [matches addSubview:name];
        
        
        
    }
    matches.showsHorizontalScrollIndicator = NO;
    [self.swipeformeScrollContent addSubview:matches];
    [self.swipeformeScrollContent setBackgroundColor:UIColorWithHexString(@"#f4f2f2")];
    //
    
}
//

-(void)goToMeSwiping:(UIButton *)sender{
    //    animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    // //   navigating
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GettingForMeSwiping" bundle:nil];
    UINavigationController *addingFriendScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idGettingForMeSwiping"];
    
    [self.navigationController pushViewController:addingFriendScene animated:NO];
}
-(void)goToGettingFriendsSwiping:(UIButton *)sender{
    //    animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    // //   navigating
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GettingForFriendSwiping" bundle:nil];
    UINavigationController *addingFriendScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idGettingForFriendSwiping"];
    
    [self.navigationController pushViewController:addingFriendScene animated:NO];
}
-(void)goToFriendsSwiping:(UIButton *)sender{
    NSLog(@"match button tag: %d",sender.tag);
    
    // //   navigating
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AddingFriend" bundle:nil];
    UINavigationController *addingFriendScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idAddingFriend"];
    
    [self.navigationController pushViewController:addingFriendScene animated:YES];
    
    
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



