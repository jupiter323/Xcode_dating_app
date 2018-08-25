//
//  GettingForFriendSwipingViewController.m
//  Korte
//
//  Created by Peace on 8/21/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "GettingForMeSwipingViewController.h"

@interface GettingForMeSwipingViewController (){
    BOOL facebook;
    NSMutableArray * arr;
}
@property (weak, nonatomic) IBOutlet UILabel *gettingForFriendLabel;


@property (weak, nonatomic) IBOutlet UIView *toggleView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GettingForMeSwipingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //table content
    NSArray *content = @[ @"Monday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
    arr = [[NSMutableArray alloc] init];
    int i = 0;
    for(NSString *name in content){
        i++;
        NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"bikiniGirl", @"avatar",
                                        name, @"name",
                                        i==1?@"ok":@"no",@"requestStatus",
                                        
                                        nil];
        [arr addObject:jsonDictionary];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
}
-(void) viewDidAppear:(BOOL)animated{
    //    with friends connect
    self.gettingForFriendLabel.attributedText = attributedString(@"Request a Friend to Swipe for Me",StandardColor(), 2.22f);
    
    //toggle view
    self.toggleView.layer.cornerRadius=22;
    
    //facebook button
    
    self.facebookButton.layer.cornerRadius = 14;
    self.facebookButton.backgroundColor = UIColorWithHexString(@"#ed5305");
    // contact button
    self.contactButton.layer.cornerRadius = 14;
    
    
    
}
- (IBAction)facebook:(id)sender {
    facebook = YES;
    self.facebookButton.backgroundColor = UIColorWithHexString(@"#ed5305");
    
    self.contactButton.backgroundColor = [UIColor clearColor];
}
- (IBAction)contacts:(id)sender {
    facebook = NO;
    
    self.contactButton.backgroundColor = UIColorWithHexString(@"#ed5305");
    
    self.facebookButton.backgroundColor = [UIColor clearColor];
}
- (IBAction)return:(id)sender {
    // animating
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    // navigating
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdGettingMe" forIndexPath:indexPath];
    
    CGFloat buttonWidth = 60;
    
    [cell.avatarButton setImage:[UIImage imageNamed:arr[indexPath.row][@"avatar"]] forState:UIControlStateNormal];
    cell.avatarButton.imageView.contentMode =  UIViewContentModeScaleAspectFill;
    cell.avatarButton.layer.cornerRadius = cell.avatarButton.frame.size.width / 2;
    cell.avatarButton.clipsToBounds = YES;
    
    cell.name.text = arr[indexPath.row][@"name"];
    
    cell.requestView.frame =  CGRectMake(cell.name.frame.origin.x + cell.name.frame.size.width+10, (buttonWidth-23)/2, 93, 23);
    cell.requestView.layer.cornerRadius = 4;
    if(arr[indexPath.row][@"requestStatus"]==@"ok")
    cell.requestView.backgroundColor = UIColorWithHexString(@"#f69226");
    else
    cell.requestView.backgroundColor = UIColorWithHexString(@"#f8b368");
    
 
    cell.requestLabel.frame = CGRectMake(0,0, 93, 23);
    cell.requestLabel.textAlignment = UITextAlignmentCenter;
    if(arr[indexPath.row][@"requestStatus"]==@"ok")
        cell.requestLabel.text = @"Requested!";
    else
        cell.requestLabel.text = @"Request to Swipe";
    cell.requestLabel.textColor = [UIColor whiteColor];
    [cell.requestLabel setFont:[UIFont systemFontOfSize:9]];
    [cell.requestView addSubview:cell.requestLabel];
    
    [cell addSubview:cell.requestView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
