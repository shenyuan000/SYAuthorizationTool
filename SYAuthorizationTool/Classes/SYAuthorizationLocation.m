//
//  SYAuthorizationLocation.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYAuthorizationLocation.h"
#import <UIKit/UIKit.h>

@interface SYAuthorizationLocation ()<CLLocationManagerDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^permissionCompletion)(BOOL granted,BOOL firstTime);
@end

@implementation SYAuthorizationLocation
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SYAuthorizationLocation *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[SYAuthorizationLocation alloc] init];
    });
    return instance;
}

+ (BOOL)authorized
{
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    return authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse;
}

+ (CLAuthorizationStatus)authorizationStatus;
{
    return  [CLLocationManager authorizationStatus];
}

+ (void)requestWithcompletion:(AccessComplete)complete
{
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    switch (authorizationStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            if (complete) {
                complete(YES,NO);
            }
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            if (![CLLocationManager locationServicesEnabled]) {
                if (complete) {
                    complete(NO,NO);
                }
                return;
            }
            
            [[SYAuthorizationLocation sharedInstance]startGps:complete];
        }
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted: {
            if (complete) {
                complete(NO,NO);
            }
        } break;
            
        default:
            break;
    }
}

- (void)startGps:(void(^)(BOOL access,BOOL firstTime))completion
{
    if ( self.locationManager != nil ) {
        [self stopGps];
    }
    
    self.permissionCompletion = completion;
    
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        BOOL hasAlwaysKey = [[NSBundle mainBundle]
                             objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;
        BOOL hasWhenInUseKey =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] !=
        nil;
        if (hasAlwaysKey) {
            [_locationManager requestAlwaysAuthorization];
        } else if (hasWhenInUseKey) {
            [_locationManager requestWhenInUseAuthorization];
        } else {
            // At least one of the keys NSLocationAlwaysUsageDescription or
            // NSLocationWhenInUseUsageDescription MUST be present in the Info.plist
            // file to use location services on iOS 8+.
            NSAssert(hasAlwaysKey || hasWhenInUseKey,
                     @"To use location services in iOS 8+, your Info.plist must "
                     @"provide a value for either "
                     @"NSLocationWhenInUseUsageDescription or "
                     @"NSLocationAlwaysUsageDescription.");
        }
    }
    [self.locationManager startUpdatingLocation];
}

- (void)stopGps
{
    if ( self.locationManager )
    {
        [_locationManager stopUpdatingLocation];
        self.locationManager = nil;
    }
}

#pragma mark - CLLoctionDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            //access permission,first callback this status
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            
            [self stopGps];
            if (_permissionCompletion) {
                _permissionCompletion(YES,YES);
            }
            self.permissionCompletion = nil;
        }
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted: {
            
            [self stopGps];
            if (_permissionCompletion) {
                _permissionCompletion(NO,YES);
            }
            self.permissionCompletion = nil;
            break;
        }
    }
    
}



@end
