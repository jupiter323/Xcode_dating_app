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
@interface WireframeViewController : UIViewController {
    ThemDefinition *  themKind;
}
@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *returnButton;
@property (strong, nonatomic) UIButton *notificationButton;
@property (strong, nonatomic) UIButton *addConnection;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@property (strong, nonatomic) UIButton *myProfile;
@end
