//
//  ViewController.h
//  DemoChatApp
//
//  Created by Pranshi on 8/31/18.
//  Copyright © 2018 Shiny Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGCollapsingHeaderView.h"
#import "WireframeViewController.h"

@interface ChatController : WireframeViewController<MGCollapsingHeaderDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>{
    NSMutableArray *messageArray;
    NSMutableArray *dataArray;
    CGFloat initialTVHeight;
}

@property (weak, nonatomic) IBOutlet MGCollapsingHeaderView *callapsingHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imageLeftArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlock;
@property (weak, nonatomic) IBOutlet UIImageView *imageInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCollapsingHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableviewChat;

@property (nonatomic, retain) NSMutableArray *messageArray;
@property (nonatomic, strong) NSMutableArray *chatArray;

@end

