//
//  NSString+Category.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/22.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKContactItem;

@interface NSString (Category)

/**
 md5加密
 @param input 密码
 @return 加密后MD5
 */
+ (NSString *)md5WithString:(NSString *)input;

+ (NSString *)sha1:(NSString *)input;

/**
 计算文字的尺寸
 @param font 字体
 @return 文字的size
 */
+ (CGSize)sizeWithText:(NSString *)text font:(CGFloat)font;

- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font;

- (NSMutableAttributedString *)masString:(NSString *)string lineSpace:(CGFloat)lineSpace withColor:(UIColor *)color withFont:(UIFont *)font;
/**
 计算可变文字定宽的尺寸
 @param text 可变文字
 @param font 字体大小
 @param width 文字狂赌
 @return 文字长宽
 */
+ (CGSize)sizeWithText:(NSAttributedString *)text font:(CGFloat)font width:(CGFloat)width;
+ (CGSize)sizeWithAttText:(NSAttributedString *)text font:(UIFont *)font width:(CGFloat)width;

/**
 拼接请求地址
 @return 请求地址全路径
 */
- (NSString *)joinBaseUrl;

/**
 获取缓存字符串
 @return 内存大小
 */
+ (NSString *)cacheStr:(NSInteger)totalSize;

/**
  设置行间距和字间距
@param lineSpace 行间距
@param kern      字间距
@return 富文本
 */
- (NSAttributedString*)getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern;

/**
 获得时间段
 @param duration 持续时间分钟
 @return HH:mm-HH:mm
 */
- (NSString *)stringWithDurataion:(NSString *)duration;

// 解决朋友圈时间问题
- (NSString *)fr_resolveTime;

- (NSString *)info_resolveTime;

// 解决聊天时间问题
- (NSString *)resolveTime;


/**
 获取唯一存储标识
 @param name 存储的名称，唯一
 @return 存储的地址
 */
+ (NSString *)saveStringWithOnly:(NSString *)name;
+ (NSString *)saveStringWithOnly:(NSString *)name token:(NSString *)token;
+ (NSString *)saveUserPathWithName:(NSString *)name;


/**
 文字阴影
 @param string 需要阴影的文字
 */
+ (NSAttributedString *)shadowString:(NSString *)string;

/**
 可变字符串
 @param string 字符串
 @param font 字体
 @param fontColor 颜色
 @return 带有属性的字符串
 */
+ (NSMutableAttributedString *)getAttWithString:(NSString *)string font:(UIFont *)font fontColor:(UIColor *)fontColor;


/**
 url编码无特殊符号
 @return 字符串
 */
- (NSString *)urlEncode;

/**
 url解码
 @return 有特殊服务，base64编码
 */
- (NSString *)urlDecode;

/**
 判断字符串是否为空
 @param str 字符串
 @return 结果
 */
+ (BOOL)isEmpty:(NSString *)str;

/**
 获取 xx的老师
 @param contactItem 联系人模型
 @return 想要的字段
 */
//+ (NSString *)getPositionString:(SKContactItem *)contactItem withType:(NSString *)type;

- (NSString *)sk_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;


/**
 创建颜色字体
 @param string 其中改版的颜色字
 @param color 颜色字体
 @return 可变字符串
 */
- (NSMutableAttributedString *)masString:(NSString *)string withColor:(UIColor *)color withFont:(UIFont *)font;


/**
 拼接字符数据
 */
//- (NSString *)sk_appendGetString;


/** 两个句子最大公约数*/
+ (NSString *)longestCommonSubstring:(NSArray *)substring string:(NSArray *)string;
- (NSArray *) lcsDiff:(NSString *)string;
@end
