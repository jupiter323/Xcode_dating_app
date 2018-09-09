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
    CGFloat R;
    CGFloat r;
}
@property (weak, nonatomic) IBOutlet UIView *addContainView;
@property (weak, nonatomic) IBOutlet UIView *swipeForMeScroll;
@property (weak, nonatomic) IBOutlet UIView *swipeformeScrollContent;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@property (weak, nonatomic) IBOutlet UILabel *connectWithFriendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *swipeForMeLabel;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
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
 
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"friendCell";
    int i = -indexPath.item;
    r=30;
    R =self.addContainView.frame.size.width/2;
    CGFloat smallR = 81;
    CGFloat rSR = (R-smallR-r*2)/2;
    CGFloat originX = self.view.frame.size.width/2;
    CGFloat originY = self.addContainView.frame.origin.y+self.addContainView.frame.size.height/2;
    CGFloat offsetX = -(originX+ cosf(i*M_PI/5) * (R-r-rSR)-2*r);
    CGFloat offsetY = -(originY+ sinf(i*M_PI/5) * (R-r-rSR)-2*r);
    
    CGFloat x = originX+ cosf(i*M_PI/5) * (R-r-rSR) - r;
    CGFloat y = originY+ sinf(i*M_PI/5) * (R-r-rSR) - r;
    FriendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.avatar.frame = CGRectMake(x+offsetX, y+offsetY, 2*r, 2*r);
    [cell.avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    cell.avatar.layer.cornerRadius = 30;
    cell.avatar.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.avatar.clipsToBounds = YES;
    
    ////// adding delete button
    CGFloat subbuttonR = 10;
    x =x+r+cosf((i-1)*M_PI/5)*r - subbuttonR;
    y =y+r+sinf((i-1)*M_PI/5)*r - subbuttonR;
    cell.subCloseButton.frame = CGRectMake(x+offsetX,y+offsetY , 2*subbuttonR, 2*subbuttonR);
    [cell.subCloseButton setImage:[UIImage imageNamed:@"closeAvatar"] forState:UIControlStateNormal];
    cell.subCloseButton.layer.cornerRadius = subbuttonR;
    cell.subCloseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.subCloseButton.clipsToBounds = YES;   
    
    ////// name
    x =originX+ cosf(i*M_PI/5) * (R-r-rSR) - r ;
    y = originY+ sinf(i*M_PI/5) * (R-r-rSR) - r -16;
    cell.name.frame =  CGRectMake(x+offsetX, y+offsetY, cell.avatar.frame.size.width, 11);
    cell.name.textColor = [UIColor whiteColor];
    cell.name.lineBreakMode = NSLineBreakByWordWrapping;
    cell.name.numberOfLines = 0;
    cell.name.textColor = [UIColor whiteColor];
    NSString *textContent = @"Ashley";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Bold" size:11];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.2;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    cell.name.attributedText = textString;

    
    ////// adding connect button
    x = originX+ cosf(i*M_PI/5) * (R-r-rSR) - r;
    y = originY+ sinf(i*M_PI/5) * (R-r-rSR) - r;
    CGFloat subbuttonX = x+r-cosf(i*M_PI/5)*r-subbuttonR;
    CGFloat subbuttonY = y+r-sinf(i*M_PI/5)*r-subbuttonR;
 
    cell.subConnectButton.frame = CGRectMake(subbuttonX+offsetX, subbuttonY+offsetY, 2*subbuttonR, 2*subbuttonR);
    [cell.subConnectButton setImage:[UIImage imageNamed:@"connectFriends"] forState:UIControlStateNormal];
    cell.subConnectButton.layer.cornerRadius = subbuttonR;
    cell.subConnectButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.subConnectButton.clipsToBounds = YES;
    
    //////// line
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(x+r-cosf(i*M_PI/5)*(r+subbuttonR), y+r-sinf(i*M_PI/5)*(r+subbuttonR))];
    [path addLineToPoint:CGPointMake(x+r-cosf(i*M_PI/5)*r - ((rSR-3)*cosf(i*M_PI/5)), y+r-sinf(i*M_PI/5)*r- ((rSR-3)*sinf(i*M_PI/5)))];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 4.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.cornerRadius = 2;
  
    
    
    ////// percentage show view
    cell.percentView.frame = CGRectMake(0, 0, 2*r, 2*r);
    [cell.percentView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UILabel *textLayer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2*r, 2*r)];
    textLayer.textColor = [UIColor colorWithRed:0.92 green:0.91 blue:0.91 alpha:1];
    textLayer.textAlignment = UITextAlignmentCenter;
    textLayer.text = @"50%";
    [cell.percentView addSubview:textLayer];
    
    ////// tap to connect button
    cell.tapToButton.frame = CGRectMake(0, 0, 2*r, 2*r);
    [cell.tapToButton setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    UILabel *tapTotextLayer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2*r, r)];
    tapTotextLayer.textColor = [UIColor grayColor];
    tapTotextLayer.textAlignment = UITextAlignmentCenter;
    tapTotextLayer.text = @"Tap to connect";
    tapTotextLayer.numberOfLines = 2;
    [tapTotextLayer setFont:[UIFont systemFontOfSize:10]];
    
    UILabel *expireTextLayer = [[UILabel alloc] initWithFrame:CGRectMake(0+8,0+ r-5, 2*r-16, r)];
    expireTextLayer.textColor = [UIColor colorWithRed:0.82 green:0.02 blue:0.02 alpha:1];
    expireTextLayer.textAlignment = UITextAlignmentCenter;
    expireTextLayer.text = @"Expires in 24 HRS";
    expireTextLayer.numberOfLines = 2;
    [expireTextLayer setFont:[UIFont systemFontOfSize:7]];
    
    [cell.tapToButton addSubview:tapTotextLayer];
    [cell.tapToButton addSubview:expireTextLayer];
  
    switch (-i) {
        case 0:
            cell.status = AddingConnectButton;
            break;
            
        case 1:
            cell.status = LoadingState;
            break;
            
        case 2:
            cell.status = LoadedState;
            [self.view.layer addSublayer:shapeLayer];
            break;
        case 3:
            cell.status = LoadedState;
            [self.view.layer addSublayer:shapeLayer];
            break;
        case 4:
            cell.status = LoadedState;
            [self.view.layer addSublayer:shapeLayer];
            break;
        case 5:
            cell.status = LoadedState;
            [self.view.layer addSublayer:shapeLayer];
            break;
        case 6:
            cell.status = LoadedState;
            [self.view.layer addSublayer:shapeLayer];
            break;
        case 7:
            cell.status = TapToConnectState;
            break;
        case 8:
            cell.status = TapToConnectState;
            break;
        
        default:
            cell.status = DisappearedState;
            break;
    }
    
    [cell dataConfig];
    
    
    return cell;
}


