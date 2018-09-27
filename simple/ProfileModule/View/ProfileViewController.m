//
//  ProfileViewController.m
//  simple
//
//  Created by Peace on 8/4/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController (){
    UIButton *myProfile;
    MKDropdownMenu * heightDropdown;
    MKDropdownMenu * interestedDropdown;
    NSArray *heightArray;
    NSArray *interestedArray;
    NSMutableArray *imageArray;
    NSMutableArray *localImageArray;
    int indexOfHeight;
    int indexOfInterest;
    int ageMin;
    int ageMax;
    id userInfo;
    Boolean myswitchOn;
    Boolean myswitch1On;
    
    UIImage* onImage;
    UIImage* offImage;
    UIImageView* checkedIcon;
    
    UITextField *selectedText;
}
@property (weak, nonatomic) IBOutlet UIView *dropdownCateContainView;
@property (weak, nonatomic) IBOutlet UIView *dropdownContainView;
@property (weak, nonatomic) IBOutlet UIView *imagesContainView;
@property (strong, nonatomic) UIButton *visibleORU;
@property bool visible;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;
@property (nonatomic,strong) ProfileCollectionViewController *forCellDelegate;
@end

@implementation ProfileViewController

- (void)prepareringData{//show or init
    // getting user info
    
    userInfo = [jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"]) mutableCopy];
    
    //// image array read or init
    imageArray = [[userInfo objectForKey:@"images"] mutableCopy];
    if(!imageArray||[imageArray count]!=6){
        NSString *imagepath = [[NSBundle mainBundle] pathForResource:@"imagePlace" ofType:@"png" inDirectory:@"data"];
        NSURL *imageUrlI = [[NSURL alloc] initFileURLWithPath:imagepath];
        NSString *videoImagepath = [[NSBundle mainBundle] pathForResource:@"videoPlace" ofType:@"png" inDirectory:@"data"];
        NSURL *videoImageUrlI = [[NSURL alloc] initFileURLWithPath:videoImagepath];

        imageArray = [[NSMutableArray alloc] initWithObjects:imageUrlI.absoluteString,imageUrlI.absoluteString,imageUrlI.absoluteString,imageUrlI.absoluteString,imageUrlI.absoluteString,videoImageUrlI.absoluteString, nil]; //image array init
        userInfo[@"images"]=imageArray ;  //update userInfo
        [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];
    }
    
    ////local image init or read
    if([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"images"]){
        localImageArray = [jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"images"]) mutableCopy];
        NSLog(@"%@",[[PDKeychainBindings sharedKeychainBindings] objectForKey:@"images"]);
    }
    else{
        NSString *imagepath = [[NSBundle mainBundle] pathForResource:@"imagePlace" ofType:@"png" inDirectory:@"data"];
        
        NSString *videoImagepath = [[NSBundle mainBundle] pathForResource:@"videoPlace" ofType:@"png" inDirectory:@"data"];
        
        localImageArray = [[NSMutableArray alloc] initWithObjects:imagepath,imagepath,imagepath,imagepath,imagepath,videoImagepath, nil];
    }
    
    //// visible
    if(userInfo[@"visible"]){
        self.visible = ([userInfo[@"visible"]  isEqual: @"visible"])?true:false;
    } else {
        self.visible = true;
        [userInfo setObject:@"visible" forKey:@"visible"];
        [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];
    }
    
    //// gender
    if(userInfo[@"gender"]){
        [self.genderSeg setSelectedSegmentIndex:[userInfo[@"gender"] isEqual:@"f"]?0:1];
    } else {
        [self.genderSeg setSelectedSegmentIndex:0];
        [userInfo setObject:@"f" forKey:@"gender"];
        [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];
    }
    
    //// iGender
    if(userInfo[@"iGender"]){
        [self.interesGenderSeg setSelectedSegmentIndex:[userInfo[@"iGender"] isEqual:@"f"]?0:1];
    } else {
        [self.interesGenderSeg setSelectedSegmentIndex:0];
        [userInfo setObject:@"f" forKey:@"iGender"];
        [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];
    }
    
    //// occupation
    if(userInfo[@"occupation"])
        [self.occupationText setText:userInfo[@"occupation"]];
    
    //// about me
    if(userInfo[@"aboutMe"])
        [self.aboutMeText setText:userInfo[@"aboutMe"]];
    
    //// height dropdown
    if(userInfo[@"indexOfHeight"])
        indexOfHeight = [userInfo[@"indexOfHeight"] intValue];
    else
        indexOfHeight = -1;
 
    
    if(userInfo[@"indexOfInterest"])
        indexOfInterest = [userInfo[@"indexOfInterest"] intValue];
    else
        indexOfInterest = -1;
    
    //// age range
    if(userInfo[@"ageMin"])
        ageMin = [userInfo[@"ageMin"] intValue];
    else
        ageMin = 22;
    
    if(userInfo[@"ageMax"])
        ageMax = [userInfo[@"ageMax"] intValue];
    else
        ageMax = 40;
    
    
    //// switches
    if(userInfo[@"notySwitchStatus"])
        myswitchOn = [userInfo[@"notySwitchStatus"] isEqualToString:@"yes"]?YES:NO;
    else{
        [userInfo setObject:@"yes" forKey:@"notySwitchStatus"];
        myswitchOn = YES;
    }
    
    if(userInfo[@"soundSwitchStatus"])
        myswitch1On = [userInfo[@"soundSwitchStatus"] isEqualToString:@"yes"]?YES:NO;
    else {
        [userInfo setObject:@"no" forKey:@"soundSwitchStatus"];
        myswitch1On = NO;
    }
    
    //// id veryfy
    if(!userInfo[@"idVerifyStatus"]){
        [userInfo setObject:@"no" forKey:@"idVerifyStatus"];
    }
    // driodown datas
    heightArray = @[@"4’", @"4’1”", @"4’2”", @"4’3”", @"4’4”",@"4’5”", @"4’6”", @"4’7”",@"4’8”", @"4’9”", @"5’", @"5’1”", @"5’2”", @"5’3”", @"5’4”", @"5’5”",@"5’6”",@"5’7”", @"5’8”", @"5’9”", @"6’",@"6’1”",@"6’2”",@"6’3”", @"6’4”", @"6’5”", @"6’6”", @"6’7”", @"6’8”", @"6’9”",@"7’",@"7’1”",@"7’2”",@"7’3”",@"7’4”",@"7’5”",@"7’6”",@"7’7”",@"7’8”",@"7’9”",@"8’"];
    interestedArray = @[@"Assian", @"European", @"American"];
    
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self prepareringData];
    // id verify button view
    
    self.idVerifyView.backgroundColor = [UIColor colorWithRed:0.95 green:0.49 blue:0.4 alpha:1];
    self.idVerifyView.layer.borderWidth = 1.2;
    self.idVerifyView.layer.cornerRadius = 10;
    self.idVerifyView.layer.borderColor = [[UIColor whiteColor] CGColor];
    checkedIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 3, self.idVerifyView.frame.size.width-5, self.idVerifyView.frame.size.height-5)];
    [checkedIcon setImage:[UIImage imageNamed:@"verified"]];
    [self.idVerifyView addSubview:checkedIcon];
    
    
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
//        notification button invisible
    [self.notificationButton removeFromSuperview];
    // Do any additional setup after loading the view.
    // remove floating button
    [self.floatingButton removeFromSuperview];
   
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
    
    //    visible or invisible button
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
    CGFloat profileWidth = 62 - 9.03*2;
    myProfile = [[UIButton alloc] init];
    myProfile.frame = CGRectMake(self.view.bounds.size.width/2-profileWidth/2, 75 +9.03 , profileWidth,profileWidth);
    myProfile.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [myProfile addTarget:self action:@selector(saveProfileAndReturn:) forControlEvents:UIControlEventTouchUpInside];
    myProfile.layer.cornerRadius = myProfile.frame.size.width / 2;
    myProfile.clipsToBounds = YES;
    myProfile.layer.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.34].CGColor;
    
    UIView *forBorder = [[UIView alloc] initWithFrame:CGRectMake(myProfile.frame.origin.x-9.03, myProfile.frame.origin.y-9.03, profileWidth +9.03*2, profileWidth +9.03*2)];
    [forBorder setBackgroundColor:[UIColor whiteColor]];
    forBorder.layer.cornerRadius = forBorder.frame.size.width /2;
    [self.view addSubview:forBorder];
    
    [self.view addSubview:myProfile];
        
    
    //    adding part
    //    [self.view addSubview:contain];
    [self.view addSubview:self.visibleORU];
    
    //image or video to collection
    
    //switch image size
    onImage = imageWithImage([UIImage imageNamed:@"switchturnon"],CGSizeMake(228, 99));
    offImage = imageWithImage([UIImage imageNamed:@"switchturnoff"],CGSizeMake(228, 99));
    
    
}


