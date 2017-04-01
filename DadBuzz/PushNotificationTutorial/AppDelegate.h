//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class AppDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) ViewController *viewController;

@end