- (void)viewDidAppear:(BOOL)animated{
    //collection layout
    R =self.addContainView.frame.size.width/2;
    r = 30;

    DSCircularLayout *circularLayout = [[DSCircularLayout alloc] init];
    [circularLayout initWithCentre:CGPointMake(0, 0)
                            radius:R
                          itemSize:CGSizeMake(2*r, 2*r)
                 andAngularSpacing:20];
    circularLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.collectionView setCollectionViewLayout:circularLayout];
    
    
   
    //    with friends connect
    self.connectWithFriendsLabel.numberOfLines = 2;
    self.connectWithFriendsLabel.textColor = [UIColor colorWithRed:0.93 green:0.49 blue:0.41 alpha:1];
   
    NSString *textContent = @"   Connect with Friends";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:20];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [textString addAttribute:NSKernAttributeName value:@(2.22) range:textRange];
    self.connectWithFriendsLabel.attributedText = textString;

  
    
    //swipe for me label
    self.swipeForMeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.swipeForMeLabel.numberOfLines = 0;
    self.swipeForMeLabel.textColor = [UIColor colorWithRed:0.8 green:0.45 blue:0.39 alpha:1];
    self.swipeForMeLabel.textAlignment = NSTextAlignmentCenter;
    textContent = @"Swipe for me";
    textRange = NSMakeRange(0, textContent.length);
    textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    font = [UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [textString addAttribute:NSKernAttributeName value:@(2.22) range:textRange];
    self.swipeForMeLabel.attributedText = textString;
    [self.swipeForMeLabel sizeToFit];
    
    
    //    info Button
    
    self.infoButton.backgroundColor = [UIColor colorWithRed:0.98 green:0.74 blue:0.48 alpha:1];
    self.infoButton.layer.cornerRadius = self.infoButton.frame.size.width/2;
    
    // collection circle
    
    CGFloat originX = self.view.frame.size.width/2;
    CGFloat originY = self.addContainView.frame.origin.y+self.addContainView.frame.size.height/2;
    CGFloat smallR = 81;
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6]];
    self.collectionView.layer.cornerRadius= R;
  
    
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
    
    CGFloat buttonSide = 24;
    CGFloat avatarWidth = 85;
    CGFloat marginLeft = buttonSide + avatarWidth;
    CGFloat ContentScrollHeight = self.swipeformeScrollContent.frame.size.height;
    CGFloat ContentScrollWidth = self.swipeformeScrollContent.frame.size.width-marginLeft;
    
    matches.frame = CGRectMake(marginLeft,0, ContentScrollWidth, ContentScrollHeight);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*(avatarWidth+buttonSide)+buttonSide, ContentScrollHeight);
    
    ////    adding add matches button
    CGFloat buttonWidth = avatarWidth;
    UIButton *addMatchButton = [[UIButton alloc] init];
    addMatchButton.frame = CGRectMake(buttonSide,0,buttonWidth,buttonWidth);
    [addMatchButton setImage:[UIImage imageNamed:@"swipadd"] forState:UIControlStateNormal];
    [addMatchButton addTarget:self action:@selector(goToGettingFriendsSwiping:) forControlEvents:UIControlEventTouchUpInside];
    addMatchButton.layer.cornerRadius = addMatchButton.frame.size.width / 2;
    addMatchButton.clipsToBounds = YES;
    addMatchButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.swipeformeScrollContent addSubview:addMatchButton];
    
    
    ////scroll
    for(int i=0;i<sizeOfMatches;i++){
        
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+buttonSide,0 , buttonWidth, buttonWidth);
        
        
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        avatar.tag = i;
        
        [avatar addTarget:self action:@selector(goToFriendsSwiping:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        [matches addSubview:avatar];
        
        //////avatar's subbutton
        CGFloat subbuttonWidth = 21;
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
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(avatar.frame.origin.x , avatarWidth+5 , avatarWidth, 12)];
        name.lineBreakMode = NSLineBreakByWordWrapping;
        name.numberOfLines = 0;
        name.textColor = [UIColor colorWithRed:0.42 green:0.4 blue:0.4 alpha:1];
        textContent = @"Sonali";
        textRange = NSMakeRange(0, textContent.length);
        textString = [[NSMutableAttributedString alloc] initWithString:textContent];
        font = [UIFont fontWithName:@"GothamRounded-Medium" size:12];
        [textString addAttribute:NSFontAttributeName value:font range:textRange];
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1.17;
         [paragraphStyle setAlignment:NSTextAlignmentCenter];        [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        name.attributedText = textString;
        [matches addSubview:name];
    }
    matches.showsHorizontalScrollIndicator = NO;
    [self.swipeformeScrollContent addSubview:matches];
    [self.swipeformeScrollContent setBackgroundColor:UIColorWithHexString(@"#f4f2f2")];
    //
    
}
//
-(void)avatarClicked:(UIButton *)sender{
    NSLog(@"first cliced");
  
}
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



