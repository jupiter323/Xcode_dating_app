//
//  BasicMenuController.h
//  simple
//
//  Created by Peace on 8/8/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "WireframeViewController.h"
@interface BasicMenuController : WireframeViewController
@property (strong, nonatomic) UIButton *floatingButton;
@property (strong, nonatomic) UIButton *returnButton;
@property (strong, nonatomic) UIButton *notificationButton;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@end
