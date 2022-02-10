//
//  SKUserListModal.h
//  DayDayEdu
//
//  Created by dayday30 on 2019/4/4.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKUserListModal : NSObject

@property (strong, nonatomic) NSArray *tokenAr;

+ (void)addTokenValue:(NSString *)token;
+ (void)removeTokenValue:(NSString *)token;

+ (NSArray *)getUserTokenArr;

@end

NS_ASSUME_NONNULL_END
