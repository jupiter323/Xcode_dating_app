//
//  MatchesViewController.m
//  Korte
//
//  Created by Peace on 8/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "MatchesViewController.h"
#import "MSCMoreOptionTableViewCell.h"
@interface MatchesViewController () <MSCMoreOptionTableViewCellDelegate>{
    UIScrollView *matches;
    
    NSMutableArray *contentList;
    NSMutableArray *filteredContentList;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (weak, nonatomic) IBOutlet UITableView *displayTableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end

@implementation MatchesViewController
////////////////////////////////////////////////////////////////////////
#pragma mark - Initializer
////////////////////////////////////////////////////////////////////////

//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    self = [super initWithStyle:style];
//    if (self) {
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //search bar style
    UITextField *searchTextField = [((UITextField *)[self.searchBar.subviews objectAtIndex:0]).subviews lastObject];
    searchTextField.layer.cornerRadius = 16.0f;
    searchTextField.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    searchTextField.layer.borderWidth = 1;
    searchTextField.layer.borderColor = [[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] CGColor];
    searchTextField.layer.masksToBounds = YES;
    
    // logo label
    
    self.logoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.logoLabel.numberOfLines = 0;
    self.logoLabel.textColor = [UIColor whiteColor];
    self.logoLabel.textAlignment = NSTextAlignmentCenter;
    NSString *textContent = @"Matches";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Medium" size:19];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [textString addAttribute:NSKernAttributeName value:@(2.22) range:textRange];
    self.logoLabel.attributedText = textString;
    [self.logoLabel sizeToFit];
    
    //init list data
    contentList = [[NSMutableArray alloc] initWithObjects:@"Happy Man", @"happyman", @"Happy Woman", @"Water Man", @"man", @"woman",@"human", @"happy", @"happyyy", nil];
    filteredContentList = [[NSMutableArray alloc] init];
    // messages label
    
    self.messagesLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messagesLabel.numberOfLines = 0;
    self.messagesLabel.textColor = [UIColor grayColor];
    textContent = @"Messages";
    textRange = NSMakeRange(0, textContent.length);
    textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    font = [UIFont fontWithName:@"GothamRounded-Bold" size:21];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.2;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [textString addAttribute:NSKernAttributeName value:@(1.07) range:textRange];
    self.messagesLabel.attributedText = textString;
    [self.messagesLabel sizeToFit];
    
    //remove buttons
    self.notificationButton.hidden = YES;
    self.floatingButton.removeFromSuperview;
    
    //    matches scroll adding
    matches = [[UIScrollView alloc] init];
    CGFloat marginLeft = 0;
    CGFloat ContentScrollHeight = 104;
    CGFloat ContentScrollWidth = self.view.frame.size.width;
    CGFloat avatarWidth = ContentScrollHeight;
    matches.frame = CGRectMake(marginLeft,236-avatarWidth-36.5, ContentScrollWidth, avatarWidth);
    float sizeOfMatches = 10;
    matches.contentSize=CGSizeMake(sizeOfMatches*(avatarWidth+10)+35, avatarWidth);
    for(int i=0;i<sizeOfMatches;i++){
        CGFloat buttonWidth = avatarWidth;
        CGFloat buttonSide = 10;
        UIButton *avatar = [[UIButton alloc] init];
        avatar.frame = CGRectMake(i*(buttonWidth+buttonSide)+22.5,0 , buttonWidth, buttonWidth);
        [avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        avatar.imageView.contentMode =UIViewContentModeScaleAspectFill;
        avatar.tag = i;
        [avatar addTarget:self action:@selector(toMatchProfile:) forControlEvents:UIControlEventTouchUpInside];
        avatar.layer.cornerRadius = avatar.frame.size.width / 2;
        avatar.clipsToBounds = YES;
        avatar.layer.borderWidth = 4;
        avatar.layer.borderColor = [[UIColor whiteColor] CGColor];
        avatar.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0];
        [matches addSubview:avatar];
        
        //// subbuton
        CGFloat subbuttonWidth = 27;
        UIButton * connectRightBottomButton=[[UIButton alloc] init];
        connectRightBottomButton.frame=CGRectMake(avatar.frame.origin.x+avatarWidth-subbuttonWidth*1.2,avatar.frame.origin.y+avatarWidth - subbuttonWidth, subbuttonWidth, subbuttonWidth);
        if(i==0)
            [connectRightBottomButton setImage:[UIImage imageNamed:@"logomatch"] forState:UIControlStateNormal];
        else if(i==1)
            [connectRightBottomButton setImage:[UIImage imageNamed:@"logomatch"] forState:UIControlStateNormal];
        else
            [connectRightBottomButton setImage:nil forState:UIControlStateNormal];
        [matches addSubview:connectRightBottomButton];
    }
    matches.showsVerticalScrollIndicator = NO;
    matches.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:matches];

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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:nil handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // show UIActionSheet
        NSLog(@"report button pressed in row at: %@", indexPath.description);
