//
//  VideoPlayViewController.h
//  Korte
//
//  Created by Peace on 10/16/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayViewController : UIViewController
@property(strong,readwrite) NSURL *videoUrl;
@end

NS_ASSUME_NONNULL_END
