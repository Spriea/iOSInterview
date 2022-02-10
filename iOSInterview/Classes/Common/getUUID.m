//
//  getUUID.m
//  getUUID
//
//  Created by ckl@pmm on 16/9/18.
//  Copyright © 2016年 CKLPronetway. All rights reserved.
//

#import "getUUID.h"
#import "KeyChainStore.h"
#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"

@implementation getUUID

+ (NSString *)getUUID {
    NSString * strUUID = (NSString *)[KeyChainStore load:KEY_USERNAME_PASSWORD];
//    // 首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID) {
        // 生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
       // 将该uuid保存到keychain
        [KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID.length>0?strUUID:[self createUuid]];
    }
    return strUUID;
}

+ (NSString*)createUuid {
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *uuidStr = [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    return uuidStr.length >0?uuidStr:@"";
}

@end
