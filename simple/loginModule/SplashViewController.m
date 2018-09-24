//
//  SplashViewController.m
//  simple
//
//  Created by Peace on 8/2/18.
//  Copyright © 2018 Peace. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController (){
    BOOL isRegister;
//    SCLAlertView *alert;
}



@end

@implementation SplashViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //logged in with face book
    if ([FBSDKAccessToken currentAccessToken]||[[PDKeychainBindings sharedKeychainBindings] objectForKey:@"logToken"]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Already Logged in");
        [self.navigationController pushViewController:[MXViewController new] animated:YES];
        
    } 
    //password security
    self.passwordText.secureTextEntry = YES;
    self.CPasswordText.secureTextEntry = YES;
    // email entry
//    self.emailText.entr
    //register
    isRegister = false;
    [self registerOrLoginSetting];
  
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
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.nameText)
        self.nameCorrect.hidden = YES;
    if(textField == self.emailText)
        self.emailCorrect.hidden = YES;
    if(textField == self.passwordText)
        self.passCorrect.hidden = YES;
    if(textField == self.CPasswordText)
        self.cPCorrect.hidden = YES;
}
-(void)initData{   
    self.nameText.text = @"";
    self.emailText.text = @"";
    self.passwordText.text = @"";
    self.CPasswordText.text = @"";
    self.nameCorrect.hidden = YES;
    self.emailCorrect.hidden = YES;
    self.passCorrect.hidden = YES;
    self.cPCorrect.hidden = YES;
}
- (IBAction)loginAndRegister:(id)sender {
    if(isRegister){//register
        BOOL notValid =  false;
        if([self.nameText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
            self.nameCorrect.hidden = NO;
            notValid = true;
        }
        if(![self validEmail:self.emailText.text])
        {
            self.emailCorrect.hidden = NO;
            notValid = true;
        }
        if(self.passwordText.text.length < 6)
        {
            self.passCorrect.hidden = NO;
            notValid = true;
        }
        if(![self.passwordText.text isEqualToString:self.CPasswordText.text] ||self.CPasswordText.text.length == 0){
            self.cPCorrect.hidden = NO;
            notValid = true;
        }
        
        if(notValid) return;
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showWaiting:self title:@"Waiting..." subTitle:@"Please wait a moment." closeButtonTitle:nil duration:0.0f];
        
        NSDictionary *headers = @{@"accept": @"application/json"};
        NSDictionary *parameters = @{@"name": self.nameText.text,@"email": self.emailText.text, @"with":@"email", @"password":self.passwordText.text};
        UNIHTTPJsonResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
            [request setUrl:[BaseURI stringByAppendingString:@"users"]];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        if(response){
            [self initData];
            [alert hideView];
            // This is the asyncronous callback block
            NSInteger code = response.code;
            if(code!=200) {
                NSLog(@"server error");
                alertCustom(SCLAlertViewStyleError, @"Server error");
                return;
            }
            
            UNIJsonNode *body = response.body;
            
            ////save cash for user info
            if(![body.object objectForKey:@"err"]){
                [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify([body.object objectForKey:@"user"]) forKey:@"logToken"];
                [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify([body.object objectForKey:@"user"]) forKey:@"userInfo"];
                NSLog(@"register and log in");
                [self.navigationController pushViewController:[MXViewController new] animated:YES];
            } else {
                NSLog(@"error  %@", [body.object objectForKey:@"err"]);
                alertCustom(SCLAlertViewStyleError, [body.object objectForKey:@"err"]);
            }
        }
    } else {//log  in
        BOOL notValid =  false;
        if(![self validEmail:self.emailText.text])
        {
            self.emailCorrect.hidden = NO;
            notValid = true;
        }
        if(self.passwordText.text.length <6)
        {
            self.passCorrect.hidden = NO;
            notValid = true;
        }
        
        if(notValid) return;

        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showWaiting:self title:@"Waiting..." subTitle:@"Please wait a moment." closeButtonTitle:nil duration:0.0f];
        
        NSDictionary *headers = @{@"accept": @"application/json"};
        NSDictionary *parameters = @{@"email": self.emailText.text, @"password":self.passwordText.text};
        UNIHTTPJsonResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
            [request setUrl:[BaseURI stringByAppendingString:@"users/login"]];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        if(response){
            [self initData];
            [alert hideView];
            // This is the asyncronous callback block
            NSInteger code = response.code;
            if(code!=200) {
                NSLog(@"server error");
                alertCustom(SCLAlertViewStyleError, @"Server error");
                return;
            }
            
            UNIJsonNode *body = response.body;
            
            ////save cash for user info
            if(![body.object objectForKey:@"err"]){
                [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify([body.object objectForKey:@"user"]) forKey:@"logToken"];
                NSLog(@"log in");
                [self.navigationController pushViewController:[MXViewController new] animated:YES];
            } else {
                NSLog(@"error  %@", [body.object objectForKey:@"err"]);
                alertCustom(SCLAlertViewStyleError, [body.object objectForKey:@"err"]);
            }
        }
    }
    
    
}

- (IBAction)makeRegister:(id)sender {
    [self initData];
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
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert showWaiting:self title:@"Waiting..." subTitle:@"Please wait a moment." closeButtonTitle:nil duration:0.0f];
   
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             [alert hideView];
             alertCustom(SCLAlertViewStyleError, @"Facebook connecting error");
         } else if (result.isCancelled) {
             [alert hideView];
             alertCustom(SCLAlertViewStyleError, @"Facebook connecting cancelled");
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
                          UNIHTTPJsonResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
                              [request setUrl:[BaseURI stringByAppendingString:@"users"]];
                              [request setHeaders:headers];
                              [request setParameters:parameters];
                          }] asJson];
                          
                          if(response){
                              [self initData];
                              [alert hideView];
                              // This is the asyncronous callback block
                              NSInteger code = response.code;
                              if(code!=200) {
                                  NSLog(@"server error");
                                  alertCustom(SCLAlertViewStyleError, @"Server error");
                                  return;
                              }
                              NSLog(@"facebook log in");
                              UNIJsonNode *body = response.body;
                              [[PDKeychainBindings sharedKeychainBindings] setObject:jsonStringify([body.object objectForKey:@"user"]) forKey:@"userInfo"];
                              [self.navigationController pushViewController:[MXViewController new] animated:YES];
                              
                             
                          }
                     
                      } else {
                          alertCustom(SCLAlertViewStyleError, @"Facebook connecting error");
                      }
                  }];
             }
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
