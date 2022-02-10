//
//  NSString+Category.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/22.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDate+Formatter.h"
#import "SKTokenStatic.h"

@implementation NSString (Category)
// MD5加密方法
+ (NSString *)md5WithString:(NSString *)input {
    //要进行UTF8的转码
    const char* inputStr = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(inputStr, (CC_LONG)strlen(inputStr), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

- (NSMutableAttributedString *)masString:(NSString *)string lineSpace:(CGFloat)lineSpace withColor:(UIColor *)color withFont:(UIFont *)font{
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange rangel = [[textColor string] rangeOfString:string];
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:rangel];
    [textColor addAttribute:NSFontAttributeName value:font range:rangel];
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    [textColor addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[[textColor string] rangeOfString:self]];
    
    return textColor;
}

//sha1加密方式
+ (NSString *)sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (CGSize)sizeWithText:(NSString *)text font:(CGFloat)font {
    CGSize size = [text sizeWithAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    return size;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

+ (CGSize)sizeWithText:(NSAttributedString *)text font:(CGFloat)font width:(CGFloat)width{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font];
    label.frame = CGRectMake(0, 0, width, MAXFLOAT);
    label.attributedText = text;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    CGFloat oneLineH = [NSString sizeWithText:@"Edu" font:font].height;
    CGFloat contH = CGRectGetHeight(label.frame);
    if (contH <= 2 * oneLineH) {
        contH = oneLineH;
    }
    CGSize size = CGSizeMake(CGRectGetWidth(label.frame), contH);
    
    return size;
}

+ (CGSize)sizeWithAttText:(NSAttributedString *)text font:(UIFont *)font width:(CGFloat)width{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, width, MAXFLOAT);
    label.attributedText = text;
    label.font = font;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    CGFloat oneLineH = [@"我的" sizeWithAttributes: @{NSFontAttributeName:font}].height;
    CGFloat contH = CGRectGetHeight(label.frame);
    if (contH <= 2 * oneLineH) {
        contH = oneLineH;
    }
    CGSize size = CGSizeMake(CGRectGetWidth(label.frame), contH);
    
    return size;
}


- (NSString *)joinBaseUrl{
    return [NSString stringWithFormat:@"%@%@",Base_Url, self];
}

// 获取缓存字符串
+ (NSString *)cacheStr:(NSInteger)totalSize
{
    NSString *cacheStr = @"";
    
    CGFloat totalSizeF = 0;
    if (totalSize > 1000 * 1000) { // 是否大于1MB
        totalSizeF = totalSize / 1000.0 / 1000.0;
        cacheStr = [NSString stringWithFormat:@"%.1fMB",totalSizeF];
    } else if (totalSize > 1000) { // 是否大于1KB
        totalSizeF = totalSize / 1000.0 ;
        cacheStr = [NSString stringWithFormat:@"%.1fKB",totalSizeF];
    } else if (totalSize > 0) { // 是否大于0B
        cacheStr = [NSString stringWithFormat:@"%ldB",totalSize];
    } else{
        cacheStr = @"0dB";
    }
    
    cacheStr = [cacheStr sk_stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    return cacheStr;
}


- (NSAttributedString*)getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
NSDictionary*attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:attriDict];
    return attributedString;
}

- (NSString *)stringWithDurataion:(NSString *)duration{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm:ss";
    NSDate *b = [fmt dateFromString:self];
    NSDate *d = [b dateByAddingTimeInterval:[duration integerValue] * 60];
    fmt.dateFormat = @"HH:mm";
    NSString *title = [NSString stringWithFormat:@"%@-%@", [fmt stringFromDate:b], [fmt stringFromDate:d]];
    return title;
}

/*
 今年
 今天:
 >= 1小时 1小时之前
 >= 1分钟 2分钟之前
 <  1分钟 刚刚
 昨天:   昨天 01:01
 昨天之前: 09-15 01:01:01
 非今年:2015-01-01 01:01:01
 */
