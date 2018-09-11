//
//  MatchProfileViewController.m
//  Korte
//
//  Created by Peace on 9/10/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "MatchProfileViewController.h"
#define _AUTO_SCROLL_ENABLED 1


@interface MatchProfileViewController (){
    NSMutableArray *imagesArray;
    SBSliderView *slider;
}
@end

@implementation MatchProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    imagesArray = [[NSMutableArray alloc] initWithObjects:@"bikiniGirl", @"cityStudent", @"jumpingMan", @"sunglassesGirl", nil];
    
//    _autoPlayToggle.on = _AUTO_SCROLL_ENABLED;
    
    slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
    slider.delegate = self;
    [self.view addSubview:slider];
    [slider createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED inView:self.view];
    slider.frame = CGRectMake(0, 0, self.view.bounds.size.width, 376.0f);
}

//- (void)sbslider:(SBSliderView *)sbslider didTapOnImage:(UIImage *)targetImage andParentView:(UIImageView *)targetView {
//    
//    SBPhotoManager *photoViewerManager = [[SBPhotoManager alloc] init];
//    [photoViewerManager initializePhotoViewerFromViewControlller:self forTargetImageView:targetView withPosition:sbslider.frame];
//}

//- (IBAction)toggleAutoPlay:(id)sender {
//
//    UISwitch *toggleSwitch = (UISwitch *)sender;
//
//    if ([toggleSwitch isOn]) {
//        [slider startAutoPlay];
//    } else {
//        [slider stopAutoPlay];
//    }
//}

//- (IBAction)tappedOnSampleImage:(id)sender {
//
//    UIGestureRecognizer *gesture = (UIGestureRecognizer *)sender;
//    UIImageView *targetView = (UIImageView *)gesture.view;
//
//    SBPhotoManager *photoViewerManager = [[SBPhotoManager alloc] init];
//    [photoViewerManager initializePhotoViewerFromViewControlller:self forTargetImageView:targetView withPosition:targetView.frame];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
