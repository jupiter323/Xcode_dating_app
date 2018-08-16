//
//  MXCardsSwipingView.m
//  Mixer
//
//  Created by Scott Kensell on 6/20/16.
//  Copyright © 2016 Two To Tango. All rights reserved.
//

#import "MXCardsSwipingView.h"



static const CGFloat kMXMinimumSpeedForDismissal = 80.0f;
static const CGFloat kMXDistanceFromCenterDismissalThreshold = 30.0f;
static const CGFloat kMXDistanceFromCenterShowViewsThreshold = 10.0f;

@interface MXCardsSwipingView()

@property (nonatomic, strong) NSMutableArray <UIView*>* cards;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, strong) UIAttachmentBehavior* attachment;
@property (nonatomic, assign) CGPoint centerPointOfCardStack;

@end

@implementation MXCardsSwipingView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.cards = [[NSMutableArray alloc] init];
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGesture];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.centerPointOfCardStack = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    [self centerCards:self.cards];
}

- (void)centerCards:(NSArray*)cards {
    for (UIView* card in cards) {
        if (![self.attachment.items containsObject:card]) {
            card.center = self.centerPointOfCardStack;
        }
    }
}

- (UIView*)topCard {
    return self.cards.firstObject;
}

- (void)enqueueCard:(UIView *)card {
    if (self.cards.count > 0) {
        [MXCardsSwipingView prepareToBecomeBackgroundCard:card];
        [self insertSubview:card belowSubview:self.cards.lastObject];
    } else {
        [MXCardsSwipingView prepareToBecomeTopCard:card];
        [self addSubview:card];
    }
    [self.cards addObject:card];
}

- (void)clearQueue {
    [self.cards makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.cards removeAllObjects];
}

- (UIView*)dismissTopCardToLeft {
    return [self dismissTopCard:MXCardDestinationLeft];
}

- (UIView*)dismissTopCardToRight {
    
    return [self dismissTopCard:MXCardDestinationRight];
}

- (UIView*)dismissTopCardToUp {
  return [self dismissTopCard:MXCardDestinationUp];
    
}

- (UIView*)dismissTopCard:(MXCardDestination)destination{
    
    UIView* topCard = [self topCard];
    if (!topCard || ![self.delegate cardsSwipingView:self willDismissCard:topCard destination:destination]) {
        return nil;
    }
    UIAttachmentBehavior* attachment = [self attachCard:topCard ToPoint:CGPointMake(topCard.center.x, topCard.center.y + 40)];
    [self.animator addBehavior:attachment];
    
    CGPoint newAnchor;
    UIView* accessoryView;
    switch (destination) {
        case MXCardDestinationLeft:
            newAnchor = CGPointMake(-topCard.frame.size.height, topCard.center.y);
            accessoryView = [MXCardsSwipingView viewShownOnSwipeLeftForCard:topCard];
            break;
        case MXCardDestinationRight:
            newAnchor = CGPointMake(self.bounds.size.width + topCard.frame.size.height, topCard.center.y);
            accessoryView = [MXCardsSwipingView viewShownOnSwipeRightForCard:topCard];
            break;
        case MXCardDestinationUp:
            newAnchor = CGPointMake(topCard.center.x, -topCard.frame.size.height);
            accessoryView = [MXCardsSwipingView viewShownOnSwipeUpForCard:topCard];
            break;
        default:
            NSLog(@"default");
            newAnchor = CGPointMake(self.bounds.size.width + topCard.frame.size.height, topCard.center.y);
            accessoryView = [MXCardsSwipingView viewShownOnSwipeRightForCard:topCard];
            break;
    }
  
    accessoryView.hidden = NO;
    accessoryView.alpha = 1.0f;
    [self dismissCard:topCard toPoint:newAnchor viaAttachment:attachment];
    return topCard;
}

- (UIAttachmentBehavior*)attachCard:(UIView*)card ToPoint:(CGPoint)location {
    
    return [[UIAttachmentBehavior alloc] initWithItem:card offsetFromCenter:UIOffsetMake(location.x - card.center.x, location.y - card.center.y) attachedToAnchor:location];
}

