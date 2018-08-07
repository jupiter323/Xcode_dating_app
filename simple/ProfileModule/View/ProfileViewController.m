//
//  ProfileViewController.m
//  simple
//
//  Created by Peace on 8/4/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "ProfileViewController.h"
#import "MXMemberCardView.h"
#import "LSFloatingActionMenu.h"
#import "MKDropdownMenu.h"
#import "Utilities.h"

NS_ENUM(NSInteger, DropdownComponents) {
    DropdownComponentShape = 0,
    DropdownComponentColor,
    DropdownComponentsCount
};
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIView *dropdownCateContainView;
@property (weak, nonatomic) IBOutlet UIView *dropdownContainView;
@property (weak, nonatomic) IBOutlet UIView *imagesContainView;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@property (strong, nonatomic) UIButton *visibleORU;
@property bool visible;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //init data
    self.visible = true;
//    dropdown contain
    MKDropdownMenu *dropdownMenu = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, self.dropdownContainView.bounds.size.width,self.dropdownContainView.bounds.size.height )];
    dropdownMenu.dataSource = self;
    dropdownMenu.delegate = self;
    dropdownMenu.layer.cornerRadius = 4;
    dropdownMenu.clipsToBounds = YES;
    dropdownMenu.layer.borderWidth = 0.9f;
    dropdownMenu.layer.borderColor = StandardColor().CGColor;
    
    
    [self.dropdownContainView addSubview:dropdownMenu];
    //    dropdown containcate
    MKDropdownMenu * dropdownMenu1 = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, self.dropdownCateContainView.bounds.size.width,self.dropdownCateContainView.bounds.size.height )];
    dropdownMenu1.dataSource = self;
    dropdownMenu1.delegate = self;
    dropdownMenu1.layer.cornerRadius = 4;
    dropdownMenu1.clipsToBounds = YES;
    dropdownMenu1.layer.borderWidth = 0.9f;
    dropdownMenu1.layer.borderColor = StandardColor().CGColor;
    
//    //dropdown style
//    dropdownMenu1.layer.borderColor = [[UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1.0] CGColor];
//    dropdownMenu1.layer.borderWidth = 0.5;

    UIColor *selectedBackgroundColor = [UIColor colorWithRed:0.91 green:0.92 blue:0.94 alpha:1.0];
    dropdownMenu1.selectedComponentBackgroundColor = selectedBackgroundColor;
    dropdownMenu1.dropdownBackgroundColor = selectedBackgroundColor;

    dropdownMenu1.dropdownShowsTopRowSeparator = YES;
    dropdownMenu1.dropdownShowsBottomRowSeparator = NO;
    dropdownMenu1.dropdownShowsBorder = YES;

    dropdownMenu1.backgroundDimmingOpacity = 0.05;
    
    [self.dropdownCateContainView addSubview:dropdownMenu1];

    //    float buttons menu
    UIButton *floatingButton = [[UIButton alloc] init];
    [floatingButton setImage:[UIImage imageNamed:@"pro_menu"] forState:UIControlStateNormal];
    [floatingButton sizeToFit];
    floatingButton.frame = CGRectMake(20,20, floatingButton.bounds.size.width, floatingButton.bounds.size.height);
    [floatingButton addTarget:self action:@selector(tapedToggle:) forControlEvents:UIControlEventTouchUpInside];
    //    visible or unvisible button
    self.visibleORU = [[UIButton alloc] init];
    if(self.visible)
    {
        NSLog(@"visible");
        [self.visibleORU setImage:[UIImage imageNamed:@"vi"] forState:UIControlStateNormal];
    } else
        [self.visibleORU setImage:[UIImage imageNamed:@"inVi"] forState:UIControlStateNormal];
    [self.visibleORU sizeToFit];
    self.visibleORU.frame = CGRectMake(self.view.bounds.size.width-20-self.visibleORU.bounds.size.width, 20, self.visibleORU.bounds.size.width, self.visibleORU.bounds.size.height);
    [self.visibleORU addTarget:self action:@selector(visibleOrInvisible:) forControlEvents:UIControlEventTouchUpInside];
    
    //    contain style
    //    UIView *contain = [[UIView alloc] init];
    //    contain.frame = CGRectMake(0, self.view.bounds.size.height/5, self.view.bounds.size.width, self.view.bounds.size.height- self.view.bounds.size.height/5);
    //    contain.backgroundColor = [UIColor whiteColor];
    
    //    avatar
    UIButton *avatar = [[UIButton alloc] init];
    avatar.frame = CGRectMake(self.view.bounds.size.width/2-self.view.bounds.size.width/12, self.view.bounds.size.height/5-self.view.bounds.size.width/18, self.view.bounds.size.width/6, self.view.bounds.size.width/6);
    [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [avatar addTarget:self action:@selector(goBackToTinder:) forControlEvents:UIControlEventTouchUpInside];
    avatar.layer.cornerRadius = avatar.frame.size.width / 2;
    avatar.clipsToBounds = YES;
    avatar.layer.borderWidth = 5.0f;
    avatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    //    adding part
    //    [self.view addSubview:contain];
    [self.view addSubview:avatar];
    [self.view addSubview:floatingButton];
    [self.view addSubview:self.visibleORU];
    
    //    images and video
    
    for(int i=0;i<6;i++){
        
        UIImageView *image1 = [[UIImageView alloc] init];
        CGFloat buttonWidth = self.view.bounds.size.width/5;
        CGFloat buttonSide = (self.view.bounds.size.width-60-3*buttonWidth)/2;
        CGFloat buttonLocH =30;
        if(i>2)
            buttonLocH =buttonLocH+buttonWidth+20;
        image1.frame = CGRectMake(30+i%3*buttonWidth+i%3*buttonSide,buttonLocH , self.view.bounds.size.width/5, self.view.bounds.size.width/5);
        [image1 setImage:[UIImage imageNamed:@"sunglassesGirl"]];
        image1.contentMode =UIViewContentModeScaleAspectFill;
        image1.layer.cornerRadius = image1.frame.size.width / 2;
        image1.clipsToBounds = YES;
        image1.layer.borderWidth = 3.0f;
        image1.layer.borderColor = [UIColor redColor].CGColor;
        
        UIButton *image1button = [UIButton buttonWithType:UIButtonTypeCustom];
        [floatingButton sizeToFit];
        [image1button addTarget:self
                         action:@selector(deletAvatar:)
               forControlEvents:UIControlEventTouchDown];
        image1button.backgroundColor = [UIColor clearColor];
        [image1button setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        image1button.frame = CGRectMake(image1.frame.origin.x+2*image1.bounds.size.width/3, image1.frame.origin.y+2*image1.bounds.size.width/3, image1.bounds.size.width/3, image1.bounds.size.height/3);
        
        [self.imagesContainView addSubview:image1];
        [self.imagesContainView addSubview:image1button];
    }
    
    
    
    
    
}

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case DropdownComponentShape:
            return 3;
        case DropdownComponentColor:
            return 64;
       
        default:
            return 0;
    }
   
    
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 26;
}

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu widthForComponent:(NSInteger)component {
    switch (component) {
                    case DropdownComponentShape:
            return self.dropdownContainView.bounds.size.width;
        case DropdownComponentColor:
            return self.dropdownCateContainView.bounds.size.width;
            
        default:
            return 0;
    }
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
    switch (component) {
        case DropdownComponentShape:
            return [[NSAttributedString alloc] initWithString:@"Height"
                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:23 weight:UIFontWeightLight],
                                                                NSForegroundColorAttributeName: [UIColor blackColor]}];
        case DropdownComponentColor:
            return [[NSAttributedString alloc] initWithString:@"Everything"
                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:23 weight:UIFontWeightLight],
                                                                NSForegroundColorAttributeName: [UIColor blackColor]}];
        default:
            return 0;
    }
    
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSMutableAttributedString *string =
    [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%d: ", row + 1]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:23 weight:UIFontWeightLight],
                                                        NSForegroundColorAttributeName: [UIColor blackColor]}];
   
    return string;
}

