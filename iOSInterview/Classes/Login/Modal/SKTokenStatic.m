//
//  SKUserItem.m
//  EduCare for Parents
//
//  Created by Somer.King on 2019/4/4.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKTokenStatic.h"

#define UserToken @"now_user_token"

@implementation SKTokenStatic

static NSString *ACCESS_TOKEN = @"";

+ (void)saveToken:(NSString *)token{
    // 先缓存到本地
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:UserToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ACCESS_TOKEN = token;
}

+ (NSString *)getToken{
    if (ACCESS_TOKEN.length == 0) {
        ACCESS_TOKEN = [[NSUserDefaults standardUserDefaults] objectForKey:UserToken];
    }
    if (ACCESS_TOKEN == nil) {
        return @"";
    }else{
        return ACCESS_TOKEN;
    }
    
}

@end
