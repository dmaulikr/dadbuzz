//
//  dadLoginController.h
//  DadBuzz
//
//  Created by me on 29/08/2014.
//
//

#import <UIKit/UIKit.h>

@interface dadLoginController : UIViewController
- (IBAction)dadSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)dadLogin:(id)sender;
@end
