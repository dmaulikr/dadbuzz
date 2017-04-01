//

#import <UIKit/UIKit.h>


#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate>

- (IBAction)recordAudio:(id)sender;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
- (IBAction)playAudio:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *saveAudio;
- (IBAction)uploadAudio:(id)sender;
- (IBAction)playFromCloud:(id)sender;
- (IBAction)tesPush:(id)sender;

- (IBAction)stopAudio:(id)sender;

/* Touch handler for the button */

@property (strong, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (strong, nonatomic) IBOutlet UISlider *ageControl;

@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
- (IBAction)updateInstallation:(id)sender;


- (IBAction)inCar:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *inCarLabel;

- (IBAction)leavingWork:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *leavingCarIndicator;
@property (weak, nonatomic) IBOutlet UIButton *leavingWorkLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UITextField *assignAudioFile;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
