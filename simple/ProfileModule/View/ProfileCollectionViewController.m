//
//  ProfileCollectionViewController.m
//  Korte
//
//  Created by Peace on 9/19/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "ProfileCollectionViewController.h"
#import "ProfileCollectionViewCell.h"
@interface ProfileCollectionViewController ()
@property (nonatomic, strong) UICollectionView *uiCollection;
@property (nonatomic) BOOL newMedia;
@property (nonatomic, strong) ProfileCollectionViewCell *cellToCapture;
@property (nonatomic, strong) UIViewController *yourCurrentViewController;
@property (nonatomic, strong)  NSIndexPath *cellIndexPath;
@property (nonatomic, strong)  FirebaseViewController *fireController;
@end

@implementation ProfileCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // fire control
    self.fireController = [[FirebaseViewController alloc] init];
    [self.fireController configFireStorage];

    // Register cell    
    // If you are using Storyboards/Nibs, make sure you "registerNib:" instead.
    [self.collectionView registerClass:[ProfileCollectionViewCell class] forCellWithReuseIdentifier:HTKDraggableCollectionViewCellIdentifier];

    // Setup item size
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    CGFloat itemWidth = 85;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.lineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 32, 0, 32);

}
-(void)setData:(NSMutableArray *)data local:(NSMutableArray *)localData {
    self.dataArray = data;
    self.localDataArray = localData;
}
#pragma mark - UICollectionView Datasource/Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ProfileCollectionViewCell *cell = (ProfileCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HTKDraggableCollectionViewCellIdentifier forIndexPath:indexPath];
    
    long i = indexPath.item;
    CGFloat buttonWidth = 85;//88
    CGFloat buttonLocH =15;
    if(i>2)
        buttonLocH =buttonLocH+buttonWidth+10;
    cell.avatarImage.frame = CGRectMake(0,0 , buttonWidth, buttonWidth);

    [cell.avatarImage setImage:[UIImage imageWithContentsOfFile:self.localDataArray[i]]];
    
    cell.avatarImage.layer.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.34].CGColor;
    
    cell.avatarImage.contentMode =UIViewContentModeScaleAspectFill;
    cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.size.width / 2;
    cell.avatarImage.clipsToBounds = YES;
    cell.avatarImage.layer.borderWidth = 3.0f;
    cell.avatarImage.layer.borderColor = [[UIColor colorWithRed:0.96 green:0.57 blue:0.15 alpha:1] CGColor];
    
    
    [cell.subButton sizeToFit];
    [cell.subButton addTarget:self
                       action:@selector(addAndChangeAvatar:)
             forControlEvents:UIControlEventTouchDown];
    cell.subButton.backgroundColor = [UIColor clearColor];
    
    if([self.localDataArray[i] containsString:@"imagePlace"] ||[self.localDataArray[i] containsString:@"videoPlace"])
        [cell.subButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    else
        [cell.subButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    
    cell.subButton.contentMode = UIViewContentModeScaleAspectFill;
    CGFloat subbuttonWidth = 26;
    cell.subButton.frame = CGRectMake(cell.avatarImage.frame.size.width-subbuttonWidth, cell.avatarImage.frame.size.width-subbuttonWidth, subbuttonWidth, subbuttonWidth);
    
    
    // Set number on cell
    cell.numberLabel.text = self.dataArray[indexPath.row];    
   
    // Set our delegate for dragging
    cell.draggingDelegate = self;
    
    return cell;
}

#pragma mark - HTKDraggableCollectionViewCellDelegate

- (BOOL)userCanDragCell:(UICollectionViewCell *)cell {
    // All cells can be dragged in this demo
    return YES;
}

- (void)userDidEndDraggingCell:(UICollectionViewCell *)cell {
    
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    
    // Save our dragging changes if needed
    if (flowLayout.finalIndexPath != nil) {
        // Update datasource
        NSObject *objectToMove = [self.dataArray objectAtIndex:flowLayout.draggedIndexPath.row];
        [self.dataArray removeObjectAtIndex:flowLayout.draggedIndexPath.row];
        [self.dataArray insertObject:objectToMove atIndex:flowLayout.finalIndexPath.row];
        [[Utilities sharedUtilities] setIndexImageOfCell:(int)flowLayout.finalIndexPath.row];
        
        NSObject *localobjectToMove = [self.localDataArray objectAtIndex:flowLayout.draggedIndexPath.row];
        [self.localDataArray removeObjectAtIndex:flowLayout.draggedIndexPath.row];
        [self.localDataArray insertObject:localobjectToMove atIndex:flowLayout.finalIndexPath.row];
        
       
        
        NSMutableArray *localimages = [self.localDataArray mutableCopy];
        
        [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(localimages) forKey:@"images"];
        // changed showing images in local data
        
        id userInfo =[jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"]) mutableCopy];
        
        NSMutableArray *images = [self.dataArray mutableCopy];
        if(images){
            [userInfo setObject:images forKey:@"images"];
            [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];// changed images in local data
        }
    }
    
  
    [self.collectionView reloadData];
    // Reset
    [flowLayout resetDragging];
}
//camera
-(void)addAndChangeAvatar:(UIButton *) sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        self.cellToCapture = (ProfileCollectionViewCell *)sender.superview.superview;
        self.cellIndexPath = [self.collectionView indexPathForCell:self.cellToCapture];
        [[Utilities sharedUtilities] setIndexImageOfCell:(int)self.cellIndexPath.row];
        NSLog(@"sdf%ld%d",(long)self.cellIndexPath.row, [[Utilities sharedUtilities] indexImage]);
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        
        self.yourCurrentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        while (self.yourCurrentViewController.presentedViewController)
        {
            self.yourCurrentViewController = self.yourCurrentViewController.presentedViewController;
        }
        
        [self.yourCurrentViewController presentViewController:imagePicker
                                                animated:YES completion:nil];

        _newMedia = YES;
    }   
}

