//
//  SKUserItem.h
//  DayDayEdu
//
//  Created by dayday30 on 2018/10/26.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 {
 "qcard_icon" : "",
 "head_pic" : "http:\/\/thirdwx.qlogo.cn\/mmopen\/XsNwDHPY3RdnfDV135w4zA9rumMutlcibmd0icUmiah9gHnNV6XzjGghUdaAMQ3tlzBUR74FnCEf3I5HFe3LGTdvAJXAAVm4zmI\/132",
 "gold" : "144827",
 "pkgrade" : "毅力青铜",
 "level" : "L0",
 "voucher" : "100",
 "overdue_qcard_num" : 0,
 "name" : "Tom Ma",
 "pkgrade_icon" : "http:\/\/test.dayday30.cn\/yhw\/rw\/dictionary\/api\/web\/..\/..\/..\/resources\/55QaKbSgl180\/nbZNJ8LC8N1524449727.png"
 }
 */
@interface SKUserItem : NSObject <NSCoding>

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *ename;
@property (strong, nonatomic) NSString *cname;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *app_personal_label;

+ (void)saveUser:(SKUserItem *)userItem;
+ (SKUserItem *)getUser;
+ (SKUserItem *)getUserWithToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
