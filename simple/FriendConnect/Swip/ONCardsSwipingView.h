//
//  MXCardsSwipingView.h
//  Mixer
//
//  Created by Scott Kensell on 6/21/16.
//  Copyright © 2016 Two To Tango. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MXCardDestination) {
    MXCardDestinationCenter = 0,
    MXCardDestinationLeft,
    MXCardDestinationRight,
    MXCardDestinationUp
};
@class ONCardsSwipingView;

@protocol MXSwipableCard <NSObject>
@optional
- (UIView*)viewShownOnSwipeLeft;
- (UIView*)viewShownOnSwipeRight;
- (UIView*)viewShownOnSwipeUp;
- (void)prepareToBecomeTopCard; // changes will be animated
- (void)prepareToBecomeBackgroundCard;

@end

@protocol MXCardsSwipingViewDelegate <NSObject>

/**
 Called when `card` is dismissed either by a finger swipe or programmatically by `dismissTopCardTo{Left,Right}`.
 `card` still counts towards the number returned from `numberOfCardsInQueue`, so subtract 1 to get the number left.
 
 return YES to continue dismissing the card or NO to cancel the dismissal and recenter the card.
 */
- (BOOL)cardsSwipingView:(ONCardsSwipingView*)cardsSwipingView willDismissCard:(UIView*)card destination:(MXCardDestination)destination;

@end

@interface ONCardsSwipingView : UIView

@property (nonatomic, weak) id<MXCardsSwipingViewDelegate> delegate;


/**
 Adds the card as a subview behind all the previously added cards.
 
 @param card If `card` implements `prepareToBecomeTopCard` or `prepareToBecomeBackgroundCard` of the
     `MXSwipableCard` protocol, then the appropriate one will be called, without animating the changes.
*/
- (void)enqueueCard:(UIView*)card;
- (UIView*)dismissTopCardToLeft;
- (UIView*)dismissTopCardToRight;
- (UIView*)dismissTopCardToUp;
- (NSUInteger)numberOfCardsInQueue;
- (void)clearQueue;

@end
