//
//  mumLogin.m
//  DadBuzz
//
//  Created by me on 11/09/2014.
//
//

#import "mumLogin.h"
#import "mumSignUpController.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "mumsNotificationScreen.h"

@interface mumLogin ()

@end

@implementation mumLogin

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

- (IBAction)mumSignUp:(id)sender {
    
    mumSignUpController *viewController = [[mumSignUpController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}

- (IBAction)mumLogin:(id)sender {
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"Get ready to Buzz";
    [hud show:YES];
    
    
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error) {
        
        
        [hud hide:YES];
        
        if (user) {
            //Open the wall
            // [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
            
            
            mumsNotificationScreen *viewController = [[mumsNotificationScreen alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            
       
            
            
            
            
        } else {
            //Something bad has ocurred
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
