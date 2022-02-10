//
//  SKUserItem.h
//  EduCare for Parents
//
//  Created by Somer.King on 2019/4/4.
//  Copyright © 2018年 Somer.King. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface SKTokenStatic : NSObject

+ (void)saveToken:(NSString *)token;

+ (NSString *)getToken;

@end
