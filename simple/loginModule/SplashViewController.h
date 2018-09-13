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
@interface SplashViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *CPasswordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
