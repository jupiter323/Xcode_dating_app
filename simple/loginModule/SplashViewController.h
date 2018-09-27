//
//  SplashViewController.h
//  simple
//
//  Created by Peace on 8/2/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "PDKeychainBindings.h"
#import "UNIRest/UNIRest.h"
#import "Utilities.h"
@interface SplashViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *CPasswordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *nameCorrect;
@property (weak, nonatomic) IBOutlet UILabel *emailCorrect;
@property (weak, nonatomic) IBOutlet UILabel *passCorrect;
@property (weak, nonatomic) IBOutlet UILabel *cPCorrect;

@end