-(void)uploadImage:(UIImage *)image{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert showWaiting:self.yourCurrentViewController title:@"Waiting..." subTitle:@"Please wait a moment." closeButtonTitle:nil duration:0.0f];
   
    
    [alert hideView];


   
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
   
    [self.yourCurrentViewController dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        image = imageWithImage(image, CGSizeMake(768, 768));

        // changed showing images in local data
        if (_newMedia){

            NSString *imagename= randomStringWithLength(10);
            imagename = [imagename stringByAppendingString:@".png"];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* path = [documentsDirectory stringByAppendingPathComponent:
                              imagename];
            NSData* data = UIImagePNGRepresentation(image);
            [data writeToFile:path atomically:YES];
            NSLog(@"%@",path);
            
            [self.localDataArray setObject:path atIndexedSubscript:self.cellIndexPath.row];// setting avatar image
           
            id localimages = [self.localDataArray mutableCopy];
            [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(localimages) forKey:@"images"];
            
            
       
            self.newMedia = NO;
        }
        
        
        // to upload to firebase
        [self.fireController uploadToFirebaseStorage:image];
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(id)contextInfo
{
    if (error) {
        alertCustom(SCLAlertViewStyleError, @"Failed to save image");
    }
    NSLog(@"%@",contextInfo);
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.yourCurrentViewController dismissViewControllerAnimated:YES completion:nil];
}

//-(void)addAndChangeAvatar:(UIButton *) sender {
//    if ([UIImagePickerController isSourceTypeAvailable:
//         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//    {
//        UIImagePickerController *imagePicker =
//        [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType =
//        UIImagePickerControllerSourceTypePhotoLibrary;
//        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
//        imagePicker.allowsEditing = NO;
//        [self presentViewController:imagePicker
//                           animated:YES completion:nil];
//        _newMedia = NO;
//    }
//
//
//
//}
@end
