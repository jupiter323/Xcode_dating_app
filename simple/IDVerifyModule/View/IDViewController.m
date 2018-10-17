//
//  IDViewController.m
//  CameraTest
//
//  Created by Boisy Pitre on 1/28/16.
//  Copyright © 2016 Affectiva. All rights reserved.
//

#import "IDViewController.h"

@interface IDViewController ()
{
    UIAlertView *alert;
    AFDXFace *faceData;
    BOOL isImageDetecting;
    int unRecognizedIndex;
}

@end
@implementation IDViewController
@synthesize indexOfNotPlaceHolder;
#pragma mark -
#pragma mark Convenience Methods

// This is a convenience method that is called by the detector:hasResults:forImage:atTime: delegate method below.
// You will want to do something with the face (or faces) found.
- (void)processedImageReady:(AFDXDetector *)detector image:(UIImage *)image faces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
{
    // iterate on the values of the faces dictionary
    for (AFDXFace *face in [faces allValues])
    {
        // Here's where you actually "do stuff" with the face object (e.g. examine the emotions, expressions,
        // emojis, and other metrics).
        NSLog(@"++++++++++++%@", face);
        if(isImageDetecting){
            faceData = face;
            isImageDetecting = false;
            [self createDetector];
        } else if(faceData.appearance==face.appearance||faceData.faceId==face.faceId){
            [self changeProfileAndReturn];
        }
       
//        for(NSData *pointOfFace in face.facePoints){
//            NSLog(@"%@",pointOfFace);
////            NSData *data = [pointOfFace dataUsingEncoding:NSUTF8StringEncoding];
////            id json = [NSJSONSerialization JSONObjectWithData:pointOfFace options:0 error:nil];
////            NSLog(@"%@",[json objectForKey:@"NSPoint"]);
////            NSPointerArray *array = face.facePoints;
//        }

    }
}
-(void)returnFun {
    //    animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.7;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    //    navigating
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        //delete it
    }
    NSLog(@"%@",faceData);
}
-(void)changeProfileAndReturn{
    self.idverifiedalertview.hidden = NO;
    NSString *textContent = @"Identity verified!";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:22];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.18;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    self.idverifiedtextlabel.attributedText = textString;
    [self.idverifiedtextlabel sizeToFit];
    
    
  
    id userInfo = [jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"]) mutableCopy];
    [userInfo setObject:@"yes" forKey:@"idVerifyStatus"];
    [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];
    [[PDKeychainBindings sharedKeychainBindings] setObject:@"yes" forKey:@"profileFlag"];
    delay(2, ^{
        self.idverifiedalertview.hidden = YES;
    });
    delay(3, ^{
        [self destroyDetector];
        [self returnFun];
    });
    
    
}

// This is a convenience method that is called by the detector:hasResults:forImage:atTime: delegate method below.
// It handles all UNPROCESSED images from the detector. Here I am displaying those images on the camera view.
- (void)unprocessedImageReady:(AFDXDetector *)detector image:(UIImage *)image atTime:(NSTimeInterval)time;
{
    IDViewController * __weak weakSelf = self;
    if(isImageDetecting){
        self.idverifiedalertview.hidden = NO;
        NSString *textContent = isImageDetecting?@"There is not face!":@"Please make correct image!";
        NSRange textRange = NSMakeRange(0, textContent.length);
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
        UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:22];
        [textString addAttribute:NSFontAttributeName value:font range:textRange];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1.18;
        [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        self.idverifiedtextlabel.attributedText = textString;
        [self.idverifiedtextlabel sizeToFit];
//        return;
    }
    // UI work must be done on the main thread, so dispatch it there.
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.cameraView setImage:image];
        weakSelf.cameraView.contentMode = UIViewContentModeScaleAspectFill;
       
    });
}
-(void) notVerified{
    self.idverifiedalertview.hidden = NO;
    NSString *textContent = isImageDetecting?@"There is not face!":@"Please make correct image!";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:22];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.18;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    self.idverifiedtextlabel.attributedText = textString;
    [self.idverifiedtextlabel sizeToFit];
    
    delay(2, ^{
        self.idverifiedalertview.hidden = YES;
    });
    delay(4, ^{
        [self destroyDetector];
        [self returnFun];
    });
}
- (void)destroyDetector;
{
    [self.detector stop];
}

