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
    
    __weak IBOutlet UICollectionView *cooll;
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
    
    ////    init friend views
    count = 0;
    [self setCircularLayout];
    // Do any additional setup after loading the view.s
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
    //remove collection
    cooll.removeFromSuperview;
}
- (void)viewDidAppear:(BOOL)animated{
    
    
    //    with friends connect
    self.connectWithFriendsLabel.attributedText = attributedString(@"Connect with Friends",StandardColor());
    
    //swipe for me label
    self.swipeForMeLabel.attributedText = attributedString(@"Swipe for me",StandardColor());
    
    //    info Button
    
    self.infoButton.backgroundColor = [UIColor colorWithRed:0.98 green:0.74 blue:0.48 alpha:1];
    self.infoButton.layer.cornerRadius = self.infoButton.frame.size.width/2;
    // add contain collect View
    
    [cooll setBackgroundColor:[UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6]];
    cooll.layer.cornerRadius= self.addContainView.frame.size.height/2;
    //// add small contain collect view
    CGFloat originX = self.view.frame.size.width/2;
    CGFloat originY = self.addContainView.frame.origin.y+self.addContainView.frame.size.height/2;
    layer = [[UIView alloc] initWithFrame:CGRectMake(originX-81, originY-81, 162, 162)];
    layer.backgroundColor = [UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6];
    layer.layer.cornerRadius = 81;
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
    
    
    //    add friend views
    
    
    
//    static BOOL flagForCollect = YES;
//
//    if(flagForCollect)
    [cooll performBatchUpdates:^{
        [cooll insertItemsAtIndexPaths:[NSArray arrayWithObjects:
                                                      [NSIndexPath indexPathForRow:0 inSection:0],
                                                      [NSIndexPath indexPathForRow:1 inSection:0],
                                                      [NSIndexPath indexPathForRow:2 inSection:0],
                                                      [NSIndexPath indexPathForRow:3 inSection:0],
                                                      [NSIndexPath indexPathForRow:4 inSection:0],
                                        
                                                      nil]];
        self->count = 5;
    } completion:^(BOOL finished) {
        [cooll reloadData];
    }];
//    flagForCollect = NO;
    
    
    //    swipe for me scroll adding
    matches = [[UIScrollView alloc] init];
    [self.swipeForMeScroll setBackgroundColor:UIColorWithHexString(@"#f4f2f2")];
    CGFloat marginLeft = 0;
    CGFloat ContentScrollHeight = self.swipeformeScrollContent.frame.size.height;
    CGFloat ContentScrollWidth = self.swipeformeScrollContent.frame.size.width;
    CGFloat avatarWidth = 70;
    matches.frame = CGRectMake(marginLeft,ContentScrollHeight-avatarWidth-10 , ContentScrollWidth, avatarWidth);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*(avatarWidth+10)+10, avatarWidth);
    for(int i=0;i<sizeOfMatches;i++){
        CGFloat buttonWidth = avatarWidth;
        CGFloat buttonSide = 10;
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+10,0 , buttonWidth, buttonWidth);
        if(i==0)
            [avatar setImage:[UIImage imageNamed:@"swipadd"] forState:UIControlStateNormal];
        else
            [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        avatar.tag = i;
        if(i==0)
            [avatar addTarget:self action:@selector(goToGettingFriendsSwiping:) forControlEvents:UIControlEventTouchUpInside];
            else
        [avatar addTarget:self action:@selector(goToFriendsSwiping:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        
       
        
        [matches addSubview:avatar];
    }
    matches.showsHorizontalScrollIndicator = NO;
    [self.swipeformeScrollContent addSubview:matches];
    [self.swipeformeScrollContent setBackgroundColor:UIColorWithHexString(@"#f4f2f2")];
    //
    
}
//

-(void)setCircularLayout{
    CGFloat SCREEN_HEIGHT = cooll.frame.size.height;
    CGFloat SCREEN_WIDTH = SCREEN_HEIGHT;
    CGFloat ITEM_WIDTH = 60;
    CGFloat ITEM_HEIGHT = 60;
    
    DSCircularLayout *circularLayout = [[DSCircularLayout alloc] init];
    [circularLayout initWithCentre:CGPointMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-25)
                            radius:SCREEN_WIDTH/2 -ITEM_WIDTH *1.3
                          itemSize:CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT)
                 andAngularSpacing:60];
    [circularLayout setStartAngle:M_PI endAngle:0];
    circularLayout.mirrorX = NO;
    circularLayout.mirrorY = NO;
    circularLayout.rotateItems = NO;
    circularLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [cooll setCollectionViewLayout:circularLayout];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  
    cell.lbl.text = [NSString stringWithFormat:@"Name by %d",(int)indexPath.item + 1];

    [cell.avatarImageButton setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    cell.avatarImageButton.imageView.contentMode=UIViewContentModeScaleToFill;

    cell.avatarImageButton.layer.cornerRadius = 25;
//    cell.coverButton.tag = (int)indexPath;
//    [cell.coverButton addTarget:self action:@selector(onClickCoverButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)goToGettingFriendsSwiping:(UIButton *)sender{
    
    // //   navigating
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GettingForFriendSwiping" bundle:nil];
    UINavigationController *addingFriendScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idGettingForFriendSwiping"];
    
    [self.navigationController pushViewController:addingFriendScene animated:YES];
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