- (void)pan:(UIPanGestureRecognizer*)gesture {
    
    UIView* topCard = [self topCard];
    if (!topCard) {
        return;
    }
    CGPoint location = [gesture locationInView:self];
    CGPoint velocity = [gesture velocityInView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.attachment = [self attachCard:topCard ToPoint:location];
        [self.animator addBehavior:self.attachment];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        //
        self.attachment.anchorPoint = location;
        [self showLeftOrRightOrUpViewsOnCard:topCard];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [self showLeftOrRightOrUpViewsOnCard:topCard];
        
        MXCardDestination destination = [self destinationForCard:topCard];
        
        if (destination == MXCardDestinationCenter) {
            [self restoreTopCardToCenter];
        } else {
                      
            BOOL continueDismissing = [self.delegate cardsSwipingView:self willDismissCard:topCard destination:destination];
            
            if (!continueDismissing) {
                [self restoreTopCardToCenter];
                return;
            }
            
            if (destination == MXCardDestinationLeft && velocity.x > -kMXMinimumSpeedForDismissal) {
                velocity = CGPointMake(-kMXMinimumSpeedForDismissal, 0);
            } else if (destination == MXCardDestinationRight && velocity.x < kMXMinimumSpeedForDismissal) {
                velocity = CGPointMake(kMXMinimumSpeedForDismissal, 0);
            }if(destination == MXCardDestinationUp && velocity.y > -kMXMinimumSpeedForDismissal){
                velocity = CGPointMake(0, -kMXMinimumSpeedForDismissal);
            }
            CGPoint newAnchor = [self movePoint:location withVelocity:velocity offScreenHorizontallyByAtLeast:topCard.frame.size.height];
            [self dismissCard:topCard toPoint:newAnchor viaAttachment:self.attachment];
        }
        
    } else if (gesture.state == UIGestureRecognizerStateFailed || gesture.state == UIGestureRecognizerStateCancelled) {
        [self restoreTopCardToCenter];
    }
}

- (MXCardDestination)destinationForCard:(UIView*)card {
    if (card.center.x < (self.centerPointOfCardStack.x - kMXDistanceFromCenterDismissalThreshold)) {
        return MXCardDestinationLeft;
    } else if (card.center.x > (self.centerPointOfCardStack.x + kMXDistanceFromCenterDismissalThreshold)) {
        return MXCardDestinationRight;
    } else if (card.center.y < (self.centerPointOfCardStack.y - kMXDistanceFromCenterDismissalThreshold)) {
        return MXCardDestinationUp;
    } else {
        return MXCardDestinationCenter;
    }
}

- (void)showLeftOrRightOrUpViewsOnCard:(UIView*)card {
    UIView* leftView = [MXCardsSwipingView viewShownOnSwipeLeftForCard:card];
    UIView* rightView = [MXCardsSwipingView viewShownOnSwipeRightForCard:card];
    UIView* upView = [MXCardsSwipingView viewShownOnSwipeUpForCard:card];
    if (!leftView && !rightView &&!upView) {
        return;
    }
    CGFloat threshold = kMXDistanceFromCenterShowViewsThreshold;
    CGFloat viewAlpha = MIN(MAX(0,(ABS(self.centerPointOfCardStack.x - card.center.x) - threshold)/(kMXDistanceFromCenterDismissalThreshold - threshold)),1);
//    CGFloat deltaX = abs(card.center.x-self.centerPointOfCardStack.x);
//    CGFloat deltaY = abs(card.center.y-self.centerPointOfCardStack.y);

    if (card.center.x < (self.centerPointOfCardStack.x - threshold)) {
        leftView.hidden = NO;
        rightView.hidden = YES;
        upView.hidden = YES;
        leftView.alpha = viewAlpha;
    } else if (card.center.x > (self.centerPointOfCardStack.x + threshold)) {
        leftView.hidden = YES;
        rightView.hidden = NO;
        upView.hidden =YES;
        rightView.alpha = viewAlpha;
    } else if (card.center.y < (self.centerPointOfCardStack.y - threshold)) {
        
        viewAlpha = MIN(MAX(0,(ABS(self.centerPointOfCardStack.y - card.center.y) - threshold)/(kMXDistanceFromCenterDismissalThreshold - threshold)),1);
        leftView.hidden = YES;
        rightView.hidden = YES;
        upView.hidden= NO;
        upView.alpha = viewAlpha;
    } else {
        leftView.hidden = YES;
        rightView.hidden = YES;
        upView.hidden=YES;
    }
}

