//
//  landingController.m
//  DadBuzz
//
//  Created by me on 28/08/2014.
//
//

#import "landingController.h"
#import "dadLoginController.h"
#import "mumSignUpController.h"
#import "dadsSecretLinkController.h"
#import "mumLogin.h"




@implementation landingController


NSString *strFilePath;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/*

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
*/



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
  ////
         [PFUser logOut];
    
    //
   //dadsSecretLinkController *viewController = [[dadsSecretLinkController alloc] init];
   //[self.navigationController pushViewController:viewController animated:YES];
    
    
    
    
    
    
    
    
    PFUser *user;
    NSLog(@"DDD");
   // NSLog(user.objectId);
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        //    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        //  logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton;
        
        /*
        
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        logInViewController.delegate = self;
        //   logInViewController.facebookPermissions = @[@"friends_about_me"];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton;
        //     logInViewController.emailAsUsername=YES;
        
        
        // Customize the Sign Up View Controller
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
        // signUpViewController.emailAsUsername=YES;
        
        logInViewController.signUpController = signUpViewController;
        */
        
     //   [self presentViewController:logInViewController animated:NO completion:nil];
        
        
        
    }else{
        
      //  ViewController *viewController = [[ViewController alloc] init];
       // [self.navigationController pushViewController:viewController animated:YES];
        
        
        
        //need to check here to see if the current user is male or female. based on the gender I need
        // to direct the user to the corect sceen..
        
        
        
       // [self performSegueWithIdentifier:@"loginPush" sender:@"loginPush"];
        
    }
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dadAction:(id)sender {
    
    

  
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Mmm"];
    
    NSLog(@"asdasd");
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder if it doesn't already exist
    
    
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:@"http://www.noiseaddicts.com/samples/4927.mp3"];
    
  
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:soundFileURL]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               [data writeToFile:dataPath
                                      atomically:YES];
                               // Audio file is ready to be played.
                           }];
    
    
    
    
    
    
  //  NSLog(@"aXXXXXsdasd");
    
    
    
//  NSLog([[NSBundle mainBundle] pathForResource:@"dad		dyincar" ofType:@"wav"]);

    
   // dadLoginController *viewController = [[dadLoginController alloc] init];
    //[self.navigationController pushViewController:viewController animated:YES];
   


}




























- (IBAction)mumAction:(id)sender {
    mumLogin *viewController = [[mumLogin alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
   /*
    mumSignUpController *viewController = [[mumSignUpController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    */
    
}
@end
