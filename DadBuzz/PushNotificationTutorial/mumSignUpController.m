//
//  mumSignUpController.m
//  DadBuzz
//
//  Created by me on 28/08/2014.
//
//

#import "mumSignUpController.h"
#import "MBProgressHUD.h"
#import "dadsSecretLinkController.h"

@interface mumSignUpController ()

@end

@implementation mumSignUpController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mumLogin:(id)sender {
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"DadBuzz ahoy!";
    [hud show:YES];
    
    
    
    //1
    PFUser *user = [PFUser user];
    //2
    user.username = self.dadsName.text;
    user.password = self.dadsLink.text;
  //  user[@"secretPassword"] = self.secretLink.text;
    user[@"gender"] = @"F";
    // user[@"channel"] = self.username.text;
    
    // user.secret = self.secretDadLink.text;
    
    
    //3
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [hud hide:YES];
        
        if (!error) {
            
  
            
            
    
            
            // hud.labelText = @"Sucess";
            //  [hud hide:YES];
            
            //The registration was successful, go to the wall
            //[self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
            
            // dadsSecretLinkController *viewController = [[dadsSecretLinkController alloc] init];
            // [self.navigationController pushViewController:viewController animated:YES];
            dadsSecretLinkController *viewController = [[dadsSecretLinkController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            
            
            
        } else {
            
            // hud.labelText = @"Sucess";
            //  [hud hide:YES];
            
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
    
    
}






- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}




@end
