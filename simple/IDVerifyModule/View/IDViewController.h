//
//  ViewController.h
//  CameraTest
//
//  Created by Boisy Pitre on 1/28/16.
//  Copyright © 2016 Affectiva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Affdex/Affdex.h>

@interface IDViewController : UIViewController <AFDXDetectorDelegate>

@property (strong) AFDXDetector *detector;
@property (strong) IBOutlet UIImageView *cameraView;


@end

