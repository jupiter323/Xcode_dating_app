//
//  MatchesViewController.h
//  Korte
//
//  Created by Peace on 8/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/foundation.h>
#import "BasicMenuController.h"

@interface MatchesViewController : BasicMenuController
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (strong, nonatomic) IBOutlet UILabel *messagesLabel;

@end
