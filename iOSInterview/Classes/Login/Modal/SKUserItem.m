//
//  SKUserItem.m
//  DayDayEdu
//
//  Created by dayday30 on 2018/10/26.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import "SKUserItem.h"
#import "SKTokenStatic.h"

@implementation SKUserItem

MJCodingImplementation

+ (void)saveUser:(SKUserItem *)userItem{
    // 先缓存到本地
    [NSKeyedArchiver archiveRootObject:userItem toFile:[NSString saveStringWithOnly:@"userItem"]];
    
}

+ (SKUserItem *)getUser{
    SKUserItem *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString saveStringWithOnly:@"userItem"]];
    return temp;
}

+ (SKUserItem *)getUserWithToken:(NSString *)token{
    SKUserItem *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString saveStringWithOnly:@"userItem" token:token]];
    return temp;
}

@end
