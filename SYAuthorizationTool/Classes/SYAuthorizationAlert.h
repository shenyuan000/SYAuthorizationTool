//
//  SYAuthorizationAlert.h
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYAuthorizationAlert : NSObject
+ (void)displayAppPrivacySettings;
+ (void)showAlertToDislayPrivacySettingWithTitle:(NSString*)title
                                             msg:(NSString*)message
                                          cancel:(NSString*)cancel
                                         setting:(NSString*)setting;
@end
