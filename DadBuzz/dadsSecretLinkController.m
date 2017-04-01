//
//  dadsSecretLinkController.m
//  DadBuzz
//
//  Created by me on 29/08/2014.
//
//

#import "dadsSecretLinkController.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "mumsNotificationScreen.h"

@interface dadsSecretLinkController ()

@end

@implementation dadsSecretLinkController



PFUser *currentUser;

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

- (IBAction)saveSecretLink:(id)sender {
    
  //  PFQuery *query;
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   hud.mode = MBProgressHUDModeIndeterminate;
    
   hud.labelText = @"locating dad...";
   [hud show:YES];
    
    
   //PFObject *userObject = [PFObject objectWithClassName:@"User"];
    
    
   // query = [PFQuery queryWithClassName:@"User"];
    currentUser = [PFUser currentUser];

    // Create a pointer to an object of class UserStats with id dlkj83d
   // PFObject *userObject = [PFObject objectWithoutDataWithClassName:@"User" objectId:@"dlkj83d"];
   // PFUser *user
   
    NSLog(currentUser.objectId);
    
    
    PFQuery *query = [PFUser query];
    
    [query whereKey:@"username" equalTo:self.dadsusername.text];
    [query whereKey:@"secretPassword" equalTo:self.secretKey.text];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(self.dadsusername.text);
        
     
    
        
        if (!error) {
            
            if (!objects || !objects.count){
                hud.labelText = @"can't find dad";
                [hud hide:YES];
                
                
                NSLog(@"objectis null");// do something because the object is null
            }else{
                hud.labelText = @"Dad found!";
                hud.labelText = @"Linking...";
                
               for (PFObject *object in objects) {
                
               //
                   PFQuery *query2 = [PFUser query];
                //   PFQuery *query = [PFUser objectWithoutDataWithObjectId:@"VHeQjEd3rg"];
                 //[PFUser objectWithoutDataWithObjectId:@"VHeQjEd3rg"];

                // Retrieve the object by id
                
                [query2 getObjectInBackgroundWithId:object.objectId block:^(PFObject *dadObject, NSError *error) {
                    
                    dadObject[@"channel"] = currentUser.objectId;
                    
                    NSLog(object.objectId);
                    

                    [PFCloud callFunction:@"editUser" withParameters:@{
                                                                       @"userId": currentUser.objectId,
                                                                       @"newColText": currentUser.objectId
                                                                     }];
                    
                    
                    [PFCloud callFunction:@"editUser" withParameters:@{
                                                                       @"userId": object.objectId,
                                                                       @"newColText": currentUser.objectId
                                                                     }];
                    
                    
                    
                    
                    //Send put notifcation to Data to notifly of link.
                    
                    //start
                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                           @"Mum now linked", @"alert",
                                          //@"daddyincar.wav", @"sound",
                                          nil];
                    PFPush *push = [[PFPush alloc] init];
                    [push setChannels:[NSArray arrayWithObjects:@"global", nil]];
                    [push setData:data];
                    
                    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
              
                        } else {
                            
                            //location service not enabled
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"eerrrmmm... this is awkward" message:@"Buzz didn't get through, must be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            
                        }
                    }];  //end
                
                    
                    

                     
                }];
   
                
                
                
                
               }
                
                
    
                
                
                [hud hide:YES];
                NSLog(@"record");
                
                mumsNotificationScreen *viewController = [[mumsNotificationScreen alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
                
                
                
            }
            
            
            

        } else {
            // Did not find any UserStats for the current user
            NSLog(@"Error: %@", error);
        }
        
        
    }];

    
    
    
    

    
    
    
    
    
    
}
@end
