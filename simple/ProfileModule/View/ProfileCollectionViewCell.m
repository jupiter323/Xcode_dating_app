//
//  ProfileCollectionViewCell.m
//  Korte
//
//  Created by Peace on 9/18/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}
- (void) setupCell {
    
    //Create image
    self.avatarImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.avatarImage];
    
    // Create subbutton
    self.subButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.subButton];
    
    self.isVideo = false;
}
-(void) flagIsVideo{
    self.isVideo = true;
}
- (void) enableGestureC:(BOOL) enable{
    [self enableGesture:enable];
}
@end
