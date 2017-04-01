//

#import "AppDelegate.h"
#import "ViewController.h"
#import "landingController.h"
#import <CoreAudio/CoreAudioTypes.h>
#import "dadLoginController.h"


@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
    // [Parse setApplicationId:@"your_application_id" clientKey:@"your_client_key"];
    // ****************************************************************************
    
    // Override point for customization after application launch.
    [Parse setApplicationId:@"drcJfQlFHlfvAwR6FmntPqfi5zqqiCZHEKJTC41g"
                  clientKey:@"ObCygopMraeoMK6N8pPWkD1I37BpdR99y9IJOTNf"];
    
    
    // Override point for customization after application launch.
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge];
    
    
   // self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
   
    
  // self.viewController = [[landingController alloc] initWithNibName:@"landingController" bundle:nil];

                          
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[landingController alloc] init]];
    
    
    
   // self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
//  self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [self.window makeKeyAndVisible];

    [PFUser enableAutomaticUser];
    PFACL *defaultACL = [PFACL ACL];
    // Optionally enable public read access while disabling public write access.
    // [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    return YES;
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:@"JU7NqURpWB"];
    //  PFUser *user = (PFUser *)[query getFirstObject];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d audios.", objects.count);
            // Do something with the found objects
            
            
            for (PFObject *object in objects) {
                
                
                NSLog(@"%@", object.objectId);
                PFFile *audioFile = object[@"DadBuzz1"];
                
                [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error2) {
                    // NSData object 'result' which contains the audio file.
                    if (!error2) {
                        NSLog(@"Got the audio");
                        NSLog(@"AUdio Size : %d", result.length);
                        
                        
                        //   AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:result error:NULL];
                        
                        _audioPlayer = [[AVAudioPlayer alloc]
                                        initWithData:result
                                        error:&error2];
                        
                        _audioPlayer.delegate = self;
                        
                        
                        if (error)
                        NSLog(@"Error: %@",
                              [error localizedDescription]);
                        else
                        {
                            self.audioPlayer.volume=1.0;
                            [_audioPlayer play];
                            [self.audioPlayer play];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        //   [player setDelegate:self];
                        //  [player play];
                    }
                    else {
                        NSLog(@"failed to get the audio");
                    }
                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
    
    
    
    
    
    
    [PFPush handlePush:userInfo];
}


@end
