//
//  ETAppDelegate.m
//  Fancard
//
//  Created by Xiaoxuan Tang on 13-9-15.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "ETAppDelegate.h"
#import <UIColor+Expanded.h>
#import <AFNetworking.h>
#import "ETMacro.h"
#import "UIImage+UIColor.h"

@implementation ETAppDelegate

- (void) customAppearance
{
    if (iOS7)
    {   
        [[UINavigationBar appearance] setTintColor: [UIColor colorWithHexString:@"56527c"]];
    }
    else
    {
        
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] createImageWithColor:[UIColor whiteColor]]
                                           forBarMetrics:UIBarMetricsDefault];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[FBSession activeSession]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // See if the app has a valid token for the current state.
    return YES;
}
							
- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object
    [[FBSession activeSession] close];
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // FBSample logic
    // Call the 'activateApp' method to log an app event for use in analytics and advertising reporting.
    [FBAppEvents activateApp];
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
     [FBAppCall handleDidBecomeActive];
}

@end
