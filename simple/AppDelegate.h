//
//  AppDelegate.h
//  simple
//
//  Created by Peace on 8/2/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PDKeychainBindings.h"
#import "MXViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ProfileCollectionViewController.h"
#import "ProfileViewController.h"
#import "Utilities.h"
@import Firebase;
@import GoogleMaps;
@import GooglePlaces;
@import UserNotifications;
@import Firebase;
@interface AppDelegate : UIResponder <UIApplicationDelegate, FIRMessagingDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