- (IBAction)deleteAccount:(id)sender {
//    alertCustom(SCLAlertViewStyleSuccess, @"Do you really want to erase it?");
    //delete localdatas
    [[PDKeychainBindings sharedKeychainBindings] removeObjectForKey:@"userInfo"];
    [[PDKeychainBindings sharedKeychainBindings] removeObjectForKey:@"profileFlag"];
    [[PDKeychainBindings sharedKeychainBindings] removeObjectForKey:@"images"];
    [self logOut];
}

#pragma mark TTRangeSliderViewDelegate
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{

}
- (void)didEndTouchesInRangeSlider:(TTRangeSlider *)sender{
    ageMin = (int)sender.selectedMinimum;
    ageMax = (int)sender.selectedMaximum;
    [userInfo setObject:[NSString stringWithFormat:@"%d",ageMin] forKey:@"ageMin"];
    [userInfo setObject:[NSString stringWithFormat:@"%d",ageMax] forKey:@"ageMax"];
    
  

    NSString *textContent = [NSString stringWithFormat:@"%@%d%@%d", @"Between ages of ", ageMin,@" to ",ageMax];
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Book" size:12];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.17;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    self.ageRangeAbove.attributedText = textString;
    [self.ageRangeAbove sizeToFit];
    
    [self changeUserInfo];
}



