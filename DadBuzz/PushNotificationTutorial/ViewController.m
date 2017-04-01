//

#import "ViewController.h"
#import <Parse/Parse.h>

#import <CoreAudio/CoreAudioTypes.h>

#import "MBProgressHUD.h"


@implementation ViewController


NSArray *_pickerData;

PFUser *currentUser;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playButton.enabled = NO;
    _stopButton.enabled = NO;
    
    NSLog(@"SASSS");
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.m4a"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];
    
    _audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSetting
                      error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        
        [_audioRecorder prepareToRecord];
    }
    
    
    
    
    
    UIPickerView *cityPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [cityPicker setShowsSelectionIndicator:YES];
    self.assignAudioFile.inputView = cityPicker;
    
    
    
    // Create done button in UIPickerView
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    [barItems addObject:doneBtn];
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.assignAudioFile.inputAccessoryView = mypickerToolbar;
    
    
    _pickerData = @[@"Select BUZZ to replace", @"DadBuzz 1", @"DadBuzz 2", @"DadBuzz 3"];
    
    
    self.picker.delegate = self;
    self.picker.dataSource = self;
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    self.leavingWorkLabel.alpha=0.4;
    self.inCarLabel.alpha=0.4;
    
    [self setTitle:NSLocalizedString(@"DadBuzz", @"DadBuzz")];
    
    [UIView animateWithDuration:1 animations:^{
        self.leavingWorkLabel.alpha = 1;
        self.inCarLabel.alpha = 1;
    }];
    
    [self loadInstallData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)updateInstallation:(id)sender {
    NSLog(@"updateInstallation");
    NSString *gender = @"male";
    if (self.genderControl.selectedSegmentIndex == 1) {
        gender = @"female";
    }
    NSNumber *age = [NSNumber numberWithInt:(int)self.ageControl.value];
    PFInstallation *install = [PFInstallation currentInstallation];
    [install setObject:age forKey:@"age"];
    [install setObject:gender forKey:@"gender"];
    [install saveInBackground];
}


- (IBAction)inCar:(id)sender {
    
   
    
    [sender setTitle:@"" forState:UIControlStateNormal];
    [self.activityIndicator startAnimating];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                         // @"I'm in the car", @"alert",
                          @"daddyincar.wav", @"sound",
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:[NSArray arrayWithObjects:@"global", nil]];
    [push setData:data];
    
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            [self.activityIndicator stopAnimating];
            [sender setTitle:@"Sent!" forState:UIControlStateNormal];
            [sender setTitle:@"In the car!" forState:UIControlStateNormal];
            
        } else {
            
            [self.activityIndicator stopAnimating];
            
            
            [sender setTitle:@"In the car!" forState:UIControlStateNormal];
            
            
            
            //location service not enabled
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"eerrrmmm... this is awkward" message:@"Buzz didn't get through, must be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
    
        }
    }];

    
}

- (IBAction)leavingWork:(id)sender {
   
    [sender setTitle:@"" forState:UIControlStateNormal];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat halfButtonHeight = self.leavingWorkLabel.bounds.size.height / 2;
    CGFloat buttonwidth = self.leavingWorkLabel.bounds.size.width / 1.7;
    indicator.center = CGPointMake(buttonwidth - halfButtonHeight, halfButtonHeight);
    [self.leavingWorkLabel addSubview:indicator];
    [indicator startAnimating];
    
    
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          //@"I'm leaving work", @"alert",
                          @"daddyleaveswork.wav", @"sound",
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:[NSArray arrayWithObjects:@"global", nil]];
    [push setData:data];
    
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

        if (!error) {
            
           // [_activityIndicator stopAnimating];
            [indicator stopAnimating];
            [sender setTitle:@"Sent!" forState:UIControlStateNormal];
     
            [sender setTitle:@"I'm leaving work!" forState:UIControlStateNormal];
            
        } else {
          //  [_activityIndicator stopAnimating];
            
            [indicator stopAnimating];
            
            [sender setTitle:@"I'm leaving work!" forState:UIControlStateNormal];
    
            //location service not enabled
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"eerrrmmm... this is awkward" message:@"Buzz didn't get through, must be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
        }
        
    }];
    
    
}




















-(void)pickerDoneClicked
{
    NSLog(@"Done Clicked");
    [self.assignAudioFile resignFirstResponder];
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}
// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    NSLog(_pickerData[row]);
    self.assignAudioFile.text = (NSString *)[_pickerData objectAtIndex:row];
    
    
    
}












