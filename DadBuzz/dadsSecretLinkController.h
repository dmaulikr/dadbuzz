//
//  dadsSecretLinkController.h
//  DadBuzz
//
//  Created by me on 29/08/2014.
//
//

#import <UIKit/UIKit.h>

@interface dadsSecretLinkController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *secretKey;
@property (weak, nonatomic) IBOutlet UITextField *dadsusername;

- (IBAction)saveSecretLink:(id)sender;
@end
