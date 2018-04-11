//
//  SYAuthorizationPhotos.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYAuthorizationPhotos.h"

@implementation SYAuthorizationPhotos
+ (void)requestWithcompletion:(AccessComplete)complete
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusAuthorized:
        {
            if (complete) {
                complete(YES,NO);
            }
        }
            break;
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
        {
            if (complete) {
                complete(NO,NO);
            }
        }
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (complete) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        complete(status == PHAuthorizationStatusAuthorized,YES);
                    });
                }
            }];
        }
            break;
        default:
        {
            if (complete) {
                complete(NO,NO);
            }
        }
            break;
    }
}

@end
