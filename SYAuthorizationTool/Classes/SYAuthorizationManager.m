//
//  SYAuthorizationManager.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYAuthorizationManager.h"
#import "SYAuthorizationLocation.h"
#import "SYAuthorizationCamera.h"
#import "SYAuthorizationPhotos.h"
#import "SYAuthorizationContacts.h"

@implementation SYAuthorizationManager
+ (void)requestAccessType:(SYAuthorizationType)type accessStatus:(AccessComplete)completion
{
    switch (type) {
        case SYAuthorizationType_LocationSercices:
            [SYAuthorizationLocation requestWithcompletion:completion];
            break;
        case SYAuthorizationType_Camera:
            [SYAuthorizationCamera requestWithcompletion:completion];
            break;
        case SYAuthorizationType_Photos:
            [SYAuthorizationPhotos requestWithcompletion:completion];
            break;
        case SYAuthorizationType_Contacts:
            [SYAuthorizationContacts requestWithcompletion:completion];
            break;
            
        default:
            break;
    }
}
@end
