//
//  SKUserListModal.m
//  DayDayEdu
//
//  Created by dayday30 on 2019/4/4.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import "SKUserListModal.h"
#define userToken @"user_list_token"
@implementation SKUserListModal

+ (NSArray *)getUserTokenArr{
    NSArray *temp = [[NSUserDefaults standardUserDefaults] objectForKey:userToken];
    return temp;
}

+ (void)addTokenValue:(NSString *)token{
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:[self getUserTokenArr]];
    for (NSString *str in mutArr) {
        if ([token isEqualToString:str]) {
            return;
        }
    }
    [mutArr addObject:token];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutArr forKey:userToken];
}
+ (void)removeTokenValue:(NSString *)token{
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:[self getUserTokenArr]];
    [mutArr removeObject:token];
    [[NSUserDefaults standardUserDefaults] setObject:mutArr forKey:userToken];
}

@end
