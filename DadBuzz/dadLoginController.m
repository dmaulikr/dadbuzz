//
//  dadLoginController.m
//  DadBuzz
//
//  Created by me on 29/08/2014.
//
//

#import "dadLoginController.h"
#import "dadSignupController.h"

#import "ViewController.h"

#import "MBProgressHUD.h"



@interface dadLoginController ()

@end

@implementation dadLoginController

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

- (IBAction)dadSignUp:(id)sender {
    
    
    
    dadSignupController *viewController = [[dadSignupController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}

- (IBAction)dadLogin:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"Get ready to Buzz";
    [hud show:YES];
    
    
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error) {
        
        
        [hud hide:YES];
        
        if (user) {
            //Open the wall
           // [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
    
            
            ViewController *viewController = [[ViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
    
    
    /*
    
    //1
    PFUser *user = [PFUser user];
    //2
    user.username = self.username.text;
    user.password = self.password.text;
    //3
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
            
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
    
    */
   /*
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"Logging in";
    [hud show:YES];
    
    //Parse, upload to tracker object
    PFObject *sosObject = [PFObject objectWithClassName:@"SosContact"];
    
    sosObject[@"user"] = _username.text;
    sosObject[@"contact1Email"] = _password.text;
    
    [sosObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        hud.labelText = @"Sucess";
        [hud hide:YES];
        
        if (!error) {
          //  objectRecId = sosObject.objectId;
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];
    */
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}




@end
