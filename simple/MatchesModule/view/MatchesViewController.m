//
//  MatchesViewController.m
//  Korte
//
//  Created by Peace on 8/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "MatchesViewController.h"

@interface MatchesViewController (){
    UIScrollView *matches;
    
    NSMutableArray *contentList;
    NSMutableArray *filteredContentList;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (weak, nonatomic) IBOutlet UITableView *displayTableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init list data
    contentList = [[NSMutableArray alloc] initWithObjects:@"Happy Man", @"happyman", @"Happy Woman", @"Water Man", @"man", @"woman",@"human", @"happy", @"happyyy", nil];
    filteredContentList = [[NSMutableArray alloc] init];
    
    //remove buttons
    self.notificationButton.hidden = YES;
    self.floatingButton.removeFromSuperview;
    
    //    swipe for me scroll adding
    matches = [[UIScrollView alloc] init];
    CGFloat marginLeft = 0;
    CGFloat ContentScrollHeight = self.view.frame.size.height/7;
    CGFloat ContentScrollWidth = self.view.frame.size.width;
    CGFloat avatarWidth = ContentScrollHeight;
    matches.frame = CGRectMake(marginLeft,236-avatarWidth-36.5, ContentScrollWidth, avatarWidth);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*(avatarWidth+10)+10, avatarWidth);
    for(int i=0;i<sizeOfMatches;i++){
        CGFloat buttonWidth = avatarWidth;
        CGFloat buttonSide = 10;
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+10,0 , buttonWidth, buttonWidth);
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        avatar.tag = i;
        [avatar addTarget:self action:@selector(toMatchProfile:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        
        [matches addSubview:avatar];
    }
    matches.showsVerticalScrollIndicator = NO;
    matches.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:matches];
//    [self.swipeformeScrollContent setBackgroundColor:UIColorWithHexString(@"#E8E3E3")];
}
-(void)toMatchProfile:(UIButton *)sender {
    [self navAnimating:kCATransitionFade subtype:kCATransitionFromLeft];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchBarController.searchResultsTableView) {
        return [filteredContentList count];
    }
    else {
        return [contentList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"searchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIButton *avatar = [[UIButton alloc] init];
    avatar.frame = CGRectMake(10,0 , 40, 40);
    [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
    avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [avatar addTarget:self action:@selector(toMatchProfile:) forControlEvents:UIControlEventTouchUpInside];
    avatar.layer.cornerRadius = avatar.frame.size.width / 2;
    avatar.clipsToBounds = YES;
    
    
    [cell addSubview:avatar];
    // Configure the cell...
    if (tableView == self.searchBarController.searchResultsTableView) {
        cell.textLabel.text = [filteredContentList objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [contentList objectAtIndex:indexPath.row];
    }
    return cell;
    
}

#pragma mark - Search Function Responsible For Searching

- (void)searchTableList {
    NSString *searchString = self.searchBar.text;
    
    for (NSString *tempStr in contentList) {
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [filteredContentList addObject:tempStr];
        }
    }
}

#pragma mark - Search Bar Implementation

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        [self searchTableList];
    }
    else {
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
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
