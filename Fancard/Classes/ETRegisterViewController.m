//
//  ETRegisterViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-21.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETRegisterViewController.h"
#import "UIImage+UIColor.h"
#import "ETNetworkAdapter.h"
#import <MBProgressHUD.h>
#import <Facebook.h>
#import "ETAppDelegate.h"
#import "ETGlobal.h"
#import "SimpleAudioEngine.h"
@implementation ETRegisterViewController

- (void) rightBtnClick
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Loading..."];
    
    [[ETNetworkAdapter sharedAdapter] registerWithUsername:self.userName.text
                                                  password:self.passWord.text
                                                     email:self.email.text
                                                  trueName:self.name.text
                                                    avatar:self.avatarImage
                                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                       NSDictionary* dict =[responseObject objectFromJSONData];
                                                       if ([dict[@"msg"] isEqualToString:@"OK"])
                                                       {
                                                           
                                                           [ETGlobal sharedGlobal].avatar = self.avatarImage;
                                                           [ETGlobal sharedGlobal].userName = self.userName.text;
                                                           [ETGlobal sharedGlobal].userNumberCorrectanswer = 0;
                                                           [ETGlobal sharedGlobal].userNumberWatchedvideo = 0;
                                                           [ETGlobal sharedGlobal].userPointsToday = 0;
                                                           [ETGlobal sharedGlobal].userPointsTotal = 0;
                                                           
                                                           [[ETNetworkAdapter sharedAdapter] getVideoAndQuizStatusWithsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                               [hud setMode:MBProgressHUDModeText];
                                                               [hud setLabelText:@"Successful"];
                                                               [hud hide:YES afterDelay:1];
                                                               
                                                               NSDictionary* dict = [responseObject objectFromJSONData];
                                                               [ETGlobal sharedGlobal].videoUnlockCnt = [dict[@"video_unlock_cnt"] integerValue];
                                                               [ETGlobal sharedGlobal].quizUnlockCnt = [dict[@"quiz_unlock_cnt"] integerValue];
                                                               
                                                               double delayInSeconds = 1.0;
                                                               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                                               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                                   [self performSegueWithIdentifier:@"signin" sender:Nil];
                                                               });
                                                               
                                                           }
                                                                                                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                                                          NSLog(@"%@", [error localizedDescription]);
                                                                                                                          [hud setLabelText:@"error"];
                                                                                                                          [hud hide:1 afterDelay:1];
                                                                                                                          
                                                                                                                      }];
                                                       }
                                                       else
                                                       {
                                                           hud.labelText = @"Username already exists";
                                                           [hud setMode:MBProgressHUDModeText];
                                                           [hud hide:1 afterDelay:1];
                                                       }
                                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                       NSLog(@"%@", [error localizedDescription]);
                                                       [hud setLabelText:@"error"];
                                                       [hud hide:1 afterDelay:1];
                                                   }];
}

#pragma mark - IBAction

- (IBAction) checkFin
{
    self.rightBtn.disabled = YES;
    if (self.userName.text.length == 0) return;
    if (self.passWord.text.length == 0) return;
    if (self.email.text.length == 0) return;
    if (!self.avatarImage) return;
    if (self.name.text.length == 0) return;
    
    self.rightBtn.disabled = NO;
}

- (IBAction) facebookBtnClick:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    if( ![[FBSession activeSession] isOpen] )
    {
        __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading..";
        
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"]
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
        {
            if( error )
            {
                hud.labelText = @"Load Failed";
                [hud hide:YES afterDelay:1];
            }
            else
            {
                NSLog(@"%@", [FBSession activeSession].accessTokenData.accessToken);
                [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                    if (!error) {
                        self.name.text = user.name;
                        self.email.text = [user objectForKey:@"email"];
                        
                        [[ETNetworkAdapter sharedAdapter] getFacebookAvatarWithID:user.id
                                                                          success:^(AFHTTPRequestOperation *operation, id responseObject)
                        {
                            
                            self.avatarImage = [UIImage imageWithData:responseObject];
                            [hud hide:YES];
                            self.cameraLabel.text = @"Photo Added";
                            [self checkFin];
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                        {
                            hud.labelText = @"Avatar Load Failed";
                            [hud hide:YES afterDelay:1];
                        }];
                    }
                    else
                    {
                        hud.labelText = @"Load Failed";
                        [hud hide:YES afterDelay:1];
                    }
                }];
            }
        }];
    }
    
}

