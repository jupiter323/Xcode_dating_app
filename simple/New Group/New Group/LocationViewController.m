//
//  LocationViewController.m
//  simple
//
//  Created by Peace on 8/7/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "LocationViewController.h"
#import "LSFloatingActionMenu.h"
@interface LocationViewController ()
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    float buttons menu
    UIButton *floatingButton = [[UIButton alloc] init];
    [floatingButton setImage:[UIImage imageNamed:@"pro_menu"] forState:UIControlStateNormal];
    [floatingButton sizeToFit];
    floatingButton.frame = CGRectMake(20,20, floatingButton.bounds.size.width, floatingButton.bounds.size.height);
    [floatingButton addTarget:self action:@selector(tapedToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:floatingButton];
}
-(void)tapedToggle:(UIButton *) sender {
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionLeft];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
    button.hidden = YES;
//    self.notifyButton.hidden = YES;
    
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
                //                location
//                [self toLocation];
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
//        self.notifyButton.hidden = NO;
    }];
    
    self.actionMenu.itemSpacing = 12;
    self.actionMenu.startPoint = button.center;
    
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
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
