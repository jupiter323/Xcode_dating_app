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
@interface ProfileViewController : BasicMenuController<MKDropdownMenuDelegate, MKDropdownMenuDataSource>
@property (weak, nonatomic) IBOutlet UIView *verifyView;
@property (weak, nonatomic) IBOutlet UILabel *holdLabel;

@property (weak, nonatomic) IBOutlet UIView *idVerifyView;

@end