//
- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component {
    return [UIColor colorWithWhite:0.0 alpha:0.5];
}


- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"component %d",component);
    switch (component) {
        case DropdownComponentShape:
            NSLog(@"DropdownComponentShape");
            break;
        case DropdownComponentColor:
            NSLog(@"DropdownComponentColor");
            break;
        default:
            break;
    }
    delay(0.15, ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
    });
  
}
//

-(void)deletAvatar:(id) senderID{
    NSLog(@"senderID");
    
}
-(void)visibleOrInvisible:(UIButton *) sender{
    self.visible = !self.visible;
    if(self.visible)
    {
        NSLog(@"visible");
        [sender setImage:[UIImage imageNamed:@"vi"] forState:UIControlStateNormal];
    } else
        [sender setImage:[UIImage imageNamed:@"inVi"] forState:UIControlStateNormal];
    
}

-(void)tapedToggle:(UIButton *) sender {
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionLeft];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
    self.visibleORU.hidden = YES;
    
    NSArray *menuIcons = @[@"pro_close", @"pro_match", @"pro_location", @"pro_analysis"];
    NSMutableArray *menus = [NSMutableArray array];
    
    CGSize itemSize = button.frame.size;
    for (NSString *icon in menuIcons) {
        LSFloatingActionMenuItem *item = [[LSFloatingActionMenuItem alloc] initWithImage:[UIImage imageNamed:icon] highlightedImage:[UIImage imageNamed:[icon stringByAppendingString:@"pro_menu"]]];
        item.itemSize = itemSize;
        [menus addObject:item];
    }
    
    self.actionMenu = [[LSFloatingActionMenu alloc] initWithFrame:self.view.bounds direction:direction menuItems:menus menuHandler:^(LSFloatingActionMenuItem *item, NSUInteger index) {
        //TODO
        
        switch (index) {
            case 1:
                NSLog(@"1 clicked");
                break;
            case 2:
                NSLog(@"2 clicked");
                break;
            case 3:
                NSLog(@"3 clicked");
                break;
            default:
                break;
        }
        
    } closeHandler:^{
        [self.actionMenu removeFromSuperview];
        self.actionMenu = nil;
        button.hidden = NO;
        self.visibleORU.hidden = NO;
    }];
    
    self.actionMenu.itemSpacing = 12;
    self.actionMenu.startPoint = button.center;
    
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
}

-(void)goBackToTinder:(UIButton *) sender{
    //    animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    //    navigating
    [self.navigationController popViewControllerAnimated:NO];
}
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
