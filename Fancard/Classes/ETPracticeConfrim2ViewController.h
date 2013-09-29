//
//  ETPracticeConfrim2ViewController.h
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-29.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETBasedViewController.h"
#import "ETVideo.h"
#import <AVFoundation/AVFoundation.h>
#import <DACircularProgressView.h>

@interface ETPracticeConfrim2ViewController : ETBasedViewController

@property (nonatomic, weak) IBOutlet    UIImageView*        imageView;
@property (nonatomic, strong)           ETVideo*            video;
@property (nonatomic, strong)           AVCaptureSession*   session;
@property (nonatomic ,strong)           NSTimer*            timer;
@property (nonatomic, weak)             DACircularProgressView* progressView;
@property (nonatomic, assign)           int                 time;
@property (nonatomic, weak)             UILabel*            label;
@end
