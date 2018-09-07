//
//  FriendCollectionViewCell.h
//  Korte
//
//  Created by Peace on 9/6/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCollectionViewCell : UICollectionViewCell <UIGestureRecognizerDelegate>
typedef NS_ENUM(NSInteger, CellStatus) {
    AddingConnectButton = 0,
    LoadingState,
    LoadedState,
    CloseState,
    TapToConnectState,
    DisappearedState
};
@property (weak, nonatomic) IBOutlet UIButton *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *subCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *subConnectButton;
@property (weak, nonatomic) IBOutlet UIView *percentView;
@property (weak, nonatomic) IBOutlet UIButton *tapToButton;
@property (nonatomic, readwrite) CellStatus status;

- (instancetype)init;
-(void)dataConfig;
@end