- (void)updateView {
    // get the app delegate, so that we can reference the session property
    
}
- (IBAction) cameraBtnClick:(id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
    [self closeKeyBoard:nil];
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    [actionSheet showInView:self.view];
}

- (IBAction) privacyPolicyBtnClick:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
}

- (IBAction) termsOfServiceBtnClick:(id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"dribble_buttons.mp3"];
}

- (IBAction) closeKeyBoard:(id)sender
{
    [self.view endEditing:YES];
    if (self.view.frame.origin.y != 0)
    {
        [UIView animateWithDuration:.25
                         animations:^{
                             CGRect rect = self.view.frame;
                             rect.origin.y = 0;
                             self.view.frame = rect;
                         }];
    }
}

- (NSMutableAttributedString*) strWithUnderline:(NSString*) str
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    
    [string addAttribute:NSUnderlineStyleAttributeName
                          value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                          range:NSMakeRange(0, [string length])];
    
    [string addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"9e7f38"]
                          range:NSMakeRange(0, [string length])];
    return string;
}

#pragma mark - Notification
- (void) startEditing:(NSNotification*) notification
{
    if (self.name.editing || self.email.editing)
    {
        [UIView animateWithDuration:.25
                         animations:^{
                             CGRect rect = self.view.frame;
                             rect.origin.y = -170;
                             self.view.frame = rect;
                         }];
    }
}

#pragma mark - UIViewController
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftBtnWithString:@"WELCOME"];
    [self setRightBtnWithString:@"SIGN UP"];
    self.rightBtn.disabled = YES;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.userName setValue:[UIColor colorWithHexString:@"9e7f38"]
                 forKeyPath:@"_placeholderLabel.textColor"];
    [self.passWord setValue:[UIColor colorWithHexString:@"9e7f38"]
                 forKeyPath:@"_placeholderLabel.textColor"];
    [self.name setValue:[UIColor colorWithHexString:@"9e7f38"]
             forKeyPath:@"_placeholderLabel.textColor"];
    [self.email setValue:[UIColor colorWithHexString:@"9e7f38"]
              forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.termsOfService setAttributedTitle:[self strWithUnderline:@"terms of service"]
                                   forState:UIControlStateNormal];
    [self.privacyPolicy setAttributedTitle:[self strWithUnderline:@"privacy policy"]
                                  forState:UIControlStateNormal];
    
    [self.camera setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor colorWithHexString:@"dbdbdb"]]
                           forState:UIControlStateHighlighted];
    [self.facebook setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor colorWithHexString:@"dbdbdb"]]
                             forState:UIControlStateHighlighted];
    if (iPhone5)
    {
        CGRect rect = self.licenceView.frame;
        rect.origin.y += 44;
        self.licenceView.frame = rect;
    }
    
    self.userName.font = [UIFont fontWithName:kDefaultFont size:20];
    self.passWord.font = [UIFont fontWithName:kDefaultFont size:20];
    self.email.font = [UIFont fontWithName:kDefaultFont size:20];
    self.cameraLabel.font = [UIFont fontWithName:kDefaultFont size:20];
    self.name.font = [UIFont fontWithName:kDefaultFont size:20];
}

#pragma mark - UIActionSheet Delegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) return;
    UIImagePickerController* controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.allowsEditing = YES;
    if (buttonIndex == 0)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:controller
                               animated:YES
                             completion:nil];
        }
        else
        {
            alert(@"Your device doesn't support this feature");
        }
    }
    
    if (buttonIndex == 1)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:controller
                               animated:YES
                             completion:nil];
        }
        else
        {
            alert(@"Your device doesn't support this feature");
        }
    }
}

#pragma mark - UIImagePickerView Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.avatarImage = image;
    self.cameraLabel.text = @"Photo Added";
    [self checkFin];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
