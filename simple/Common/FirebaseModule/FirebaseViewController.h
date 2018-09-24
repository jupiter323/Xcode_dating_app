//
//  FirebaseViewController.h
//  Korte
//
//  Created by Peace on 9/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDKeychainBindings.h"
#import "Utilities.h"
@import Firebase;
@interface FirebaseViewController : UIViewController
-(void)uploadToFirebaseStorage:(id) file;
-(void)configFireStorage;
@end