-(void)changeUserInfo{
    [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];
    [[PDKeychainBindings sharedKeychainBindings] setObject:@"yes" forKey:@"profileFlag"];
}

-(void)saveProfileAndReturn:(UIButton *) sender{
    if([[[PDKeychainBindings sharedKeychainBindings] objectForKey:@"profileFlag"] isEqual:@"yes"]){
        userInfo = [jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"]) mutableCopy];
        id responseData = [[Utilities sharedUtilities] apiService:@{@"data":jsonStringify(userInfo)} requestMethod:Post url:@"users/profile"];
        if(responseData[@"success"])
          [[PDKeychainBindings sharedKeychainBindings] setObject:@"no" forKey:@"profileFlag"];
    }
    [self returnFun];
    
}
-(void)viewDidAppear:(BOOL)animated{
    //profile image
    [myProfile setImage:[UIImage imageWithContentsOfFile:localImageArray[0]] forState:UIControlStateNormal];
    // for id verify
    UITapGestureRecognizer *singleViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToIDVerify:)];
    [self.verifyView addGestureRecognizer:singleViewTap];
    userInfo = [jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"]) mutableCopy];
    checkedIcon.hidden = ![[userInfo objectForKey:@"idVerifyStatus"] isEqual:@"yes"]?YES:NO;
    NSLog(@"%@", userInfo);
    
    // for image and video uploading
    self.forCellDelegate = [[ProfileCollectionViewController alloc]init];
    [self.forCellDelegate setData:imageArray local:localImageArray];
    [self.imagesContainView addSubview:self.forCellDelegate.collectionView];
    
    
    // age range style
    
    self.ageRange = [[TTRangeSlider alloc]initWithFrame:CGRectMake(0, 0, self.ageRangeView.frame.size.width, self.ageRangeView.frame.size.height)];
    self.ageRange.delegate = self;
    self.ageRange.minValue = 18;
    self.ageRange.maxValue = 100;
    self.ageRange.selectedMinimum = ageMin;
    self.ageRange.selectedMaximum = ageMax;
    self.ageRange.tintColor = [UIColor colorWithRed:0.82 green:0.8 blue:0.8 alpha:1]; self.ageRange.handleColor = [UIColor colorWithRed:0.95 green:0.54 blue:0.09 alpha:1];
    self.ageRange.handleDiameter = 19;
    self.ageRange.selectedHandleDiameterMultiplier = 1;
    self.ageRange.tintColorBetweenHandles = [UIColor colorWithRed:0.95 green:0.54 blue:0.09 alpha:1];
    self.ageRange.lineHeight = 4;
    self.ageRange.hideLabels = YES;
    [self.ageRangeView addSubview:self.ageRange];
    
     // age range labe
    
    self.ageRangeAbove.lineBreakMode = NSLineBreakByWordWrapping;
    self.ageRangeAbove.numberOfLines = 0;
    self.ageRangeAbove.textColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1];
    NSString *textContent = [NSString stringWithFormat:@"%@%d%@%d", @"Between ages of ", ageMin,@" to ",ageMax];
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Book" size:12];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.17;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    self.ageRangeAbove.attributedText = textString;
    [self.ageRangeAbove sizeToFit];
    
     //gender style

    [self styleingSegment:self.genderSeg];
    [self styleingSegment:self.interesGenderSeg];
    
    // switch
   
    
    
    Switch* mySwitch = [Switch switchWithImage:onImage visibleWidth:52];
    mySwitch.on = myswitchOn;
    [mySwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    mySwitch.layer.cornerRadius = 17.5;
    mySwitch.tag = 0; // noti
    [self.notiSwitchView addSubview:mySwitch];
    
    Switch* mySwitch1 = [Switch switchWithImage:onImage visibleWidth:52];
    mySwitch1.on = myswitch1On;
    [mySwitch1 addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    mySwitch1.layer.cornerRadius = 17.5;
    mySwitch1.tag = 1; // sound
    
    [self.soundSwitchView addSubview:mySwitch1];

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    delay(0.15, ^{
        [self->heightDropdown closeAllComponentsAnimated:YES];
        [self->interestedDropdown closeAllComponentsAnimated:YES];
    });
 
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    delay(0.15, ^{
        [self->heightDropdown closeAllComponentsAnimated:YES];
        [self->interestedDropdown closeAllComponentsAnimated:YES];
    });
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    selectedText = textField;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyNotificationMethod:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}
- (IBAction)occupationEditEnd:(id)sender {
    UITextField *occu = sender;
    [userInfo setObject:[occu text] forKey:@"occupation"];
    [self changeUserInfo];
    
}
- (IBAction)aboutmeEditend:(id)sender {
    UITextField *about = sender;
    [userInfo setObject:[about text] forKey:@"aboutMe"];
    [self changeUserInfo];
}

- (void)keyNotificationMethod:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSLog(@"%f",keyboardFrameBeginRect.size.height);
    CGFloat scrollOffsetY = selectedText.frame.origin.y+selectedText.frame.size.height+keyboardFrameBeginRect.size.height + self.scrollContent.contentSize.height;
    NSLog(@"%f", selectedText.frame.origin.y);
    if( ((self.scrollContent.contentOffset.y - scrollOffsetY) > (self.scrollContent.contentSize.height - keyboardFrameBeginRect.size.height - selectedText.frame.size.height))|| (self.scrollContent.contentOffset.y<scrollOffsetY ))
        
      [self.scrollContent setContentOffset:CGPointMake(0, scrollOffsetY) animated:NO];
}

