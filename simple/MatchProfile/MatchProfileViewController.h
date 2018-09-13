//
//  MatchProfileViewController.h
//  Korte
//
//  Created by Peace on 9/10/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "WireframeViewController.h"
#import "SBSliderView.h"
@interface MatchProfileViewController : WireframeViewController<SBSliderDelegate>
@property (weak, nonatomic) IBOutlet UIView *imageSlideView;
@end
