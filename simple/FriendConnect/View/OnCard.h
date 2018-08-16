//
//  MXMemberCardView.h
//  Mixer
//
//  Created by Scott Kensell on 6/20/16.
//  Copyright © 2016 Two To Tango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "MXCardsSwipingView.h"

@interface OnCard : UIView <MXSwipableCard>

- (void)setupWithAModel:(SectionDefinition)someModel;
- (void)addShadow;

+ (CGFloat)aspectRatio;

@end

