//
//  ProfileCollectionViewController.h
//  Korte
//
//  Created by Peace on 9/19/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "HTKDragAndDropCollectionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Utilities.h"
#import "FirebaseViewController.h"
#import <Photos/Photos.h>
@interface ProfileCollectionViewController : HTKDragAndDropCollectionViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
-(void)setData:(NSMutableArray *)data local:(NSMutableArray *)localData;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *localDataArray;
@end
