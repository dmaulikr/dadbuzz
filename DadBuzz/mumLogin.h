//
//  mumLogin.h
//  DadBuzz
//
//  Created by me on 11/09/2014.
//
//

#import <UIKit/UIKit.h>

@interface mumLogin : UIViewController
- (IBAction)mumSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)mumLogin:(id)sender;
@end