- (NSString *)fr_resolveTime{
    // 2015-08-24 19:12:20
    NSString *create_time = self;
    
    // 日期字符串转NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:create_time];
    
    // 处理日期 NSData
    // 处理日历 NSCalendar:获取两个日期差值(发帖日期与当前日期差值)
    NSDateComponents *cmp = [createDate detalWithNow];
    if ([createDate isThisYear]) {
        if ([createDate isThisToday]) { // 今天
            if (cmp.hour >= 1) {
                create_time = [@"#小时前" sk_stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%ld", cmp.hour]];
            } else if (cmp.minute > 1) {
                create_time = [@"#分钟前" sk_stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%ld", cmp.minute]];
            } else { // 刚刚
                create_time = @"刚刚";
            }
        } else if ([createDate isThisYesterday]) { // 昨天
            fmt.dateFormat = @"HH:mm";
            create_time = [fmt stringFromDate:createDate];
            create_time = [NSString stringWithFormat:@"昨天 %@", create_time];
        } else { // 昨天之前
            fmt.dateFormat = @"MM-dd HH:mm";
            create_time = [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        create_time = [fmt stringFromDate:createDate];
    }
    return create_time;
}

- (NSString *)resolveTime{
    // 2015-08-24 19:12:20
    NSString *create_time = self;
    
    // 日期字符串转NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:create_time];
    
    // 处理日期 NSData
    // 处理日历 NSCalendar:获取两个日期差值(发帖日期与当前日期差值)
    NSDateComponents *cmp = [createDate detalWithNow];
    if ([createDate isThisYear]) {
        if ([createDate isThisToday]) { // 今天
            if (cmp.minute > 1) {
                fmt.dateFormat = @"HH:mm";
                create_time = [fmt stringFromDate:createDate];
            } else { // 刚刚
                create_time = @"刚刚";
            }
        } else if ([createDate isThisYesterday]) { // 昨天
            fmt.dateFormat = @"HH:mm";
            create_time = [fmt stringFromDate:createDate];
            create_time = [NSString stringWithFormat:@"%@ %@", @"昨天", create_time];
        } else { // 昨天之前
            fmt.dateFormat = @"MM-dd HH:mm";
            create_time = [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        create_time = [fmt stringFromDate:createDate];
    }
    return create_time;
}

- (NSString *)info_resolveTime{
    // 2015-08-24 19:12:20
    NSString *create_time = self;
    
    // 日期字符串转NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:create_time];
    
    // 处理日期 NSData
    // 处理日历 NSCalendar:获取两个日期差值(发帖日期与当前日期差值)
    NSDateComponents *cmp = [createDate detalWithNow];
    if ([createDate isThisYear]) {
        if ([createDate isThisToday]) { // 今天
            if (cmp.minute > 1) {
                fmt.dateFormat = @"HH:mm";
                create_time = [fmt stringFromDate:createDate];
            } else { // 刚刚
                create_time = @"刚刚";
            }
        } else { // 昨天之前
            fmt.dateFormat = @"MM-dd";
            create_time = [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy";
        create_time = [fmt stringFromDate:createDate];
    }
    return create_time;
}

+ (NSString *)saveStringWithOnly:(NSString *)name{
    return [NSString saveStringWithOnly:name token:[SKTokenStatic getToken]];
}

+ (NSString *)saveStringWithOnly:(NSString *)name token:(NSString *)token{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.data",token,name]];
}

+ (NSString *)saveUserPathWithName:(NSString *)name{
    return [NSString stringWithFormat:@"%@%@",[SKTokenStatic getToken], name];
}

+ (NSAttributedString *)shadowString:(NSString *)string{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithHexString:@"000000" alpha:0.5];//阴影颜色
    
    if (kIS_IPHONE) {
        shadow.shadowBlurRadius = kSCALE_X(2);//阴影半径，默认值3
        shadow.shadowOffset = CGSizeMake(0, kSCALE_X(1));//阴影偏移量，x向右偏移，y向下偏移，默认是（0，-3）
    }else{
        shadow.shadowBlurRadius = kSCALE_X(4);//阴影半径，默认值3
        shadow.shadowOffset = CGSizeMake(0, kSCALE_X(2));//阴影偏移量，x向右偏移，y向下偏移，默认是（0，-3）
    }
    
    
    
    NSAttributedString * atributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSShadowAttributeName:shadow}];
    
    return atributedText;
}

+ (NSMutableAttributedString *)getAttWithString:(NSString *)string font:(UIFont *)font fontColor:(UIColor *)fontColor{
    if (string == nil) {
        return [[NSMutableAttributedString alloc] init];
    }
    NSMutableAttributedString *placeholderAtt = [[NSMutableAttributedString alloc] initWithString:string];
    [placeholderAtt addAttribute:NSForegroundColorAttributeName
                           value:fontColor
                           range:NSMakeRange(0, string.length)];
    [placeholderAtt addAttribute:NSFontAttributeName
                           value:font
                           range:NSMakeRange(0, string.length)];
    return placeholderAtt;
}

- (NSString *)urlEncode{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *sec = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return sec;
}

- (NSString *)urlDecode{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//判断是否全是空格
+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

- (NSString *)sk_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement{
    if (replacement == nil) {
        replacement = @"";
    }
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSMutableAttributedString *)masString:(NSString *)string withColor:(UIColor *)color withFont:(UIFont *)font{
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange rangel = [[textColor string] rangeOfString:string];
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:rangel];
    [textColor addAttribute:NSFontAttributeName value:font range:rangel];
    return textColor;
}

//- (NSString *)sk_appendGetString{
//    
//    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//    NSInteger timeInt = time;
//    NSInteger rankNum = [SKCustomFunction getRandomNumber:10000 to:20000];
//    
//    NSInteger a = timeInt/10000;
//    
//    NSInteger timeLast = timeInt - a*10000;
//    
//    NSString *secret = [NSString stringWithFormat:@"%04zd%@",timeLast, kAPPSecret];
//    
//    secret = [NSString md5WithString:secret];
//    secret = [NSString stringWithFormat:@"%@%zd",secret, rankNum];
//    
//    NSString *signal = [NSString sha1:secret];
//    
//    return [self stringByAppendingString:[NSString stringWithFormat:@"timestamp=%ld&randnum=%ld&signal=%@", timeInt,rankNum,[signal uppercaseString]]];
//}


#pragma mark - 句子对比
+ (NSString *)longestCommonSubstring:(NSString *)substring string:(NSString *)string {
    if (substring == nil || substring.length == 0 || string == nil || string.length == 0) {
        return nil;
    }
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    int maxlen = 0;
    int lastSubsBegin = 0;
    NSMutableString *sequenceBuilder = [NSMutableString string];
    
    for (int i = 0; i < substring.length; i++)
    {
        for (int j = 0; j < string.length; j++)
        {
            unichar substringC = [[substring lowercaseString] characterAtIndex:i];
            unichar stringC = [[string lowercaseString] characterAtIndex:j];
            
            if (substringC != stringC) {
                [map setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"%i%i",i,j]];
            }
            else {
                if ((i == 0) || (j == 0)) {
                    [map setObject:[NSNumber numberWithInt:1] forKey:[NSString stringWithFormat:@"%i%i",i,j]];
                }
                else {
                    int prevVal = [[map objectForKey:[NSString stringWithFormat:@"%i%i",i-1,j-1]] intValue];
                    [map setObject:[NSNumber numberWithInt:1+prevVal] forKey:[NSString stringWithFormat:@"%i%i",i,j]];
                }
                int currVal = [[map objectForKey:[NSString stringWithFormat:@"%i%i",i,j]] intValue];
                if (currVal > maxlen) {
                    maxlen = currVal;
                    int thisSubsBegin = i - currVal + 1;
                    if (lastSubsBegin == thisSubsBegin)
                    {//if the current LCS is the same as the last time this block ran
                        NSString *append = [NSString stringWithFormat:@"%C",substringC];
                        [sequenceBuilder appendString:append];
                    }
                    else //this block resets the string builder if a different LCS is found
                    {
                        lastSubsBegin = thisSubsBegin;
                        NSString *resetStr = [substring substringWithRange:NSMakeRange(lastSubsBegin, (i + 1) - lastSubsBegin)];
                        sequenceBuilder = [NSMutableString stringWithFormat:@"%@",resetStr];
                    }
                }
            }
        }
    }
    return [sequenceBuilder copy];
}

- (NSArray *) lcsDiff:(NSString *)string{
//    [self stringByReplacingOccurrencesOfString:@"," withString:@" "];
//    [self stringByReplacingOccurrencesOfString:@"." withString:@" "];
//    [self stringByReplacingOccurrencesOfString:@"?" withString:@" "];
//    NSArray *oneArr = [self componentsSeparatedByString:@" "];
//    
//    [sstringelf stringByReplacingOccurrencesOfString:@"," withString:@" "];
//    [self stringByReplacingOccurrencesOfString:@"." withString:@" "];
//    [self stringByReplacingOccurrencesOfString:@"?" withString:@" "];
//    NSArray *oneArr = [self componentsSeparatedByString:@" "];
    
    NSString *lcs = [NSString longestCommonSubstring:self string:string];
    NSUInteger l1 = [self length];
    NSUInteger l2 = [string length];
    NSUInteger lc = [lcs length];
    NSUInteger idx1 = 0;
    NSUInteger idx2 = 0;
    NSUInteger idxc = 0;
    NSMutableString *s1 = [[NSMutableString alloc]initWithCapacity:l1];
    NSMutableString *s2 = [[NSMutableString alloc]initWithCapacity:l2];
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:10];
    for (;;) {
        if (idxc >= lc) break;
        unichar c1 = [self characterAtIndex:idx1];
        unichar c2 = [string characterAtIndex:idx2];
        unichar cc = [lcs characterAtIndex:idxc];
        if ((c1==cc) && (c2 == cc)) {
            if ([s1 length] || [s2 length]) {
                NSArray *e = @[ s1, s2];
                [res addObject:e];
                s1 = [[NSMutableString alloc]initWithCapacity:l1];
                s2 = [[NSMutableString alloc]initWithCapacity:l1];
            }
            idx1++; idx2++; idxc++;
            continue;
        }
        if (c1 != cc) {
            [s1 appendString:[NSString stringWithCharacters:&c1 length:1]];
            idx1++;
        }
        if (c2 != cc) {
            [s2 appendString:[NSString stringWithCharacters:&c2 length:1]];
            idx2++;
        }
    }
    if (idx1<l1) {
        [s1 appendString:[self substringFromIndex:idx1]];
    }
    if (idx2<l2) {
        [s2 appendString:[string substringFromIndex:idx2]];
    }
    if ([s1 length] || [s2 length]) {
        NSArray *e = @[ s1, s2];
        [res addObject:e];
    }
    return res;
}

@end
