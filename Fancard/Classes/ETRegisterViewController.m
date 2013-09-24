//
//  ETRegisterViewController.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-21.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETRegisterViewController.h"
#import "UIImage+UIColor.h"

@implementation ETRegisterViewController

#pragma mark - IBAction
- (IBAction) facebookBtnClick:(id)sender
{
    
}

- (IBAction) cameraBtnClick:(id) sender
{
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
    
}

- (IBAction) termsOfServiceBtnClick:(id) sender
{
    
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
    self.cameraLabel.text = @"Photo Add";
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
