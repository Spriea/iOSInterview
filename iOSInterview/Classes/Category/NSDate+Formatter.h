//
//  NSDate+Formatter.h
//  SystemXinDai
//
//  Created by LvJianfeng on 16/3/26.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

- (BOOL)isThisYear;
- (BOOL)isThisMom;
- (BOOL)isThisToday;
- (BOOL)isThisYesterday;
- (NSDateComponents *)detalWithNow;

+(NSDate *)yesterday;

+(NSDateFormatter *)formatter;
+(NSDateFormatter *)formatterWithoutTime;
+(NSDateFormatter *)formatterWithoutDate;

-(NSString *)formatWithUTCTimeZone;
-(NSString *)formatWithLocalTimeZone;
-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCTimeZoneWithoutTime;
-(NSString *)formatWithLocalTimeZoneWithoutTime;
-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCWithoutDate;
-(NSString *)formatWithLocalTimeWithoutDate;
-(NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;

+ (NSString *)currentDateString;
+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)dateWithFormat:(NSString *)format;

// 其他
- (NSString *)mmddByLineWithDate;
- (NSString *)yyyyByLineWithDate;
- (NSString *)yyyyCountByLineWithDate;
- (NSString *)yyyyMMByLineWithDate;
+ (NSString *)sk_dataYMDwithTime:(NSTimeInterval)time;
- (NSString *)mmddChineseWithDate;
- (NSString *)hhmmssWithDate;
- (NSString *)MMWithDate;
- (NSString *)ddWithDate;
- (NSString *)HHWithDate;
- (NSString *)morningOrAfterWithHH;
@end
