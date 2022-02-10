//
//  SKHTTPError.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/24.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKHTTPError.h"

/**
 -100    系统内部错误
 51    接口尚未提供
 53    账号类型错误
 55    参数不足或错误，一般为接口必填参数不足或类型错误
 150    未登录或登录超时/token错误
 153    Token 丢失111
 */

@implementation SKHTTPError

SKInstanceM(Error)

- (NSDictionary *)errors{
    return @{
             @"-100" : @"系统内部错误",
             @"51" : @"接口尚未提供",
             @"53" : @"账号类型错误",
             @"55" : @"参数不足或错误，一般为接口必填参数不足或类型错误",
             @"150" : @"未登录或登录超时/token错误",
             @"153" : @"Token 丢失111"
             };
}

- (NSString *)errorWithCode:(NSString *)code inErrorDictionary:(NSDictionary *)dict{
    return @"";
}

@end
