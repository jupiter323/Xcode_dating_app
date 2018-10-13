//
//  ProfileViewController.h
//  simple
//
//  Created by Peace on 8/4/18.
//  Copyright © 2018 Peace. All rights reserved.
//
#import "BasicMenuController.h"
#import <UIKit/UIKit.h>
#import "MKDropdownMenu.h"
#import "ProfileCollectionViewController.h"
#import "TTRangeSlider.h"
#import "Switch.h"
#import "MXMemberCardView.h"
#import "Utilities.h"
#import "IDViewController.h"
@interface ProfileViewController : BasicMenuController<MKDropdownMenuDelegate, MKDropdownMenuDataSource, TTRangeSliderDelegate>
@property (weak, nonatomic) IBOutlet UIView *verifyView;
@property (weak, nonatomic) IBOutlet UILabel *holdLabel;

@property (weak, nonatomic) IBOutlet UIView *idVerifyView;
@property (weak, nonatomic) IBOutlet UIView *ageRangeView;
@property (strong, nonatomic)  TTRangeSlider *ageRange;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *interesGenderSeg;
@property (weak, nonatomic) IBOutlet UIView *soundSwitchView;
@property (weak, nonatomic) IBOutlet UIView *notiSwitchView;
@property (weak, nonatomic) IBOutlet UITextField *occupationText;
@property (weak, nonatomic) IBOutlet UITextField *aboutMeText;
@property (weak, nonatomic) IBOutlet UILabel *ageRangeAbove;
@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@end