- (void)loadInstallData {
    
    NSLog(@"loadInstallData");
    PFInstallation *install = [PFInstallation currentInstallation];
    NSNumber *age = [install objectForKey:@"age"];
    NSString *gender = [install objectForKey:@"gender"];

    // Handle saved age, or populate default age.
    if (!age) {
        age = [NSNumber numberWithInt:10];
        [install setObject:age forKey:@"age"];
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@", age];
    self.ageControl.value = [age floatValue];
    
    // Handle saved gender, or populate default gender.
    if ([gender isEqualToString:@"male"]) {
        self.genderControl.selectedSegmentIndex = 0;
    } else if ([gender isEqualToString:@"female"]) {
        self.genderControl.selectedSegmentIndex = 1;
    } else {
        self.genderControl.selectedSegmentIndex = 0;
        [install setObject:@"male" forKey:@"gender"];
    }
    
    [install saveInBackground];
    
}

- (IBAction)recordAudio:(id)sender {
    
    
    
    if (!_audioRecorder.recording)
    {
        _playButton.enabled = NO;
        _stopButton.enabled = YES;
        
        
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        [_audioRecorder recordForDuration:5];
        [_audioRecorder record];
        
        
        
        
        
        
    }
    
    
    
}
- (IBAction)playAudio:(id)sender {
    
    if (!_audioRecorder.recording)
    {
        _stopButton.enabled = YES;
        _recordButton.enabled = NO;
        
        NSError *error;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        _audioPlayer = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:_audioRecorder.url
                        error:&error];
        
        _audioPlayer.delegate = self;
        
        if (error)
        NSLog(@"Error: %@",
              [error localizedDescription]);
        else
        {
            
            [_audioPlayer play];
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
- (IBAction)uploadAudio:(id)sender {
    
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.labelText = @"Uploading a new BUZZ";
    [hud show:YES];

    
   // NSString *selection = _assignAudioFile.text;
    
  //  [selection stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // This is your current user
    PFUser *currentUser = [PFUser currentUser];
    NSURL *audioPath = _audioPlayer.url;
    NSData *audioData = [NSData dataWithContentsOfURL:audioPath];
    //create PFFile to store audio data
    PFFile *audioFile = [PFFile fileWithName:@"sound.m4a" data:audioData];
    
    
    
    
    if ([_assignAudioFile.text isEqualToString:@"DadBuzz 1"]) {
        NSLog(@"matched");
        [currentUser setObject:audioFile forKey:@"DadBuzz1"];
        
    }else if ([_assignAudioFile.text isEqualToString:@"DadBuzz 2"]){
        
        [currentUser setObject:audioFile forKey:@"DadBuzz2"];
        
    }else if ([_assignAudioFile.text isEqualToString:@"DadBuzz 3"]){
        [currentUser setObject:audioFile forKey:@"DadBuzz3"];
    }
    


    
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
      hud.labelText=@"done!";
             [hud hide:YES];
            NSLog(@"uploaded");
        } else {
            NSLog(error);
        }
        
    }];
    
    
    
    /*
    
    testObject[@"audioFile"] = audioFile;
    
    //save
    [testObject saveInBackground];
    
    NSLog(@"A");
    
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        
        if (!error) {
            
            NSLog(@"uploaded");
        } else {
            NSLog(error);
        }
        
    }];
    
    
    */
    
    
    
    
    
    
}


- (IBAction)playFromCloud:(id)sender {
   
  
    
    currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:currentUser.objectId];
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
    
    
    
    
    
    
}

- (IBAction)tesPush:(id)sender {
    
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"I'm in the car", @"alert",
                        //  @"daddyincar.wav", @"sound",
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:[NSArray arrayWithObjects:@"wRFSCmMwpj", nil]];
    [push setData:data];
    
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            
        } else {
            
                    //location service not enabled
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"eerrrmmm... this is awkward" message:@"Buzz didn't get through, must be a network issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
        }
    }];
    
    
    
    
    
    
    
    
    
    
    
    
}

- (IBAction)stopAudio:(id)sender {
    
    _stopButton.enabled = NO;
    _playButton.enabled = YES;
    _recordButton.enabled = YES;
    
    if (_audioRecorder.recording)
    {
        [_audioRecorder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        
        
    } else if (_audioPlayer.playing) {
        
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        
        [_audioPlayer stop];
        
    }
  
}



-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    _recordButton.enabled = YES;
    _stopButton.enabled = NO;
    
    
    /*
     PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
     
     //  //get the audio in NSData format
     // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"02 Interstellar Overdrive" ofType:@"m4a"];]
     
     NSURL *audioPath = _audioPlayer.url;
     
     NSData *audioData = [NSData dataWithContentsOfURL:audioPath];
     
     //create PFFile to store audio data
     PFFile *audioFile = [PFFile fileWithName:@"sound.m4a" data:audioData];
     testObject[@"audioFile"] = audioFile;
     
     //save
     [testObject saveInBackground];
     
     NSLog(@"A");
     */
    
    
}




-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}



- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    
    // [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    
    //[stopButton setEnabled:NO];
    //[playButton setEnabled:YES];
    
    NSLog(@"SSSS");
    
    
    
    
}

-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}















@end
