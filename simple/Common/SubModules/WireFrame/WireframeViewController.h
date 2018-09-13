//
//  WireframeViewController.h
//  Korte
//
//  Created by Peace on 8/15/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSFloatingActionMenu.h"
#import <Foundation/Foundation.h>
#import "Utilities.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "PDKeychainBindings.h"
@interface WireframeViewController : UIViewController {
    ThemDefinition *  themKind;
}
-(void)logOut;
-(void)returnFun:(UIButton *) sender ;
-(void)returnFun;
-(void)toAddConnection:(UIButton *)sender;
-(void)addButtonTapped:(UIButton *)sender;
-(void)toProfile:(UIButton *) sender;
-(void)tapedNoti:(UIButton *) sender;
-(void)tapedToggle:(UIButton *) sender;
-(void) navAnimating:(NSString *) type subtype:(NSString *) subtype;
-(void)toMatches:(UIButton *) sender;
-(void)toChatbox:(UIButton *)sender;
-(void)toMatchProfile:(UIButton *)sender;
@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *returnButton;
@property (strong, nonatomic) UIButton *notificationButton;
@property (strong, nonatomic) UIButton *addConnection;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@property (strong, nonatomic) UIButton *myProfile;
@property (strong, nonatomic) UIView *bottom;
@end
