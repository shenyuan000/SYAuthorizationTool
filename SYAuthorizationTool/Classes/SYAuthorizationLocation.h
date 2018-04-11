//
//  SYAuthorizationLocation.h
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void(^AccessComplete)(BOOL isAccces,BOOL isFirst);
@interface SYAuthorizationLocation : NSObject
+ (void)requestWithcompletion:(AccessComplete)complete;
@end
