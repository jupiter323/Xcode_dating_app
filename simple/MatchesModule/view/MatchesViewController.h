//
//  MatchesViewController.h
//  Korte
//
//  Created by Peace on 8/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicMenuController.h"
#import "SearchTableViewCell.h"
@interface MatchesViewController : BasicMenuController
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (strong, nonatomic) IBOutlet UILabel *messagesLabel;

@end
