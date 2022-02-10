//
//  InitConfigSingleton.h
//  JinwowoNew
//
//  Created by jww_mac_002 on 2017/2/22.
//  Copyright © 2017年 wubangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalSingleton : NSObject


+(instancetype) shareInstance;


/**
 商店的APP版本
 */
@property(nonatomic,strong)NSString *appStoreVersion;


/**
 程序版本
 */
@property(nonatomic,strong)NSString *buildVersion;


/**
 设备类型名称
 */
@property(nonatomic,strong)NSString *deviceName;

/**
 设备操作系统
 */
@property(nonatomic,strong)NSString *deviceSystem;


/**
 设备操作系统版本
 */
@property(nonatomic,strong)NSString *deviceSystemVersion;


/**
 设备ID
 */
@property(nonatomic,strong)NSString *deviceID;

/**
 广告标识符
 */
@property(nonatomic,strong)NSString *IDFAStr;

// 国家
@property(nonatomic,strong)NSString *country;

@end
