//
//  LocationViewController.m
//  simple
//
//  Created by Peace on 8/7/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "LocationViewController.h"
#import <Foundation/Foundation.h>
#import "Utilities.h"

@import GoogleMaps;

@interface LocationViewController () {
    GMSMapView *mapView;
    UIButton *searchButton;
    UIButton *blockAndListButton;
    BOOL block;
    NSObject *data;
}

@property (weak, nonatomic) IBOutlet UIView *searchButtonView;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationLogo;
@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UIScrollView *venuInfoScroll;
@property (weak, nonatomic) IBOutlet UIView *mapViewContent;
@end

@implementation LocationViewController


// Set the status bar style to complement night-mode.
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    remove flat button
    self.floatingButton.removeFromSuperview;
    //    remove notify button
    self.notificationButton.removeFromSuperview;
    //show REL
    self.searchBarView.hidden=YES;
    //search button
    searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchButton sizeToFit];
    searchButton.frame = CGRectMake(self.view.bounds.size.width-20-searchButton.bounds.size.width, 30, searchButton.bounds.size.width, searchButton.bounds.size.height);
    [searchButton addTarget:self action:@selector(tapedSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    //    map block and list button
    
    
    //map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:12];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"style" ofType:@"json" inDirectory:@"data"];
    NSURL *styleUrl = [[NSURL alloc] initFileURLWithPath:path];
    NSError *error;
    
    //// Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    
    mapView.mapStyle = style;
    [self.mapViewContent addSubview:mapView];
    ////block and list button
    block=true;
    blockAndListButton = [[UIButton alloc] init];
    [blockAndListButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [blockAndListButton sizeToFit];
    
    [blockAndListButton addTarget:self action:@selector(tapedBlockAList:) forControlEvents:UIControlEventTouchUpInside];
    self.mapViewContent.layer.backgroundColor=[UIColor blackColor].CGColor;
    [self.mapViewContent addSubview:blockAndListButton];
    
    //// Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
}

-(void)tapedBlockAList:(UIButton *) sender{
    block=!block;
    if(block){
        [blockAndListButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        [self addBlockLists:true];
    }
    
    else{
        [blockAndListButton setImage:[UIImage imageNamed:@"block"] forState:UIControlStateNormal];
        [self addBlockLists:false];
    }
}
-(void)tapedSearch:(UIButton *) sender{
    
    
    searchButton.hidden=YES;
    self.searchBarView.hidden=NO;
    self.searchBarView.layer.cornerRadius=21;
    self.searchButtonView.layer.cornerRadius=21;
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    //    map frame
    mapView.frame = CGRectMake(0, 0, self.mapViewContent.frame.size.width, self.mapViewContent.frame.size.height);
    //    block and list button frame
    blockAndListButton.frame = CGRectMake(self.mapViewContent.bounds.size.width-10-blockAndListButton.bounds.size.width, self.mapViewContent.bounds.size.height-10-blockAndListButton.bounds.size.height, blockAndListButton.bounds.size.width, blockAndListButton.bounds.size.height);
    //    venus and match info
    [self addBlockLists:true];
    
    
}
float saveXOffset=0;
int indexOfVenu=0;
int sizeOfVenu=5;
bool block=true;

-(void)addBlockLists:(BOOL) block{
    //    remove subviews on scroll view
    for(UIView *subview in [self.venuInfoScroll subviews]) {
        [subview removeFromSuperview];
    }
    //    add block or lists
    UIView *infoView;
    if(block){//block
        float rectWidth = self.view.frame.size.width-40;
        self.venuInfoScroll.delegate = self;
        self.venuInfoScroll.contentSize=CGSizeMake(sizeOfVenu*(rectWidth+10)+20, self.venuInfoScroll.bounds.size.height);
        for(int i=0;i<sizeOfVenu;i++){
            infoView=[[UIView alloc] init];
            
            infoView.frame=CGRectMake(20+i*(rectWidth+10),10,rectWidth,self.venuInfoScroll.frame.size.height-20);
            infoView.layer.cornerRadius=20;
            infoView.backgroundColor = [UIColor whiteColor];
            ////infoView venu,review,match
            /////entired match
            
            CGFloat avatarWidth = self.view.bounds.size.width/7;
            CGFloat ContentScrollWidth = infoView.bounds.size.width;
            CGFloat ContentScrollHeight = self.venuInfoScroll.bounds.size.height;
            CGFloat marginLeft = 20;
            CGFloat marginTop = 15;
            CGFloat matchesScrollHeight = avatarWidth;
            CGFloat reviewsViewHeight = ((ContentScrollHeight-matchesScrollHeight)/2-marginTop)/2;
            CGFloat pinWidth = 30;
            
            
            //////reviews adding
            UIView *reviewsView=[[UIView alloc]initWithFrame:CGRectMake(marginLeft,marginTop, ContentScrollWidth-marginLeft, reviewsViewHeight)];
            UIImageView *pinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pinWidth, reviewsViewHeight)];
            [pinImageView setImage:[UIImage imageNamed:@"pin"]];
            [reviewsView addSubview:pinImageView];
            
            UILabel *venuNameLabel=[[UILabel alloc]init];
            venuNameLabel.frame = CGRectMake(pinWidth+marginLeft, 0, ContentScrollWidth-marginLeft-pinWidth-marginLeft, reviewsViewHeight/3);
            [venuNameLabel setText:@"Pho Vihn"];
            [venuNameLabel setFont:[UIFont boldSystemFontOfSize:reviewsViewHeight/3]];
            [reviewsView addSubview:venuNameLabel];
            
            
            float mark =3;
            float starSize = reviewsViewHeight/3;
            for(int i=0;i<5;i++){
                UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(pinWidth+marginLeft+i*(starSize+2),reviewsViewHeight/3, starSize, starSize)];
                if(mark>i)[starImageView setImage:[UIImage imageNamed:@"star"]];
                else [starImageView setImage:[UIImage imageNamed:@"star_"]];
                [reviewsView addSubview:starImageView];
            }
            UILabel *reviewsLinkLabel=[[UILabel alloc]init];
            reviewsLinkLabel.frame = CGRectMake(pinWidth+marginLeft + 5*(starSize+2) + 2, reviewsViewHeight/3, ContentScrollWidth-marginLeft-pinWidth-marginLeft- 5*(starSize+2) - 2, reviewsViewHeight/3);
            [reviewsLinkLabel setText:@"100 Reviews"];
            [reviewsLinkLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            reviewsLinkLabel.textColor=[UIColor orangeColor];
            [reviewsView addSubview:reviewsLinkLabel];
            
            UILabel *venuDetailLabel=[[UILabel alloc]init];
            venuDetailLabel.frame = CGRectMake(pinWidth+marginLeft ,reviewsViewHeight*2/3+reviewsViewHeight/6, ContentScrollWidth-marginLeft-pinWidth-marginLeft, reviewsViewHeight/3);
            [venuDetailLabel setText:@"$ Vetname restaurant"];
            [venuDetailLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            venuDetailLabel.textColor=[UIColor grayColor];
            [reviewsView addSubview:venuDetailLabel];
            
            
            [infoView addSubview:reviewsView];
            /////matches description
            UILabel *matchesDesLabel=[[UILabel alloc]init];
            matchesDesLabel.frame = CGRectMake(marginLeft, reviewsViewHeight+marginTop*2, ContentScrollWidth-marginLeft, (reviewsViewHeight-marginTop)/2);
            [matchesDesLabel setText:@"10 Potential matches"];
            matchesDesLabel.textColor=[UIColor orangeColor];
            [matchesDesLabel setFont:[UIFont boldSystemFontOfSize:(reviewsViewHeight-marginTop)/2]];
            [infoView addSubview:matchesDesLabel];
            
            UILabel *matchesDesDeLabel=[[UILabel alloc]init];
            matchesDesDeLabel.frame = CGRectMake(marginLeft, reviewsViewHeight+marginTop*2+(reviewsViewHeight-marginTop)/2, ContentScrollWidth-marginLeft, (reviewsViewHeight-marginTop)/2);
            [matchesDesDeLabel setText:@"Matches will be revealed upon entry to venu"];
            [matchesDesDeLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            matchesDesDeLabel.textColor=[UIColor grayColor];
            [infoView addSubview:matchesDesDeLabel];
            //////matches adding
            
            UIScrollView *matches = [[UIScrollView alloc] init];
            matches.frame= CGRectMake(marginLeft,ContentScrollHeight/2-avatarWidth/2 , ContentScrollWidth-30, avatarWidth);
            float sizeOfMatches = 10;
            matches.contentSize=CGSizeMake(sizeOfMatches*avatarWidth, avatarWidth);
            for(int i=0;i<sizeOfMatches;i++){
                CGFloat buttonWidth = matchesScrollHeight;
                CGFloat buttonSide = 5;
                UIButton *avatar = [[UIButton alloc] init];
                avatar.frame = CGRectMake(i*(buttonWidth+buttonSide),0 , buttonWidth, buttonWidth);
                [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
                avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
                [avatar addTarget:self action:@selector(goToToMtch:) forControlEvents:UIControlEventTouchUpInside];
                avatar.layer.cornerRadius = avatar.frame.size.width / 2;
                avatar.clipsToBounds = YES;
                
                [matches addSubview:avatar];
            }
            
            //////cupid adding
            UILabel *cupidCoinsLabel=[[UILabel alloc]init];
            cupidCoinsLabel.frame = CGRectMake(marginLeft, ContentScrollHeight/2+avatarWidth/2+marginTop, ContentScrollWidth-marginLeft, (reviewsViewHeight-marginTop)/2);
            [cupidCoinsLabel setText:@"Cupid Coins!"];
            cupidCoinsLabel.textColor=[UIColor orangeColor];
            [cupidCoinsLabel setFont:[UIFont boldSystemFontOfSize:(reviewsViewHeight-marginTop)/2]];
            [infoView addSubview:cupidCoinsLabel];
            
            UILabel *cupidDesDeLabel=[[UILabel alloc]init];
            cupidDesDeLabel.frame = CGRectMake(marginLeft, ContentScrollHeight/2+avatarWidth/2+marginTop+(reviewsViewHeight-marginTop)/2, ContentScrollWidth-marginLeft, (reviewsViewHeight-marginTop)/2);
            [cupidDesDeLabel setText:@"Scan your receipt to earn a Cupid Coin-earn all 5 coins and get a treat on us!"];
            [cupidDesDeLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            cupidDesDeLabel.textColor=[UIColor grayColor];
            [infoView addSubview:cupidDesDeLabel];
            
            //////coins image adding
            float coins =3;
            float coinSize = reviewsViewHeight-17;
            for(int i=0;i<5;i++){
                UIButton *coinButton = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft+i*(coinSize+4),ContentScrollHeight/2+avatarWidth/2+reviewsViewHeight, coinSize, coinSize)];
                if(coins>i)[coinButton setImage:[UIImage imageNamed:@"cupid"] forState:UIControlStateNormal];
                else [coinButton setImage:[UIImage imageNamed:@"cupid_"] forState:UIControlStateNormal];
                [coinButton addTarget:self action:@selector(goToCupid:) forControlEvents:UIControlEventTouchUpInside];
                
                [infoView addSubview:coinButton];
            }
            
            UILabel *readmeLinkLabel=[[UILabel alloc]init];
            readmeLinkLabel.frame = CGRectMake(marginLeft+5*(coinSize+4)+4, ContentScrollHeight/2+avatarWidth/2+reviewsViewHeight, ContentScrollWidth-marginLeft- 5*(coinSize+4) - 4, reviewsViewHeight/3);
            [readmeLinkLabel setText:@"Read me"];
            [readmeLinkLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            readmeLinkLabel.textColor=[UIColor grayColor];
            [reviewsView addSubview:readmeLinkLabel];
            
            [infoView addSubview:matches];
            [self.venuInfoScroll addSubview:infoView];
        }
        self.venuInfoScroll.pagingEnabled = YES;
        self.venuInfoScroll.showsHorizontalScrollIndicator = NO;
    } else {//lists
        float rectWidth = self.view.frame.size.width;
        float rectHeight = (self.venuInfoScroll.frame.size.height-50)/3;
        self.venuInfoScroll.delegate = self;
        self.venuInfoScroll.contentSize=CGSizeMake(rectWidth, (rectHeight+10)*sizeOfVenu+30);
        for(int i=0;i<sizeOfVenu;i++){
            infoView=[[UIView alloc] init];
            infoView.frame=CGRectMake(0,20+i*(rectHeight+10),rectWidth,rectHeight);
            infoView.layer.cornerRadius=10;
            infoView.backgroundColor = [UIColor whiteColor];
            
            //////reviews addint to list
            ////////data
            CGFloat marginLeft = 20;
            CGFloat marginTop = 15;
            CGFloat pinWidth = 20;
            CGFloat ContentScrollWidth = infoView.bounds.size.width-marginLeft;
             CGFloat reviewsViewHeight = infoView.frame.size.height-2*marginTop;
        
            
            UIView *reviewsView=[[UIView alloc]initWithFrame:CGRectMake(marginLeft,marginTop, ContentScrollWidth-marginLeft, reviewsViewHeight)];
            UIImageView *pinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pinWidth, reviewsViewHeight)];
            [pinImageView setImage:[UIImage imageNamed:@"pin"]];
            [reviewsView addSubview:pinImageView];
            
            UILabel *venuNameLabel=[[UILabel alloc]init];
            venuNameLabel.frame = CGRectMake(pinWidth+marginLeft, 0, ContentScrollWidth-marginLeft-pinWidth-marginLeft, reviewsViewHeight/3);
            [venuNameLabel setText:@"Pho Vihn"];
            [venuNameLabel setFont:[UIFont boldSystemFontOfSize:reviewsViewHeight/3]];
            [reviewsView addSubview:venuNameLabel];
            
            
            float mark =3;
            float starSize = reviewsViewHeight/3;
            for(int i=0;i<5;i++){
                UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(pinWidth+marginLeft+i*(starSize+2),reviewsViewHeight/3, starSize, starSize)];
                if(mark>i)[starImageView setImage:[UIImage imageNamed:@"star"]];
                else [starImageView setImage:[UIImage imageNamed:@"star_"]];
                [reviewsView addSubview:starImageView];
            }
            UILabel *reviewsLinkLabel=[[UILabel alloc]init];
            reviewsLinkLabel.frame = CGRectMake(pinWidth+marginLeft + 5*(starSize+2) + 2, reviewsViewHeight/3, ContentScrollWidth-marginLeft-pinWidth-marginLeft- 5*(starSize+2) - 2-20, reviewsViewHeight/3);
            [reviewsLinkLabel setText:@"100 Reviews"];
            [reviewsLinkLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            reviewsLinkLabel.textColor=[UIColor orangeColor];
            [reviewsView addSubview:reviewsLinkLabel];
            
            UIButton *infoButton = [[UIButton alloc]initWithFrame:CGRectMake(pinWidth+marginLeft + 5*(starSize+2) + 2+ContentScrollWidth-marginLeft-pinWidth-marginLeft- 5*(starSize+2) - 2-20 ,reviewsViewHeight/3, 20, 20)];
            [infoButton setImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
            [infoButton addTarget:self action:@selector(goToInfo:) forControlEvents:UIControlEventTouchUpInside];
            [infoView addSubview:infoButton];
            
            UILabel *venuDetailLabel=[[UILabel alloc]init];
            venuDetailLabel.frame = CGRectMake(pinWidth+marginLeft ,reviewsViewHeight*2/3+reviewsViewHeight/6, ContentScrollWidth-marginLeft-pinWidth-marginLeft, reviewsViewHeight/3);
            [venuDetailLabel setText:@"$ Vetname restaurant"];
            [venuDetailLabel setFont:[UIFont systemFontOfSize:reviewsViewHeight/4]];
            venuDetailLabel.textColor=[UIColor grayColor];
            [reviewsView addSubview:venuDetailLabel];
            
            
            [infoView addSubview:reviewsView];
            
            
            [self.venuInfoScroll addSubview:infoView];
        }
        self.venuInfoScroll.pagingEnabled = YES;
        self.venuInfoScroll.showsVerticalScrollIndicator = NO;
        
    }
    
    
}
-(void)goToInfo:(UIButton *) sender{
    
}
-(void)goToCupid:(UIButton *) sender{
    
}
-(void)goToToMtch:(UIButton *) sender{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(block){
        CGFloat xOffset;
        float deltaOffset = 150;
        if(saveXOffset<self.venuInfoScroll.contentOffset.x&&(self.venuInfoScroll.contentOffset.x-saveXOffset)>deltaOffset)
            
            indexOfVenu++;
        else if(saveXOffset>self.venuInfoScroll.contentOffset.x&&(saveXOffset-self.venuInfoScroll.contentOffset.x)>deltaOffset)
            indexOfVenu--;
        if(indexOfVenu<0)indexOfVenu=0;
        
        xOffset = (self.view.bounds.size.width-30)*indexOfVenu;
        [self.venuInfoScroll setContentOffset:CGPointMake(xOffset, 0) animated:YES];
        saveXOffset=xOffset;
    }
    
    
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
