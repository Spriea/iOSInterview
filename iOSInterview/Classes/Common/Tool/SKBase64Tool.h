//
//  SKBase64Tool.h
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

 
/**
 * Base64工具类
 */
@interface SKBase64Tool : NSObject
 
/**
 * Base64编码
 */
+ (NSString *)base64Encode:(NSString *)data;
 
/**
 * Base64解码
 */
+ (NSString *)base64Dencode:(NSString *)data;
 
@end



NS_ASSUME_NONNULL_END
