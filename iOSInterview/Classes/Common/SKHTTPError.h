//
//  SKHTTPError.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/24.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

/**
 -100    系统内部错误
 51    接口尚未提供
 53    账号类型错误
 55    参数不足或错误，一般为接口必填参数不足或类型错误
 150    未登录或登录超时/token错误
 153    Token 丢失111
 */
//typedef void(^TokenNull)();
@interface SKHTTPError : NSObject

SKInstanceH(Error)

@property (strong, nonatomic) NSString *server_error;
/**
 全局错误信息
 */
@property (strong, nonatomic, readonly) NSDictionary *errors;

/**
 获取错误信息
 @param code 错误编码
 @return 提示错误
 */
- (NSString *)errorWithCode:(NSString *)code inErrorDictionary:(NSDictionary *)dict;

@end