//         Hide 'unfollow'- and 'report'-confirmation view
        [tableView.visibleCells enumerateObjectsUsingBlock:^(MSCMoreOptionTableViewCell *cell, NSUInteger idx, BOOL *stop) {
            if ([[tableView indexPathForCell:cell] isEqual:indexPath]) {
                [cell hideDeleteConfirmation];
            }
        }];
    }];
    
    moreAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"report"]];
    
    UITableViewRowAction *flagAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:nil handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // flag the row
        NSLog(@"unfollow button pressed in row at: %@", indexPath.description);
        // Hide 'unfollow'- and 'report'-confirmation view
        [tableView.visibleCells enumerateObjectsUsingBlock:^(MSCMoreOptionTableViewCell *cell, NSUInteger idx, BOOL *stop) {
            if ([[tableView indexPathForCell:cell] isEqual:indexPath]) {
                [cell hideDeleteConfirmation];
            }
        }];
    }];
    flagAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unfollow"]];
    return @[moreAction, flagAction];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"searchCell";
    
    MSCMoreOptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    //avatar
    
    cell.avatar.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.avatar addTarget:self action:@selector(toChatbox:) forControlEvents:UIControlEventTouchUpInside];
    cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2;
    cell.avatar.clipsToBounds = YES;
    
    
    // name
    
    cell.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.nameLabel.numberOfLines = 0;
    cell.nameLabel.textColor = [UIColor grayColor];
    cell.nameLabel.textAlignment = NSTextAlignmentCenter;
    NSString *textContent;
    
    // messages
    cell.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.messageLabel.numberOfLines = 2;
    cell.messageLabel.textColor = [UIColor grayColor];
    textContent = @"Good, i’m hanging out with friends right..";
    NSRange textRange = NSMakeRange(0, textContent.length);
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Book" size:12];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.5;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [textString addAttribute:NSKernAttributeName value:@(-0.05) range:textRange];
    cell.messageLabel.attributedText = textString;
    [cell.messageLabel sizeToFit];
  
    //date label
   
    cell.dateLabel .lineBreakMode = NSLineBreakByWordWrapping;
    cell.dateLabel .numberOfLines = 0;
    cell.dateLabel .textColor = [UIColor colorWithRed:0.67 green:0.65 blue:0.65 alpha:1];
    if(indexPath.row==0)
        textContent = @"Today";
    else if(indexPath.row == 1)
        textContent = @"Yesterday";
    else
        textContent = @"8/31/2018";
        
    textRange = NSMakeRange(0, textContent.length);
    textString = [[NSMutableAttributedString alloc] initWithString:textContent];
    font = [UIFont fontWithName:@"GothamRounded-Book" size:9];
    [textString addAttribute:NSFontAttributeName value:font range:textRange];
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.31;
    [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [textString addAttribute:NSKernAttributeName value:@(-0.14) range:textRange];
    cell.dateLabel.attributedText = textString;
    [cell.dateLabel sizeToFit];
    

    //time label
    if(indexPath.row!=0){
        cell.timeLabel.hidden = NO;
        cell.timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.timeLabel.numberOfLines = 0;
        cell.timeLabel.textColor = [UIColor grayColor];
        textContent = @"1:20PM";
        textRange = NSMakeRange(0, textContent.length);
        textString = [[NSMutableAttributedString alloc] initWithString:textContent];
        font = [UIFont fontWithName:@"GothamRounded-Book" size:8];
        [textString addAttribute:NSFontAttributeName value:font range:textRange];
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1.08;
        [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        [textString addAttribute:NSKernAttributeName value:@(-0.13) range:textRange];
        cell.timeLabel.attributedText = textString;
        [cell.timeLabel sizeToFit];
        cell.pinkDot.hidden=YES;
    }
    // unread message indicate
    if(indexPath.row == 0){
        cell.pinkDot.hidden=NO;
        cell.pinkDot.backgroundColor = [UIColor colorWithRed:0.93 green:0.49 blue:0.41 alpha:1];
        cell.pinkDot.layer.cornerRadius = cell.pinkDot.frame.size.width/2;
        cell.timeLabel.hidden = YES;
    }
    
    //// Configure the cell...
    if (tableView == self.searchBarController.searchResultsTableView) {
        //////avatar image
        [cell.avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        //////name spell
        textContent = [filteredContentList objectAtIndex:indexPath.row];
        textRange = NSMakeRange(0, textContent.length);
        textString = [[NSMutableAttributedString alloc] initWithString:textContent];
        font = [UIFont fontWithName:@"GothamRounded-Medium" size:14];
        [textString addAttribute:NSFontAttributeName value:font range:textRange];
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1.21;
        [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        [textString addAttribute:NSKernAttributeName value:@(0.89) range:textRange];
        cell.nameLabel.attributedText = textString;
        [cell.nameLabel sizeToFit];
        
    }
    else {
        //////avatar image
        [cell.avatar setImage:[UIImage imageNamed:@"sunglassesGirl"] forState:UIControlStateNormal];
        //////name spell
        textContent =  [contentList objectAtIndex:indexPath.row];
        textRange = NSMakeRange(0, textContent.length);
        textString = [[NSMutableAttributedString alloc] initWithString:textContent];
        font = [UIFont fontWithName:@"GothamRounded-Medium" size:14];
        [textString addAttribute:NSFontAttributeName value:font range:textRange];
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1.21;
        [textString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        [textString addAttribute:NSKernAttributeName value:@(0.89) range:textRange];
        cell.nameLabel.attributedText = textString;
        [cell.nameLabel sizeToFit];
        
    }
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - MSCMoreOptionTableViewCellDelegate
////////////////////////////////////////////////////////////////////////

//- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Called when 'more' button is pushed.
//    NSLog(@"MORE button pressed in row at: %@", indexPath.description);
//    // Hide 'more'- and 'delete'-confirmation view
//    [tableView.visibleCells enumerateObjectsUsingBlock:^(MSCMoreOptionTableViewCell *cell, NSUInteger idx, BOOL *stop) {
//        if ([[tableView indexPathForCell:cell] isEqual:indexPath]) {
//            [cell hideDeleteConfirmation];
//        }
//    }];
//}

//- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"More";
//}

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
