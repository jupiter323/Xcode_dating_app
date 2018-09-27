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
        [[PDKeychainBindings sharedKeychainBindings] setObject:@"yes" forKey:@"profileFlag"];
    }
    
  
    [self.collectionView reloadData];
    // Reset
    [flowLayout resetDragging];
}
#pragma mark - alertActionSheet for camera roll
- (void)addAndChangeAvatar:(UIButton *) sender {
    
    
    self.cellToCapture = (ProfileCollectionViewCell *)sender.superview.superview;
    self.cellIndexPath = [self.collectionView indexPathForCell:self.cellToCapture];
//    [self.cellToCapture enableGestureC:NO];
    
    [[Utilities sharedUtilities] setIndexImageOfCell:(int)self.cellIndexPath.row];
    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    self.yourCurrentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (self.yourCurrentViewController.presentedViewController)
    {
        self.yourCurrentViewController = self.yourCurrentViewController.presentedViewController;
    }
    //alert control
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"" message:@"Change Profile image" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhoto=[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:
                    UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            self->_newMedia = YES;
        } else
            alertCustom(SCLAlertViewStyleError, @"Camera is error");
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        
        [self.yourCurrentViewController presentViewController:imagePicker
                                                     animated:YES completion:nil];
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:takePhoto];
    
    UIAlertAction *choosePhoto=[UIAlertAction actionWithTitle:@"Select From Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            self->_newMedia = YES;
        } else
            alertCustom(SCLAlertViewStyleError, @"Photo library is error");
        
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        
        [self.yourCurrentViewController presentViewController:imagePicker
                                                     animated:YES completion:nil];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:choosePhoto];
    
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [alertController addAction:actionCancel];
    
    [self.yourCurrentViewController presentViewController:alertController animated:YES completion:nil];
    
    
//    [self.cellToCapture enableGestureC:YES];
}

#pragma mark - imagepicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
   
    [self.yourCurrentViewController dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        image = imageWithImage(image, CGSizeMake(768, 768 * image.size.height/image.size.width));

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
            [[PDKeychainBindings sharedKeychainBindings] setObject:@"yes" forKey:@"profileFlag"];
            
       
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

@end
