//
//  SYAuthorizationAlert.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYAuthorizationAlert.h"
#import <UIKit/UIKit.h>


@implementation SYAuthorizationAlert
+ (void)displayAppPrivacySettings
{
    if (UIApplicationOpenSettingsURLString != NULL)
    {
        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if (@available(iOS 10,*)) {
            [[UIApplication sharedApplication]openURL:appSettings options:@{} completionHandler:^(BOOL success) {
            }];
        }
        else
        {
            [[UIApplication sharedApplication]openURL:appSettings];
        }
    }
}

+ (void)showAlertToDislayPrivacySettingWithTitle:(NSString*)title msg:(NSString*)message cancel:(NSString*)cancel setting:(NSString *)setting
{
    if (@available(iOS 8,*)) {
        
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //cancel
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:action];
        
        //ok
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:setting style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self displayAppPrivacySettings];
        }];
        [alertController addAction:okAction];
        
        [[self currentTopViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

+ (UIViewController*)currentTopViewController
{
    UIViewController *currentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    while ([currentViewController presentedViewController])    currentViewController = [currentViewController presentedViewController];
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]
        && ((UITabBarController*)currentViewController).selectedViewController != nil )
    {
        currentViewController = ((UITabBarController*)currentViewController).selectedViewController;
    }
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController*)currentViewController topViewController])
    {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    
    return currentViewController;
}
@end
