//
//  SYAuthorizationManager.h
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYAuthorizationAlert.h"

typedef NS_ENUM(NSInteger,SYAuthorizationType) {
    SYAuthorizationType_LocationSercices    = 0,//定位服务
    SYAuthorizationType_Camera              = 1,//相机
    SYAuthorizationType_Photos              = 2,//照片
    SYAuthorizationType_Contacts            = 3//通讯录
};

typedef void(^AccessComplete)(BOOL isAccces,BOOL isFirst);

@interface SYAuthorizationManager : NSObject

+ (void)requestAccessType:(SYAuthorizationType)type accessStatus:(AccessComplete)completion;

@end
