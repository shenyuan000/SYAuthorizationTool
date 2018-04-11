//
//  SYAuthorizationCamera.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYAuthorizationCamera.h"

@implementation SYAuthorizationCamera
+ (void)requestWithcompletion:(AccessComplete)complete
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                complete(YES,NO);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                complete(NO,NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             if (complete) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     complete(granted,YES);
                                                 });
                                             }
                                         }];
                
            }
                break;
        }
    } else {
        // Prior to iOS 8 all apps were authorized.
        complete(YES,NO);
    }
}

@end
