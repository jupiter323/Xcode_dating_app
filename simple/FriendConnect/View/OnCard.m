//
//  MXMemberCardView.m
//  Mixer
//
//  Created by Scott Kensell on 6/20/16.
//  Copyright © 2016 Two To Tango. All rights reserved.
//

#import "OnCard.h"

static const NSUInteger kMXCornerRadius = 6.0f;

@implementation OnCard {
    UIView* _innerClippedView;
    
    UIView* _topMatterView;
    
    // userArea
    UIImageView* _avatarImageView;
    UIView* _gradientView;
    UILabel* _categoryLabel;
    UILabel* _nameLabel;
    UILabel* _bioLabel;
    
    // during swipe
    UIImageView* _swipeLeftView;
    UIImageView* _swipeRightView;
    UIImageView* _swipeUpView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
//        [self setup];
    }
    return self;
}

- (void)setup:(SectionDefinition)someModel{
    // inner clipped view is necessary to have rounded corners clip to bounds and drop shadow on self simultaneously
    if(someModel == Center){
        _innerClippedView = [[UIView alloc] initWithFrame:self.frame];
        _innerClippedView.layer.cornerRadius = 14.7;
        _innerClippedView.layer.masksToBounds = YES;
        _innerClippedView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _innerClippedView.layer.borderWidth = 6.86f;
        [self addSubview:_innerClippedView];
    } else {
        _innerClippedView = [[UIView alloc] initWithFrame:self.frame];
        _innerClippedView.layer.cornerRadius = kMXCornerRadius;
        _innerClippedView.layer.masksToBounds = YES;
        [self addSubview:_innerClippedView];
    }
    
    //
    // top matter
    //
    
    _topMatterView = [[UIView alloc] init];
    _topMatterView.clipsToBounds = YES;
    _topMatterView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0];
    [_innerClippedView addSubview:_topMatterView];
    
    _avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImageView.layer.allowsEdgeAntialiasing = YES;
    [_topMatterView addSubview:_avatarImageView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.0] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor],
                       (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor], nil];
    gradient.locations = @[@0.0, @0.2, @0.5, @0.66, @0.8, @1.0];
    _gradientView = [[UIView alloc] init];
    [_gradientView.layer addSublayer:gradient];
//    [_topMatterView addSubview:_gradientView];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:10];
    _categoryLabel.textColor = [UIColor whiteColor];
    _categoryLabel.textAlignment = NSTextAlignmentCenter;
//    [_topMatterView addSubview:_categoryLabel];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
//    [_topMatterView addSubview:_nameLabel];
    
    _bioLabel = [[UILabel alloc] init];
    _bioLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:10];
    _bioLabel.textAlignment = NSTextAlignmentCenter;
    _bioLabel.textColor = [UIColor whiteColor];
//    [_topMatterView addSubview:_bioLabel];
    
    _swipeLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dislike"]];
    _swipeLeftView.hidden = YES;
    _swipeRightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like"]];
    _swipeRightView.hidden = YES;
    _swipeUpView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ignore"]];
    _swipeUpView.hidden = YES;
    
    [_innerClippedView addSubview:_swipeLeftView];
    [_innerClippedView addSubview:_swipeRightView];
    [_innerClippedView addSubview:_swipeUpView];
    //
    // Initialize heights of one-line labels
    //
    
    NSString* dummyString = @"ABCQ";
    for (UILabel* label in @[_categoryLabel, _nameLabel, _bioLabel]) {
        label.text = dummyString;
        [label sizeToFit];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _innerClippedView.frame = self.bounds;
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat userViewHeight = h*1.0;
    
    _topMatterView.frame = CGRectMake(0, 0, w, userViewHeight);
    
    _avatarImageView.frame = _topMatterView.bounds;
    _gradientView.frame = _avatarImageView.bounds;
    
    for (CALayer* layer in _gradientView.layer.sublayers) {
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            layer.frame = _gradientView.bounds;
            break;
        }
    }
    
    _categoryLabel.frame = CGRectMake(10, 14, w - 20, _categoryLabel.frame.size.height);
    
    CGFloat spaceFromBottom = 13.0f + _bioLabel.frame.size.height;
    _bioLabel.frame = CGRectMake(10, userViewHeight - spaceFromBottom, w - 20, _bioLabel.frame.size.height);
    spaceFromBottom += _nameLabel.frame.size.height;
    _nameLabel.frame = CGRectMake(10, userViewHeight - spaceFromBottom, w - 20, _nameLabel.frame.size.height);
    _swipeLeftView.frame = CGRectMake(w/2 - _swipeLeftView.frame.size.width/2, h/2-_swipeLeftView.frame.size.height/2, _swipeLeftView.frame.size.width, _swipeLeftView.frame.size.height);
    _swipeRightView.frame = CGRectMake(w/2 - _swipeRightView.frame.size.width/2, h/2-_swipeRightView.frame.size.height/2, _swipeRightView.frame.size.width, _swipeRightView.frame.size.height);
    _swipeUpView.frame = CGRectMake(w/2 - _swipeUpView.frame.size.width/2, h/2-_swipeUpView.frame.size.height/2, _swipeUpView.frame.size.width, _swipeUpView.frame.size.height);
}

- (void)setupWithAModel:(SectionDefinition)someModel {

    NSString* category = nil;
    NSString* name = nil;
    NSString* bio = nil;
    NSString* bottomTitle = nil;
    NSString* imageName = nil;
    category = @"good";
    name = @"Mohd";
    bio = @"Lucky man";
    bottomTitle = @"Lucky man";
    imageName = @"cityStudent";
    if (someModel == LeftSecion) {
        category = @"";
        name = @"";
        bio = @"";
        bottomTitle = @"";
        imageName = @"me";
    } else if (someModel == RightSection) {
        category = @"";
        name = @"";
        bio = @"";
        bottomTitle = @"";
        imageName = @"mypartner";
    }

    
    _categoryLabel.text = category;
    _nameLabel.text = name;
    _bioLabel.text = bio;
    _avatarImageView.image = [UIImage imageNamed:imageName];
    
    [self setNeedsLayout];
}

- (void)addShadow {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.layer.shadowOpacity = 0.25f;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:kMXCornerRadius].CGPath;
}

+ (CGFloat)aspectRatio {
    return 0.8598;
}

#pragma mark - MXSwipableCard

- (UIView *)viewShownOnSwipeLeft {
    return _swipeLeftView;
}

- (UIView *)viewShownOnSwipeRight {
    return _swipeRightView;
}
- (UIView *)viewShownOnSwipeUp {
    return _swipeUpView;
}

- (void)prepareToBecomeTopCard {
    _topMatterView.alpha = 1.0f;
    self.transform = CGAffineTransformIdentity;
}

- (void)prepareToBecomeBackgroundCard {
    _topMatterView.alpha = 0.25f;
    self.transform = [OnCard transformOfNextCard];
}

+ (CGAffineTransform)transformOfNextCard {
    static int i = 0;
    i = (i+1)%3;
    if (i == 0) {
        return CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI / 180), 0, -5);
    } else if (i == 1) {
        return CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI / 180), -5, 0);
    } else {
        return CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI / 180), 0, 3);
    }
}

@end


