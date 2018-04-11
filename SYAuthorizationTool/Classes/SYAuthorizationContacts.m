//
//  SYAuthorizationContacts.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYAuthorizationContacts.h"
#import <AddressBook/AddressBook.h>

@implementation SYAuthorizationContacts
+ (void)requestWithcompletion:(AccessComplete)complete
{
    if (@available(iOS 9,*))
    {
            CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
            switch (status)
            {
                case CNAuthorizationStatusAuthorized:
                {
                    if (complete) {
                        complete(YES,NO);
                    }
                }
                    break;
                case CNAuthorizationStatusDenied:
                case CNAuthorizationStatusRestricted:
                {
                    if (complete) {
                        complete(NO,NO);
                    }
                }
                    break;
                case CNAuthorizationStatusNotDetermined:
                {
                    [[CNContactStore new] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (complete) {
                                complete(granted,YES);
                            }
                        });
                    }];
                    
                }
                    break;
            }
    }
    else
    {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        
        switch (status) {
            case kABAuthorizationStatusAuthorized: {
                if (complete) {
                    complete(YES,NO);
                }
            } break;
            case kABAuthorizationStatusNotDetermined: {
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    if (complete) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            complete(granted,YES);
                        });
                    }
                });
            } break;
            case kABAuthorizationStatusRestricted:
            case kABAuthorizationStatusDenied: {
                if (complete) {
                    complete(NO,NO);
                }
            } break;
        }
    }
}
@end
