//
//  FirebaseViewController.m
//  Korte
//
//  Created by Peace on 9/20/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "FirebaseViewController.h"

@interface FirebaseViewController ()
@property (nonatomic) FIRStorage *storage;
@end

@implementation FirebaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)configFireStorage{
    // Do any additional setup after loading the view.
    // [START configurestorage]
  
    self.storage = [FIRStorage storage];
    // [END configurestorage]
    
    // [START storageauth]
    // Using Cloud Storage for Firebase requires the user be authenticated. Here we are using
    // anonymous authentication.
    if (![FIRAuth auth].currentUser) {
        [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRAuthDataResult * _Nullable authResult,
                                                          NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error.description);
            } else {
                NSLog(@"Succedd");
            }
        }];
    }
    // [END storageauth]
}
-(void)uploadToFirebaseStorage:(id) file{
    
    NSData *imageData = UIImageJPEGRepresentation((UIImage *)file, 0.8);
    NSString *folderName=   [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"];
    if(folderName)
        folderName = [jsonParse(folderName) valueForKey:@"email"];
    folderName = [folderName stringByReplacingOccurrencesOfString:@"@" withString:@""];
    folderName = [folderName stringByReplacingOccurrencesOfString:@"." withString:@""];
  
    NSString *imagePath =
    [NSString stringWithFormat:@"%@/%lld.jpg",folderName,
     (long long)([NSDate date].timeIntervalSince1970 * 1000.0)];
    FIRStorageMetadata *metadata = [FIRStorageMetadata new];
    metadata.contentType = @"image/jpeg";
    FIRStorageReference *storageRef = [_storage referenceWithPath:imagePath];
    FIRStorageUploadTask *uploadTask = [storageRef putData:imageData
               metadata:metadata
             completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
                 if (error) {
                     NSLog(@"Error uploading: %@", error);
                     return;
                 }
                 [self uploadSuccess:storageRef storagePath:imagePath];
             }];
}
- (void)uploadSuccess:(FIRStorageReference *) storageRef storagePath: (NSString *) storagePath {
    NSLog(@"Upload Succeeded!");
    [storageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting download URL: %@", error);
            return;
        }
        NSLog(@"uploaded and changed images with fire url: %@",URL.absoluteString);
        // data assign
        id userInfo =[jsonParse([[PDKeychainBindings sharedKeychainBindings] objectForKey:@"userInfo"]) mutableCopy];
 
        
        NSMutableArray *images = [[userInfo objectForKey:@"images"] mutableCopy];
        if(!images) return;
        [images setObject:URL.absoluteString atIndexedSubscript:[[Utilities sharedUtilities] indexImage]];
        [userInfo setObject:images forKey:@"images"];
        [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(userInfo) forKey:@"userInfo"];// changed images in local data
        
        [[Utilities sharedUtilities] setIndexImageOfCell:0];
        
        // active download
    }];
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
