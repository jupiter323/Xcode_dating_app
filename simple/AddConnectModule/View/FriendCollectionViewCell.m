//
//  FriendCollectionViewCell.m
//  Korte
//
//  Created by Peace on 9/6/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "FriendCollectionViewCell.h"

@implementation FriendCollectionViewCell{
    CABasicAnimation *vibAnimation;
    UILongPressGestureRecognizer *lpgr;
}
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(void)dataConfig {
    //vibanimation setting
    vibAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    vibAnimation.duration = 0.2;
    vibAnimation.byValue = @(5);
    vibAnimation.autoreverses = YES;
    vibAnimation.repeatCount = 50;
    // long press gesture setting
    lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    
    
    //
    switch (self.status) {
        case AddingConnectButton://////adding connect button
            [self.avatar setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
//                            self.avatar.layer.frame = CGRectMake(0, 0, 2*r, 2*r);
            self.avatar.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.17].CGColor;
            self.avatar.layer.borderWidth = 2;
            self.avatar.layer.borderColor = [[UIColor whiteColor] CGColor];
            self.avatar.layer.cornerRadius = 30;
            [self.avatar addTarget:self action:@selector(goToMeSwiping:) forControlEvents:UIControlEventTouchUpInside];
            
            self.name.hidden = YES;
            self.subCloseButton.hidden = YES;
            self.subConnectButton.hidden = YES;
            self.tapToButton.hidden = YES;
            self.percentView.hidden = YES;
            break;
        case LoadingState://////loading state avatar
            self.subCloseButton.hidden = YES;
            self.subConnectButton.hidden = YES;
            self.tapToButton.hidden = YES;
            [self.avatar addSubview:self.percentView];
            
            break;
        case LoadedState://////loaded state avatar
            self.subCloseButton.hidden = YES;
            self.tapToButton.hidden = YES;
            self.percentView.hidden = YES;
            [self.avatar addGestureRecognizer:lpgr];
        // spline
            break;
        case TapToConnectState://////tapTo
            self.subCloseButton.hidden = YES;
            self.subConnectButton.hidden = YES;
            self.percentView.hidden = YES;
            [self.avatar addSubview:self.tapToButton];
            
            break;
        case DisappearedState://////disappeared
            self.subCloseButton.hidden = YES;
            self.subConnectButton.hidden = YES;
            self.avatar.hidden = YES;
            self.name.hidden = YES;
            self.tapToButton.hidden = YES;
            self.percentView.hidden = YES;
            break;
    }
 
    NSLog(@"configed");
    
}
-(void)goToMeSwiping:(UIButton *) sender{
    NSLog(@"goTome Swipping");
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    //    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
    //        return;
    //    }
    //    CGPoint p = [gestureRecognizer locationInView:self.view];
    //
    //    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    //    if (indexPath == nil){
    //        NSLog(@"couldn't find index path");
    //    } else {
    //        // get the cell at indexPath (the one you long pressed)
    //        FriendCollectionViewCell* cell =
    //        [self.collectionView cellForItemAtIndexPath:indexPath];
    //
    //        [[cell init] vibrate];
    //        // do stuff with the cell
    //    }
    NSLog(@"vibrate");
    [self.avatar.layer addAnimation:vibAnimation forKey:@"Shake"];
    self.subCloseButton.hidden = NO;
    [self.subCloseButton.layer addAnimation:vibAnimation forKey:@"Shake"];
    [self.subConnectButton.layer addAnimation:vibAnimation forKey:@"Shake"];
    
}
@end
