//
//  SYAuthorizationContacts.h
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@interface SYAuthorizationContacts : NSObject
typedef void(^AccessComplete)(BOOL isAccces,BOOL isFirst);
+ (void)requestWithcompletion:(AccessComplete)complete;
@end
