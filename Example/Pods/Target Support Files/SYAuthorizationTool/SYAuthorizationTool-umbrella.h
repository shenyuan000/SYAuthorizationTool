#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SYAuthorizationAlert.h"
#import "SYAuthorizationCamera.h"
#import "SYAuthorizationContacts.h"
#import "SYAuthorizationLocation.h"
#import "SYAuthorizationManager.h"
#import "SYAuthorizationPhotos.h"

FOUNDATION_EXPORT double SYAuthorizationToolVersionNumber;
FOUNDATION_EXPORT const unsigned char SYAuthorizationToolVersionString[];

