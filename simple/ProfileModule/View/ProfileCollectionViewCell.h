//
//  ProfileCollectionViewCell.h
//  Korte
//
//  Created by Peace on 9/18/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDraggableCollectionViewCell.h"
@interface ProfileCollectionViewCell : HTKDraggableCollectionViewCell
@property (strong, nonatomic)  UIImageView *avatarImage;
@property (strong, nonatomic)  UIButton *subButton;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, nonatomic) Boolean isVideo;
- (void)enableGestureC:(BOOL) enable;
-(void)flagIsVideo;
@end
