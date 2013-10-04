//
//  ETPracticeConfrim2ViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETPracticeConfrim2ViewController.h"
#import "ETPracticeConfrim3ViewController.h"
#import "SimpleAudioEngine.h"
#if !TARGET_IPHONE_SIMULATOR
#define HAS_AVFF 1
#endif

@implementation ETPracticeConfrim2ViewController

- (void)toggleFlashlight
{
#if HAS_AVFF
    
    
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff)
    {
        // Create an AV session
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        
        // Create device input and add to current session
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error: nil];
        [session addInput:input];
        
        // Create video output and add to current session
        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
        [session addOutput:output];
        
        // Start session configuration
        [session beginConfiguration];
        [device lockForConfiguration:nil];
        
		// Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        
        [device unlockForConfiguration];
        [session commitConfiguration];
        
        // Start the session
        [session startRunning];
        
		// Keep the session around
        self.session = session;
    }
    else 
    {
        [self.session stopRunning];
    }
#endif
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftBtnWithString:nil];
    [self setRightBtnWithString:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStart)
                                                 name:AVCaptureSessionDidStartRunningNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.session)
        [self toggleFlashlight];
    
    [self.timer invalidate];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#if HAS_AVFF
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isTorchModeSupported:AVCaptureTorchModeOn]) {
        [self toggleFlashlight];
    }
    else
    {
        [self sessionStart];
    }
#else
    [self sessionStart];
#endif
}

- (void) sessionStart
{
    self.time = 10/0.02;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.02
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
    [[SimpleAudioEngine sharedEngine] playEffect:@"heartbeat 2.mp3"];
}

- (void) tick
{
    self.time = self.time-1;
    self.label.text = [NSString stringWithFormat:@"%d", (int) ceil(self.time/50.)];
    self.progressView.progress = 1-self.time/10.*0.02;
    
    if (self.time == 0)
    {
        [self.timer invalidate];
        ETPracticeConfrim3ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ETPracticeConfrim3ViewController"];
        vc.video = self.video;
        [[self navigationController] pushViewController:vc animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DACircularProgressView* progress = [[DACircularProgressView alloc] initWithFrame:CGRectMake(81, 215, 158, 158)];
//    if (iPhone5 && !iOS7)
//    {
//        [progress setFrame:CGRectMake(81, 225, 158, 158)];
//    }
    progress.trackTintColor = [UIColor colorWithHexString:@"d3d3d3"];
    progress.progressTintColor = [UIColor colorWithHexString:@"575179"];
    progress.progress = 0;
    progress.thicknessRatio = .22;
    [self.view addSubview:progress];
    
    
    UILabel* label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kDigitalFont size:50];
    label.text = @"10";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.origin.x = 160 - 50;
    frame.origin.y = 235;
    frame.size.height = 60;
    frame.size.width = 100;
    if (iOS7)
    {
        frame.origin.y += 6;
    }
    label.frame = frame;
    
    [self.view addSubview:label];
    self.label = label;
    if (iPhone5)
    {
        self.imageView.image = [UIImage imageNamed:@"practice_confirm2@2x~568.jpg"];
        self.imageView.frame = CGRectMake(0, 64, 320, 504);
        
        frame.origin.y += 5;
        label.frame = frame;
    }
    
    self.progressView= progress;
    self.wantsFullScreenLayout = YES;
}

- (void) leftSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    
}
@end
