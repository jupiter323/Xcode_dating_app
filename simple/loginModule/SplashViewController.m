//
//  SplashViewController.m
//  simple
//
//  Created by Peace on 8/2/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "SplashViewController.h"
#import "UNIRest/UNIRest.h"
@interface SplashViewController (){
    Boolean *isRegister;
}


@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //password security
    self.passwordText.secureTextEntry = YES;
    self.CPasswordText.secureTextEntry = YES;
    // email entry
//    self.emailText.entr
    //register
    isRegister = false;
    [self registerOrLoginSetting];
    //logged in with face book
   if ([FBSDKAccessToken currentAccessToken]||[[PDKeychainBindings sharedKeychainBindings] objectForKey:@"logToken"]) {
        // User is logged in, do work such as go to next view controller.
       NSLog(@"Already Logged in");
        [self.navigationController pushViewController:[MXViewController new] animated:YES];
   } 
}
- (BOOL) validEmail:(NSString*) emailString {
    
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    NSLog(@"%i", regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)loginAndRegister:(id)sender {
    if(isRegister){
        NSDictionary *headers = @{@"accept": @"application/json"};
        NSDictionary *parameters = @{@"name": self.nameText.text,@"email": self.emailText.text, @"with":@"email", @"password":self.passwordText.text};
        
        //                          NSDictionary *parameters = @{@"item": [result objectForKey:@"name"]};
        
        [[UNIRest post:^(UNISimpleRequest *request) {
            //                              [request setUrl:@"https://korteapi.herokuapp.com"];
            [request setUrl:@"http://192.168.2.155:3000"];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
            if(!error){
                // This is the asyncronous callback block
                NSInteger code = response.code;
                NSDictionary *responseHeaders = response.headers;
                UNIJsonNode *body = response.body;
                NSData *rawBody = response.rawBody;
                NSLog(@"lo++++++++%@",jsonStringify(body.object));
                ////save cash for user info
                [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify(body.object) forKey:@"logToken"];
                [self.navigationController pushViewController:[MXViewController new] animated:YES];
            }
        }];
    } else {
        NSLog(@"log in");
    }
    
    
}
- (IBAction)makeRegister:(id)sender {
    
    isRegister = !isRegister;
    if(isRegister)
       [sender setTitle:@"Log In" forState:UIControlStateNormal];
    else
        [sender setTitle:@"Register" forState:UIControlStateNormal];
    
    [self registerOrLoginSetting];
}
-(void) registerOrLoginSetting{
    if(isRegister){
        self.nameText.hidden = NO;
        self.CPasswordText.hidden = NO;
        [self.loginButton setTitle:@"Register" forState:UIControlStateNormal];
   
    } else {
        self.nameText.hidden = YES;
        self.CPasswordText.hidden = YES;
        [self.loginButton setTitle:@"Log In" forState:UIControlStateNormal];
        self.loginButton.frame = self.CPasswordText.frame;
        [self.view setNeedsDisplay];
        
    }
}
-(IBAction)loginFacebook:(UIButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if(result.token) {
                 NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                 [parameters setValue:@"id,name,email" forKey:@"fields"];
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                               id result, NSError *error) {
                      if(!error){
                          NSLog(@"user:%@", jsonStringify(result));
                   
                                                 
                          NSDictionary *headers = @{@"accept": @"application/json"};
                          NSDictionary *parameters = @{@"name": [result objectForKey:@"name"],@"email": [result objectForKey:@"email"], @"with":@"facebook", @"password":@"good"};
                          
//                          NSDictionary *parameters = @{@"item": [result objectForKey:@"name"]};
                          
                          [[UNIRest post:^(UNISimpleRequest *request) {
//                              [request setUrl:@"https://korteapi.herokuapp.com"];
                              [request setUrl:@"http://192.168.2.155:3000"];
                              [request setHeaders:headers];
                              [request setParameters:parameters];
                          }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
                              if(!error){
                                  // This is the asyncronous callback block
                                  NSInteger code = response.code;
                                  NSDictionary *responseHeaders = response.headers;
                                  UNIJsonNode *body = response.body;
                                  NSData *rawBody = response.rawBody;
                                  [self.navigationController pushViewController:[MXViewController new] animated:YES];
                              }
                          }];
                          
                     
                          
                      }
                  }];
             }
             //get profile
//             [FBSDKProfile loadCurrentProfileWithCompletion:
//              ^(FBSDKProfile *profile, NSError *error) {
//                  if (profile) {
//                      NSLog(@"Hello, %@!", profile.firstName);
//                      [self.navigationController pushViewController:[MXViewController new] animated:YES];
//                  }
//              }];
         }
     }];
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
