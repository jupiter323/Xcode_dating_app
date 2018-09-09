//
//  ProfileViewController.m
//  simple
//
//  Created by Peace on 8/4/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "ProfileViewController.h"
#import "MXMemberCardView.h"
#import "Utilities.h"



@interface ProfileViewController (){
    MKDropdownMenu * heightDropdown;
    MKDropdownMenu * interestedDropdown;
    NSArray *heightArray;
    NSArray *interestedArray;
}
@property (weak, nonatomic) IBOutlet UIView *dropdownCateContainView;
@property (weak, nonatomic) IBOutlet UIView *dropdownContainView;
@property (weak, nonatomic) IBOutlet UIView *imagesContainView;
@property (strong, nonatomic) UIButton *visibleORU;
@property bool visible;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    heightArray = @[@"5’1”", @"5’2”", @"5’3”", @"5’4”", @"5’5”",@"5’6”",@"5’7”"];
    interestedArray = @[@"Assian", @"European", @"American"];
    // id verify button view
    
    self.idVerifyView.backgroundColor = [UIColor colorWithRed:0.95 green:0.49 blue:0.4 alpha:1];
    self.idVerifyView.layer.borderWidth = 1.2;
    self.idVerifyView.layer.cornerRadius = 10;
    
    self.idVerifyView.layer.borderColor = [[UIColor whiteColor] CGColor];
    // label
    self.holdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.holdLabel.numberOfLines = 0;
    self.holdLabel.textColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1];
    self.holdLabel.textAlignment = NSTextAlignmentCenter;
    NSString *textContent = @"Hold & drag your photos to change the order";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Book" size:12];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.17;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    self.holdLabel.attributedText = textString;
    [self.holdLabel sizeToFit];
    
    
    //    remove returnButton button
    [self.returnButton removeFromSuperview];
    //    notification button invisible
    [self.notificationButton removeFromSuperview];
    // Do any additional setup after loading the view.
    // remove floating button
    [self.floatingButton removeFromSuperview];
    //init data
    self.visible = true;
    //    dropdown contain
    heightDropdown = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, self.dropdownContainView.bounds.size.width,self.dropdownContainView.bounds.size.height )];
    heightDropdown.dataSource = self;
    heightDropdown.delegate = self;
    heightDropdown.layer.cornerRadius = 4;
    heightDropdown.clipsToBounds = YES;
    heightDropdown.layer.borderWidth = 1.2f;
    heightDropdown.layer.borderColor = [[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] CGColor];
    heightDropdown.disclosureIndicatorImage = [UIImage imageNamed:@"indicateForDropdown"] ;
    heightDropdown.backgroundDimmingOpacity = 0;
    heightDropdown.disclosureIndicatorSelectionRotation = M_PI;
    [self.dropdownContainView addSubview:heightDropdown];
    
    
    //    dropdown containcate
    interestedDropdown = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, self.dropdownCateContainView.bounds.size.width,self.dropdownCateContainView.bounds.size.height )];
    interestedDropdown.dataSource = self;
    interestedDropdown.delegate = self;
    interestedDropdown.layer.cornerRadius = 4;
    interestedDropdown.clipsToBounds = YES;
    interestedDropdown.layer.borderWidth = 1.2f;
    interestedDropdown.layer.borderColor = [[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] CGColor];
    
    interestedDropdown.dropdownShowsTopRowSeparator = YES;
    interestedDropdown.dropdownShowsBottomRowSeparator = NO;
    interestedDropdown.dropdownShowsBorder = YES;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(11, 6), NO, 0.0);
    UIImage *blankImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    interestedDropdown.disclosureIndicatorImage = blankImage ;
    interestedDropdown.backgroundDimmingOpacity = 0; 
    [self.dropdownCateContainView addSubview:interestedDropdown];
    
    //    visible or unvisible button
    self.visibleORU = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.visible)
    {
        NSLog(@"visible");
        [self.visibleORU setImage:[UIImage imageNamed:@"vi"] forState:UIControlStateNormal];
    } else
        [self.visibleORU setImage:[UIImage imageNamed:@"inVi"] forState:UIControlStateNormal];
    [self.visibleORU sizeToFit];
    self.visibleORU.frame = CGRectMake(self.view.bounds.size.width-20-self.visibleORU.bounds.size.width, 25, self.visibleORU.bounds.size.width, self.visibleORU.bounds.size.height);
    [self.visibleORU addTarget:self action:@selector(visibleOrInvisible:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    profile button
    CGFloat profileWidth = 62;
    UIButton *myProfile = [[UIButton alloc] init];
    myProfile.frame = CGRectMake(self.view.bounds.size.width/2-profileWidth/2, 75 , profileWidth,profileWidth);
    [myProfile setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    myProfile.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [myProfile addTarget:self action:@selector(returnFun:) forControlEvents:UIControlEventTouchUpInside];
    myProfile.layer.cornerRadius = myProfile.frame.size.width / 2;
    myProfile.clipsToBounds = YES;
    myProfile.layer.borderWidth = 9.03f;
    myProfile.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:myProfile];
        
    
    //    adding part
    //    [self.view addSubview:contain];
    [self.view addSubview:self.visibleORU];
    
    //    images and video
    
    for(int i=0;i<6;i++){
        
        UIImageView *image1 = [[UIImageView alloc] init];
        CGFloat buttonWidth = 88;
        CGFloat buttonSide = (self.view.bounds.size.width-64-3*buttonWidth)/2;
        CGFloat buttonLocH =15;
        if(i>2)
            buttonLocH =buttonLocH+buttonWidth+10;
        image1.frame = CGRectMake(32+i%3*buttonWidth+i%3*buttonSide,buttonLocH , buttonWidth, buttonWidth);
        [image1 setImage:[UIImage imageNamed:@"sunglassesGirl"]];
        image1.contentMode =UIViewContentModeScaleAspectFill;
        image1.layer.cornerRadius = image1.frame.size.width / 2;
        image1.clipsToBounds = YES;
        image1.layer.borderWidth = 3.0f;
        image1.layer.borderColor = [[UIColor colorWithRed:0.96 green:0.57 blue:0.15 alpha:1] CGColor];
        
        UIButton *image1button = [UIButton buttonWithType:UIButtonTypeCustom];
        [image1button sizeToFit];
        [image1button addTarget:self
                         action:@selector(deletAvatar:)
               forControlEvents:UIControlEventTouchDown];
        image1button.backgroundColor = [UIColor clearColor];
        [image1button setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        image1button.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat subbuttonWidth = 26;
        image1button.frame = CGRectMake(image1.frame.origin.x+image1.frame.size.width-subbuttonWidth, image1.frame.origin.y+image1.frame.size.width-subbuttonWidth, subbuttonWidth, subbuttonWidth);
        
        [self.imagesContainView addSubview:image1];
        [self.imagesContainView addSubview:image1button];
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    UITapGestureRecognizer *singleViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToIDVerify:)];
    [self.verifyView addGestureRecognizer:singleViewTap];
}
- (void)goToIDVerify:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    //for animation navigating
    [self navAnimating:kCATransitionFade subtype:kCATransitionFromLeft];
    
    //        navigating to verify
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IDVerify" bundle:nil];
    UINavigationController *locationScene = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"idVerify"];
    
    [self.navigationController pushViewController:locationScene animated:NO];
}


