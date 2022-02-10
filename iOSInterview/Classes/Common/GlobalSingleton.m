//
//  InitConfigSingleton.m
//  JinwowoNew
//  APP全局单例模式属性
//  Created by jww_mac_002 on 2017/2/22.
//  Copyright © 2017年 wubangxin. All rights reserved.
//

#import "GlobalSingleton.h"
#import "sys/utsname.h"
#import "getUUID.h"
#import <AdSupport/AdSupport.h>

@implementation GlobalSingleton

static GlobalSingleton * _instance = nil;

+(instancetype) shareInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _instance = [[super allocWithZone:NULL] init];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        CFShow((__bridge CFTypeRef)(infoDictionary));
        
        ///商店的APP版本
        _instance.appStoreVersion = infoDictionary[@"CFBundleShortVersionString"];
        
        ///程序版本
        _instance.buildVersion = infoDictionary[@"CFBundleVersion"];
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        ///设备类型名称
        _instance.deviceName = deviceString;
        
        ///设备操作系统
        _instance.deviceSystem = @"IOS";
        
        ///设备操作系统版本
        _instance.deviceSystemVersion = infoDictionary[@"DTPlatformVersion"];
        
        ///设备ID
//        _instance.deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        _instance.deviceID = [getUUID getUUID];
        
        NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
        _instance.IDFAStr = adId;
//        _instance.IDFAStr = [NTStatistics userIdentifier];
        
        NSLocale*locale = [NSLocale currentLocale];
        if (@available(iOS 10.0, *)) {
            _instance.country = locale.countryCode;
        } else {
            // Fallback on earlier versions
        }
    });
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone{
    
    return [GlobalSingleton shareInstance] ;
}


-(id) copyWithZone:(struct _NSZone *)zone{
    
    return [GlobalSingleton shareInstance] ;
}


@end
