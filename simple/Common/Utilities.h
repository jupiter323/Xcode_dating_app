//
//  Utilities.h
//  MKDropdownMenuExample
//
//  Created by Max Konovalov on 17/03/16.
//  Copyright © 2016 Max Konovalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//enum definition
typedef NS_ENUM(NSInteger, SectionDefinition) {//for two cards
    LeftSecion = 0,
    RightSection,
    Center
};
typedef NS_ENUM(NSInteger, ThemDefinition) {//for Theme distinguish
    StandardTheme = 0,
    ProTheme
};
typedef NS_ENUM(NSInteger, DropdownComponents) {//drop down
    DropdownComponentShape = 0,
    DropdownComponentColor,
    DropdownComponentsCount
};
typedef NS_ENUM(NSInteger, MXCardDestination) {//tinder card
    MXCardDestinationCenter = 0,
    MXCardDestinationLeft,
    MXCardDestinationRight,
    MXCardDestinationUp
};

static UIView* copyView(UIView * view) {
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: view];
    UIView* copy = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    return copy;
}
//delay(0.15, ^{[dropdownMenu closeAllComponentsAnimated:YES];});
static inline void delay(NSTimeInterval delay, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}
//self.view.backgroundColor = UIColorWithHexString(@"#166BB5");
static UIColor * UIColorWithHexString(NSString *hex) {
    unsigned int rgb = 0;
    [[NSScanner scannerWithString:
      [[hex uppercaseString] stringByTrimmingCharactersInSet:
       [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEF"] invertedSet]]]
     scanHexInt:&rgb];
    return [UIColor colorWithRed:((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0
                            blue:((CGFloat)(rgb & 0xFF)) / 255.0
                           alpha:1.0];
}

//standard color
static UIColor * StandardColor(){
    return UIColorWithHexString(@"ff9933");
}

//bottom style color
static UIColor * BottomColor(){
    return UIColorWithHexString(@"EF7D68");
}

static UIImage * croppIngimageByImageName(UIImage * imageToCrop, CGRect rect)
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}
static UIImage* imageWithBorderFromImage(UIImage* source)
{
    CGSize size = [source size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.5, 1.0, 1.0);
    CGContextStrokeRect(context, rect);
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
}
static UIImage * makeRoundedImage(UIImage * image,
 float radius)
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
   
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

static NSAttributedString* attributedString(NSString * contentString, UIColor * color, CGFloat fontSize){
    NSString *textContent = contentString;
    UIColor *textColor = color?color:StandardColor();
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:textContent
     attributes:
     @{
       NSForegroundColorAttributeName:textColor,
       NSKernAttributeName : @(fontSize)
       }];
    return attributedString;
    
}
static NSString* jsonStringify(NSDictionary *arr){
    NSError *error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    return jsonString;
}