#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    if(dropdownMenu == heightDropdown)
        return 7;
    else if(dropdownMenu == interestedDropdown)
        return 3;
    return 0;
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 26;
}



- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
    if(dropdownMenu == heightDropdown)
        return [[NSAttributedString alloc] initWithString:@"Height"
                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.4 weight:UIFontWeightLight],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    else if(dropdownMenu == interestedDropdown)
        return [[NSAttributedString alloc] initWithString:@"Everything"
                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.4 weight:UIFontWeightLight],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    return 0;
  
    
    
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSMutableAttributedString *string;
    if(dropdownMenu == heightDropdown)
    string =
    [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"   %@", heightArray[row]]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12 weight:UIFontWeightLight],
                                                        NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    else if(dropdownMenu == interestedDropdown)
        string =
        [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@", interestedArray[row]]
                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12 weight:UIFontWeightLight],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    return string;
}

//
- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component {
    return [UIColor colorWithWhite:0.0 alpha:0.5];
}


- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(dropdownMenu == heightDropdown){
        NSLog(@"height: %ld",(long)row);
    } else if(dropdownMenu == interestedDropdown){
        NSLog(@"interested: %ld",(long)row);
        }
    delay(0.15, ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
    });
    
}
//

-(void)deletAvatar:(id) senderID{
    NSLog(@"senderID");
    
}
-(void)visibleOrInvisible:(UIButton *) sender{
    self.visible = !self.visible;
    if(self.visible)
    {
        NSLog(@"visible");
        [sender setImage:[UIImage imageNamed:@"vi"] forState:UIControlStateNormal];
    } else
        [sender setImage:[UIImage imageNamed:@"inVi"] forState:UIControlStateNormal];
    
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