- (CGPoint)movePoint:(CGPoint)point withVelocity:(CGPoint)velocity offScreenHorizontallyByAtLeast:(CGFloat)offscreenPoints {
    CGPoint newPoint = point;
    if (velocity.x < 0) {
        while (newPoint.x > -offscreenPoints) {
            newPoint = CGPointMake(newPoint.x + velocity.x, newPoint.y + velocity.y);
        }
    } else if (velocity.x > 0) {
        while (newPoint.x < self.bounds.size.width + offscreenPoints) {
            newPoint = CGPointMake(newPoint.x + velocity.x, newPoint.y + velocity.y);
        }
    } else {
        while (newPoint.y > -offscreenPoints) {
            newPoint = CGPointMake(newPoint.x + velocity.x, newPoint.y + velocity.y);
        }
    }
    return newPoint;
}

- (void)dismissCard:(UIView*)card toPoint:(CGPoint)newAnchor viaAttachment:(UIAttachmentBehavior*)attachment {
    [self.cards removeObject:card];
    attachment.frequency = 1.0f;
    attachment.damping = 1.0f;
    attachment.anchorPoint = newAnchor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animator removeBehavior:attachment];
        [card removeFromSuperview];
    });
    UIView* nextCard = [self topCard];
    if (nextCard) {
        [UIView animateWithDuration:0.3 animations:^{
            [MXCardsSwipingView prepareToBecomeTopCard:nextCard];
        }];
    }
}

- (void)restoreTopCardToCenter {
    [self.animator removeBehavior:self.attachment];
    UIView* topCard = [self topCard];
    UIView* leftView = [MXCardsSwipingView viewShownOnSwipeLeftForCard:topCard];
    UIView* rightView = [MXCardsSwipingView viewShownOnSwipeRightForCard:topCard];
    UIView* upView = [MXCardsSwipingView viewShownOnSwipeUpForCard:topCard];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        leftView.alpha = 0.0f;
        rightView.alpha = 0.0f;
        upView.alpha = 0.0f;
        topCard.center = self.centerPointOfCardStack;
        topCard.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        leftView.hidden = YES;
        rightView.hidden = YES;
        upView.hidden = YES;
    }];
}

- (NSUInteger)numberOfCardsInQueue {
    return self.cards.count;
}

+ (UIView*)viewShownOnSwipeLeftForCard:(UIView*)card {
    return ([card conformsToProtocol:@protocol(MXSwipableCard)] && [card respondsToSelector:@selector(viewShownOnSwipeLeft)]) ? [((id<MXSwipableCard>) card) viewShownOnSwipeLeft] : nil;
}

+ (UIView*)viewShownOnSwipeRightForCard:(UIView*)card {
    return ([card conformsToProtocol:@protocol(MXSwipableCard)] && [card respondsToSelector:@selector(viewShownOnSwipeRight)]) ? [((id<MXSwipableCard>) card) viewShownOnSwipeRight] : nil;
}

+ (UIView*)viewShownOnSwipeUpForCard:(UIView*)card {
    return ([card conformsToProtocol:@protocol(MXSwipableCard)] && [card respondsToSelector:@selector(viewShownOnSwipeUp)]) ? [((id<MXSwipableCard>) card) viewShownOnSwipeUp] : nil;
}

+ (void)prepareToBecomeTopCard:(UIView*)card {
    if ([card conformsToProtocol:@protocol(MXSwipableCard)] && [card respondsToSelector:@selector(prepareToBecomeTopCard)]) {
        [((id<MXSwipableCard>) card) prepareToBecomeTopCard];
    }
}

+ (void)prepareToBecomeBackgroundCard:(UIView*)card {
    if ([card conformsToProtocol:@protocol(MXSwipableCard)] && [card respondsToSelector:@selector(prepareToBecomeBackgroundCard)]) {
        [((id<MXSwipableCard>) card) prepareToBecomeBackgroundCard];
    }
}


@end
