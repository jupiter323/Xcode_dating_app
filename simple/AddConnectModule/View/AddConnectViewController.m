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
    
    
    //    init friend views
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
- (void)viewDidAppear:(BOOL)animated{
    
    
    //    with friends connect
    self.connectWithFriendsLabel.attributedText = attributedString(@"Connect with Friends",StandardColor());
    
    //swipe for me label
    self.swipeForMeLabel.attributedText = attributedString(@"Swipe for me",StandardColor());
    
    //    info Button
    
    self.infoButton.backgroundColor = [UIColor colorWithRed:0.98 green:0.74 blue:0.48 alpha:1];
    self.infoButton.layer.cornerRadius = self.infoButton.frame.size.width/2;
    // add contain collect View
    
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6]];
    self.collectionView.layer.cornerRadius= self.addContainView.frame.size.height/2;
    //// add small contain collect view
    CGFloat originX = self.view.frame.size.width/2;
    CGFloat originY = self.addContainView.frame.origin.y+self.addContainView.frame.size.height/2;
    UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(originX-81, originY-81, 162, 162)];
    layer.backgroundColor = [UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6];
    layer.layer.cornerRadius = 81;
    //////add the smallest contain collect view
    UIView *smalllayer = [[UIView alloc] initWithFrame:CGRectMake(originX-55, originY-55, 110, 110)];
    smalllayer.backgroundColor = [UIColor colorWithRed:0.94 green:0.49 blue:0.4 alpha:0.6];
    smalllayer.layer.cornerRadius = 55;
    ////////image button
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(originX-30, originY-30, 60, 60)];
    [imageButton setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    imageButton.layer.cornerRadius = 30;
    imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageButton.clipsToBounds = YES;
    
    [[self view] addSubview:layer];
    [[self view] addSubview:smalllayer];
    [[self view] addSubview:imageButton];
    
    
    //    add friend views
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:
                                                      [NSIndexPath indexPathForRow:0 inSection:0],
                                                      [NSIndexPath indexPathForRow:1 inSection:0],
                                                      [NSIndexPath indexPathForRow:2 inSection:0],
                                                      [NSIndexPath indexPathForRow:3 inSection:0],
                                                      [NSIndexPath indexPathForRow:4 inSection:0],
                                                      [NSIndexPath indexPathForRow:5 inSection:0],
                                                      [NSIndexPath indexPathForRow:6 inSection:0],
                                                      [NSIndexPath indexPathForRow:7 inSection:0],
                                                      [NSIndexPath indexPathForRow:8 inSection:0],
                                                      [NSIndexPath indexPathForRow:9 inSection:0],
                                                      [NSIndexPath indexPathForRow:10 inSection:0],
                                                      [NSIndexPath indexPathForRow:11 inSection:0],
                                                      [NSIndexPath indexPathForRow:12 inSection:0],
                                                      [NSIndexPath indexPathForRow:13 inSection:0],
                                                      [NSIndexPath indexPathForRow:14 inSection:0],
                                                      [NSIndexPath indexPathForRow:15 inSection:0],
                                                      [NSIndexPath indexPathForRow:16 inSection:0],
                                                      [NSIndexPath indexPathForRow:17 inSection:0],
                                                      [NSIndexPath indexPathForRow:18 inSection:0],
                                                      [NSIndexPath indexPathForRow:19 inSection:0],
                                                      nil]];
        self->count = 20;
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
    
    
    //    swipe for me scroll adding
    UIScrollView *matches = [[UIScrollView alloc] init];
    [self.swipeForMeScroll setBackgroundColor:UIColorWithHexString(@"#E8E3E3")];
    CGFloat marginLeft = 0;
    CGFloat ContentScrollHeight = self.swipeformeScrollContent.frame.size.height;
    CGFloat ContentScrollWidth = self.swipeformeScrollContent.frame.size.width;
    CGFloat avatarWidth = self.swipeformeScrollContent.frame.size.height;
    matches.frame = CGRectMake(marginLeft,ContentScrollHeight-avatarWidth-10 , ContentScrollWidth, avatarWidth);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*(avatarWidth+10)+10, avatarWidth);
    for(int i=0;i<sizeOfMatches;i++){
        CGFloat buttonWidth = avatarWidth;
        CGFloat buttonSide = 10;
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+10,0 , buttonWidth, buttonWidth);
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        avatar.tag = i;
        [avatar addTarget:self action:@selector(goToToMtch:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        
        [matches addSubview:avatar];
    }
    [self.swipeformeScrollContent addSubview:matches];
    [self.swipeformeScrollContent setBackgroundColor:UIColorWithHexString(@"#E8E3E3")];
    //
    
}
//

-(void)setCircularLayout{
    CGFloat SCREEN_HEIGHT = self.collectionView.frame.size.height;
    CGFloat SCREEN_WIDTH = SCREEN_HEIGHT;
    CGFloat ITEM_WIDTH = 60;
    CGFloat ITEM_HEIGHT = 60;
    
    DSCircularLayout *circularLayout = [[DSCircularLayout alloc] init];
    [circularLayout initWithCentre:CGPointMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-25)
                            radius:SCREEN_WIDTH/2 -ITEM_WIDTH *1.2
                          itemSize:CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT)
                 andAngularSpacing:60];
    [circularLayout setStartAngle:M_PI endAngle:0];
    circularLayout.mirrorX = NO;
    circularLayout.mirrorY = NO;
    circularLayout.rotateItems = YES;
    circularLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.collectionView setCollectionViewLayout:circularLayout];
}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.lbl.text = [NSString stringWithFormat:@"%d",(int)indexPath.item + 1];
    
    return cell;
}


-(void)goToToMtch:(UIButton *)sender{
    NSLog(@"match button tag: %d",sender.tag);
//    goto friend connect
    // //   animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    // //   navigating
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FriendConnect" bundle:nil];
    //    UINavigationController *locationScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idFriendConnect"];
    
    [self.navigationController pushViewController:[AddingFriendViewController new] animated:YES];

    
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

