//
//  dadSignupController.h
//  DadBuzz
//
//  Created by me on 29/08/2014.
//
//

#import <UIKit/UIKit.h>

@interface dadSignupController : UIViewController
- (IBAction)dadSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *secretDadLink;
@property (weak, nonatomic) IBOutlet UITextField *secretLink;

@property (weak, nonatomic) IBOutlet UITextField *password;
@end