-(void)switchToggled:(Switch*)mySwitch
{
   
    mySwitch.image = mySwitch.on ? onImage:offImage;
    NSLog(@"Switch Toggled %@%li",(mySwitch.on ? @"ON" : @"OFF"),(long)mySwitch.tag);//0: noty, 1:sound
    if(mySwitch.tag == 0){//noty
        myswitchOn = mySwitch.on ? YES:NO;
        [userInfo setObject:mySwitch.on ?@"yes":@"no" forKey:@"notySwitchStatus"];
        
    } else { //sound
        myswitch1On = mySwitch.on ? YES:NO;
        [userInfo setObject:mySwitch.on ?@"yes":@"no" forKey:@"soundSwitchStatus"];
    }
    [self changeUserInfo];
}
-(void)styleingSegment:(UISegmentedControl *)sender{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"GothamRounded-Book" size:14.4], NSFontAttributeName,
                                [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1], NSForegroundColorAttributeName,
                                nil];
    [sender setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [sender setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    
    for (int i=0; i<[sender.subviews count]; i++)
    {
        [[sender.subviews objectAtIndex:i] setTintColor:nil];
        if (![[sender.subviews objectAtIndex:i]isSelected])
        {
            [[sender.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1]];

        }
        else
        {
            [[sender.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:0.95 green:0.54 blue:0.09 alpha:1]];

        }
    }
}
- (IBAction)myGender:(id)sender {
    [userInfo setObject:[sender selectedSegmentIndex] == 0?@"f":@"m" forKey:@"gender"];
    [self changeUserInfo];
    [self styleingSegment:self.genderSeg];
   
}
- (IBAction)interGender:(id)sender {
    [userInfo setObject:[sender selectedSegmentIndex] == 0?@"f":@"m" forKey:@"iGender"];
    [self changeUserInfo];
    [self styleingSegment:self.interesGenderSeg];
}


- (void)goToIDVerify:(UITapGestureRecognizer *)recognizer
{
    
//    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
 
    if([[userInfo objectForKey:@"idVerifyStatus"] isEqual:@"yes"]) return;
    
    for(int i=0;i<6;i++){
        if(![localImageArray[i] containsString:@"imagePlace"] &&![localImageArray[i] containsString:@"videoPlace"]){// profile image uploaded
            
            //        navigating to verify
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IDVerify" bundle:nil];
            IDViewController *idVerify = (IDViewController *)[storyboard instantiateViewControllerWithIdentifier:@"idVerify"];
            // index push
            idVerify.indexOfNotPlaceHolder = i;
            [self.navigationController pushViewController:idVerify animated:NO];
            break;
        } else if(i == 5) alertCustom(SCLAlertViewStyleError, @"Please make your profile photo");
    }
   
   
}
- (IBAction)logout:(id)sender {
    
        [self logOut];
    
}


#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
    
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    if(dropdownMenu == heightDropdown)
        return 41;
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
        return [[NSAttributedString alloc] initWithString:indexOfHeight==-1?@"Height":heightArray[indexOfHeight]
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:@"GothamRounded-Book" size:14.4],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    else if(dropdownMenu == interestedDropdown)
        return [[NSAttributedString alloc] initWithString:indexOfInterest==-1?@"Everyone":interestedArray[indexOfInterest]
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:@"GothamRounded-Book" size:14.4],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    return 0;
    
    
    
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSMutableAttributedString *string;
    if(dropdownMenu == heightDropdown)
        string =
        [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"   %@", heightArray[row]]
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:@"GothamRounded-Book" size:12],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    else if(dropdownMenu == interestedDropdown)
        string =
        [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@", interestedArray[row]]
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:@"GothamRounded-Book" size:12],
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1]}];
    return string;
}

//
- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component {
    return [UIColor colorWithWhite:0.0 alpha:0.5];
}


- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(dropdownMenu == heightDropdown){
        [userInfo setObject:[NSString stringWithFormat:@"%d",(int)row] forKey:@"indexOfHeight"];
        indexOfHeight = (int)row;
    } else if(dropdownMenu == interestedDropdown){
        [userInfo setObject:[NSString stringWithFormat:@"%d",(int)row] forKey:@"indexOfInterest"];
        indexOfInterest = (int)row;
    }
    [self changeUserInfo];
    delay(0.15, ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
        [dropdownMenu reloadAllComponents];
    });   
}

-(void)visibleOrInvisible:(UIButton *) sender{
    self.visible = !self.visible;
    if(self.visible)
    {
        NSLog(@"visible");
        [sender setImage:[UIImage imageNamed:@"vi"] forState:UIControlStateNormal];
    } else
        [sender setImage:[UIImage imageNamed:@"inVi"] forState:UIControlStateNormal];
    
    // change local data and flag
    [userInfo setObject:self.visible?@"visible":@"invisible" forKey:@"visible"];
 
    [self changeUserInfo];
    
   
    
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