- (void)createDetector;
{
    
    // ensure the detector has stopped
    [self destroyDetector];
    
    // iterate through the capture devices to find the front position camera
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == AVCaptureDevicePositionFront)
        {
            self.detector = [[AFDXDetector alloc] initWithDelegate:self
                                                usingCaptureDevice:device
                                                      maximumFaces:1];
            self.detector.maxProcessRate = 5;
            
            // turn on all classifiers (emotions, expressions, and emojis)
            [self.detector setDetectAllEmotions:YES];
            [self.detector setDetectAllExpressions:YES];
            [self.detector setDetectEmojis:YES];
           
            
            // turn on gender and glasses
            self.detector.gender = TRUE;
            self.detector.glasses = TRUE;
            
            
            // start the detector and check for failure
            NSError *error = [self.detector start];
            
            if (nil != error)
            {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detector Error"
//                                                                               message:[error localizedDescription]
//                                                                        preferredStyle:UIAlertControllerStyleAlert];
//
//                [self presentViewController:alert animated:YES completion:
//                 ^{}
//                 ];
                
                return;
            }
            
            break;
        }
    }
}

- (void)createDetectorForImage;
{
    
    // ensure the detector has stopped
    [self destroyDetector];
    
    self.detector = [[AFDXDetector alloc] initWithDelegate:self
                                        discreteImages:true maximumFaces:1];
    self.detector.maxProcessRate = 5;
    [self.detector processImage:[UIImage imageWithContentsOfFile:[jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"images"]) mutableCopy][self.indexOfNotPlaceHolder]]];
    // turn on all classifiers (emotions, expressions, and emojis)
    [self.detector setDetectAllEmotions:YES];
    [self.detector setDetectAllExpressions:YES];
    [self.detector setDetectEmojis:YES];
    
    
    // turn on gender and glasses
    self.detector.gender = TRUE;
    self.detector.glasses = TRUE;
    
    
    // start the detector and check for failure
    NSError *error = [self.detector start];
    
    if (nil != error)
    {
        //                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detector Error"
        //                                                                               message:[error localizedDescription]
        //                                                                        preferredStyle:UIAlertControllerStyleAlert];
        //
        //                [self presentViewController:alert animated:YES completion:
        //                 ^{}
        //                 ];
        
        return;
    }

}


#pragma mark -
#pragma mark AFDXDetectorDelegate Methods

// This is the delegate method of the AFDXDetectorDelegate protocol. This method gets called for:
// - Every frame coming in from the camera. In this case, faces is nil
// - Every PROCESSED frame that the detector
- (void)detector:(AFDXDetector *)detector hasResults:(NSMutableDictionary *)faces forImage:(UIImage *)image atTime:(NSTimeInterval)time;
{
    if (nil == faces)
    {
        [self unprocessedImageReady:detector image:image atTime:time];
    }
    else
    {
//        UIImage *profileImage = [jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"images"]) mutableCopy][self.indexOfNotPlaceHolder];
//        [self processedImageReady:detector image:profileImage faces:faces atTime:time];
        [self processedImageReady:detector image:image faces:faces atTime:time];
    }
}


#pragma mark -
#pragma mark View Methods

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    isImageDetecting = true;
    unRecognizedIndex = 0;
//    [self createDetector]; // create the dector just before the view appears
    

}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"%d",self.indexOfNotPlaceHolder);
    self.idverifiedalertview.hidden = YES;
    self.idverifiedalertview.layer.cornerRadius = 18;
    self.idverifiedalertview.layer.backgroundColor = [UIColor colorWithRed:0.96 green:0.49 blue:0.39 alpha:1].CGColor;
    
    self.idverifiedtextlabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.idverifiedtextlabel.numberOfLines = 0;
    self.idverifiedtextlabel.textColor = [UIColor whiteColor];
    NSString *textContent = @"Identity verified!";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:22];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.18;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    self.idverifiedtextlabel.attributedText = textString;
    [self.idverifiedtextlabel sizeToFit];
    
    [self createDetectorForImage];
    
}
- (void)viewWillDisappear:(BOOL)animated;
{
    [super viewWillDisappear:animated];
    [self destroyDetector]; // destroy the detector before the view disappears
}
- (IBAction)returnButtonAction:(id)sender {
    [self returnFun];
}

- (void)didReceiveMemoryWarning;
{
    [super didReceiveMemoryWarning];
}

@end
