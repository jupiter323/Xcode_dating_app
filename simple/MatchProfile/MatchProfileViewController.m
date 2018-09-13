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
    //slide
    imagesArray = [[NSMutableArray alloc] initWithObjects:@"bikiniGirl", @"cityStudent", @"jumpingMan", @"sunglassesGirl", nil];
    
//    _autoPlayToggle.on = _AUTO_SCROLL_ENABLED;
    
    slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
    slider.delegate = self;
    [self.imageSlideView addSubview:slider];
    [slider createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED inView:self.view];
    slider.frame = CGRectMake(0, 0, self.view.bounds.size.width, 376.0f);
    
    //
    UILabel *textLayer = [[UILabel alloc] initWithFrame:CGRectMake(20, 408, 119, 58)];
    textLayer.lineBreakMode = NSLineBreakByWordWrapping;
    textLayer.numberOfLines = 0;
    textLayer.textColor = [UIColor colorWithRed:0.44 green:0.43 blue:0.43 alpha:1];
    NSString *textContent = @"Michael,   31 Engineer    6’0”";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:15];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.33;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    textLayer.attributedText = textString;
    [textLayer sizeToFit];
    [[self view] addSubview:textLayer];
    
    //
    textLayer = [[UILabel alloc] initWithFrame:CGRectMake(22, 494, 57, 36)];
    textLayer.lineBreakMode = NSLineBreakByWordWrapping;
    textLayer.numberOfLines = 0;
    textLayer.textColor = [UIColor colorWithRed:0.44 green:0.43 blue:0.43 alpha:1];
    textLayer.textAlignment = NSTextAlignmentCenter;
    textContent = @"About";
    textRange = NSMakeRange(0, textContent.length);
    textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    font = [UIFont fontWithName:@"GothamRounded-Medium" size:18];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.22;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    textLayer.attributedText = textString;
    [textLayer sizeToFit];
    [[self view] addSubview:textLayer];
    
    //
    textLayer = [[UILabel alloc] initWithFrame:CGRectMake(22, 508, 333, 81)];
    textLayer.lineBreakMode = NSLineBreakByWordWrapping;
    textLayer.numberOfLines = 0;
    textLayer.textColor = [UIColor colorWithRed:0.44 green:0.43 blue:0.43 alpha:1];
    textContent = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ornare non lacus ac mattis. Sed condimentum mattis vehicula.";
    textRange = NSMakeRange(0, textContent.length);
    textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    font = [UIFont fontWithName:@"GothamRounded-Book" size:14];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.21;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    textLayer.attributedText = textString;
    [textLayer sizeToFit];
    [[self view] addSubview:textLayer];
}
- (IBAction)return:(id)sender {
    [self returnFun];
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
