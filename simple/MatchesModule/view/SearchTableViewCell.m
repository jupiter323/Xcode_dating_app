//
//  SearchTableViewCell.m
//  Korte
//
//  Created by Peace on 8/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected)NSLog(@"selected");
    // Configure the view for the selected state
}

@end
