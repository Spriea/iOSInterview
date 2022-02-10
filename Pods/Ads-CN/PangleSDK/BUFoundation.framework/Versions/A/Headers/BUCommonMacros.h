//
//  BUCommonMacros.h
//  BUAdSDK
//
//  Created by 崔亚楠 on 2018/10/23.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libkern/OSAtomic.h>
#import <os/lock.h>

FOUNDATION_EXPORT NSString * const BUSDKVersion;

/// 标记是否是开发状态，正式上线发版时置 0
#define DevEnv 0

/** String **/
#define BUEmptyString                                 (@"");
#define BUSafeString(__string)                        ((__string && [__string isKindOfClass:[NSString class]]) ? __string :@"")
#define BUSafeDictionary(__aDictionary)               ((__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]]) ? __aDictionary :@{})

/** VALID CHECKING**/
#define BUCheckValidString(__string)                (__string && [__string isKindOfClass:[NSString class]] && [__string length])
#define BUCheckValidNumber(__aNumber)               (__aNumber && [__aNumber isKindOfClass:[NSNumber class]])
#define BUCheckValidArray(__aArray)                 (__aArray && [__aArray isKindOfClass:[NSArray class]] && [__aArray count])
#define BUCheckValidDictionary(__aDictionary)       (__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]] && [__aDictionary count])
#define BUCheckValidDate(__aDate)                   (__aDate && [__aDate isKindOfClass:[NSDate class]])

/** Color String**/
#define BUColorString(__string)    [UIColor bu_colorWithHexString:(__string)]

/*********************************************************************************************************/
//强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
#ifndef bu_weakify
#if __has_feature(objc_arc)
#define bu_weakify(object) __weak __typeof__(object) weak##object = object;
#else
#define bu_weakify(object) __block __typeof__(object) block##object = object;
#endif
#endif
#ifndef bu_strongify
#if __has_feature(objc_arc)
#define bu_strongify(object) __typeof__(object) object = weak##object;
#else
#define bu_strongify(object) __typeof__(object) object = block##object;
#endif
#endif
/*********************************************************************************************************/

#ifndef BUisEmptyString
#define BUisEmptyString(str) (!str || ![str isKindOfClass:[NSString class]] || str.length == 0)
#endif

#ifndef BUIsEmptyArray
#define BUIsEmptyArray(array) (!array || ![array isKindOfClass:[NSArray class]] || array.count == 0)
#endif

#ifndef BUIsEmptyDictionary
#define BUIsEmptyDictionary(dict) (!dict || ![dict isKindOfClass:[NSDictionary class]] || ((NSDictionary *)dict).count == 0)
#endif


#ifndef BUMinX
#define BUMinX(view) CGRectGetMinX(view.frame)
#endif

#ifndef BUMinY
#define BUMinY(view) CGRectGetMinY(view.frame)
#endif

#ifndef BUMaxX
#define BUMaxX(view) CGRectGetMaxX(view.frame)
#endif

#ifndef BUMaxY
#define BUMaxY(view) CGRectGetMaxY(view.frame)
#endif

#ifndef BUWidth
#define BUWidth(view) view.frame.size.width
#endif

#ifndef BUHeight
#define BUHeight(view) view.frame.size.height
#endif

#ifndef BUScreenWidth
#define BUScreenWidth [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef BUScreenHeight
#define BUScreenHeight [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef BUMINScreenSide
#define BUMINScreenSide                    MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef BUMAXScreenSide
#define BUMAXScreenSide                   MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#define BUIsNotchScreen bu_is_notch_screen()
#define BUiPhoneX BUIsNotchScreen
#define kBUDefaultNavigationBarHeight  (BUiPhoneX?88:64)      // 导航条高度
#define kBUSafeTopMargin (BUiPhoneX?24:0)
#define kBUDefaultStautsBarHeight  (BUiPhoneX?44:20)      // 状态栏高度

#define BUOnePixel (1.0f/[[UIScreen mainScreen] scale])

///全局队列
#ifndef BUDispatchGetGlobalQueue
#define BUDispatchGetGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#endif

#ifndef BUDispatchGetHighQueue
#define BUDispatchGetHighQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#endif

//单例
#define BU_SINGLETION(...)                                          \
+ (instancetype)sharedInstance NS_SWIFT_NAME(shared());

#define BU_DEF_SINGLETION(...)                                      \
+ (instancetype)sharedInstance                                      \
{                                                                   \
static dispatch_once_t once;                                        \
static id __singletion;                                             \
dispatch_once(&once,^{__singletion = [[self alloc] init];});        \
return __singletion;                                                \
}

FOUNDATION_EXPORT void bu_safe_dispatch_sync_main_queue(void (^block)(void));
FOUNDATION_EXPORT void bu_safe_dispatch_async_main_queue(void (^block)(void));

FOUNDATION_EXPORT id BU_JSONObjectByRemovingKeysWithNullValues(id JSONObject);

FOUNDATION_EXPORT BOOL bu_is_notch_screen(void);

FOUNDATION_EXPORT UIEdgeInsets portraitAdSafeInsets(void);

/** LOG **/
#define BU_Log_Foundation(frmt, ...) BU_LOG_MAYBE(BUFoundationLog, BU_LOG_ENABLED, frmt, ##__VA_ARGS__)

#define BU_LOG_MAYBE(BULogTypeString, flg, frmt, ...)                       \
do {                                                      \
if(flg) NSLog(@"【PangleUnion V%@】-【%@】%@", BUSDKVersion, BULogTypeString, [NSString stringWithFormat:frmt,##__VA_ARGS__]);                       \
} while(0)

#if DevEnv

#define BULogTypeNature_Verbose @"🟡".UTF8String
#define BULogTypeNature_Info    @"🟢".UTF8String
#define BULogTypeNature_Error   @"🔴".UTF8String

#define BU_LogVerboseD(BULogType, frmt, ...) BU_LogD(BULogType, BULogTypeNature_Verbose, frmt, ##__VA_ARGS__)
#define BU_LogInfoD(BULogType, frmt, ...) BU_LogD(BULogType, BULogTypeNature_Info, frmt, ##__VA_ARGS__)
#define BU_LogErrorD(BULogType, frmt, ...) BU_LogD(BULogType, BULogTypeNature_Error, frmt, ##__VA_ARGS__)

#define BU_LogD(BULogType, BULogTypeNature, format, ...) printf("\n【%s】%s [%s %d] %s\n\n", BULogType.UTF8String, BULogTypeNature, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String ,__LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__].UTF8String)

#else

#define BU_LogVerboseD(BULogType, frmt, ...)
#define BU_LogInfoD(BULogType, frmt, ...)
#define BU_LogErrorD(BULogType, frmt, ...)

#define BU_LogD(BULogTypeString, nature, ...)

#endif

#pragma mark - 锁

#define BU_USE_OS_UNFAIR_LOCK (__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0)

#ifndef BU_LOCK_DECLARE
#if BU_USE_OS_UNFAIR_LOCK
#define BU_LOCK_DECLARE(lock) os_unfair_lock lock
#else
#define BU_LOCK_DECLARE(lock) os_unfair_lock lock API_AVAILABLE(ios(10.0), tvos(10), watchos(3), macos(10.12)); \
OSSpinLock lock##_deprecated;
#endif
#endif

#ifndef BU_LOCK_INIT
#if BU_USE_OS_UNFAIR_LOCK
#define BU_LOCK_INIT(lock) lock = OS_UNFAIR_LOCK_INIT
#else
#define BU_LOCK_INIT(lock) if (@available(iOS 10, tvOS 10, watchOS 3, macOS 10.12, *)) lock = OS_UNFAIR_LOCK_INIT; \
else lock##_deprecated = OS_SPINLOCK_INIT;
#endif
#endif

#ifndef BU_LOCK
#if BU_USE_OS_UNFAIR_LOCK
#define BU_LOCK(lock) os_unfair_lock_lock(&lock)
#else
#define BU_LOCK(lock) if (@available(iOS 10, tvOS 10, watchOS 3, macOS 10.12, *)) os_unfair_lock_lock(&lock); \
else OSSpinLockLock(&lock##_deprecated);
#endif
#endif

#ifndef BU_UNLOCK
#if BU_USE_OS_UNFAIR_LOCK
#define BU_UNLOCK(lock) os_unfair_lock_unlock(&lock)
#else
#define BU_UNLOCK(lock) if (@available(iOS 10, tvOS 10, watchOS 3, macOS 10.12, *)) os_unfair_lock_unlock(&lock); \
else OSSpinLockUnlock(&lock##_deprecated);
#endif
#endif

@protocol BUDictionarify <NSObject>
@required
- (NSDictionary *)toDictionary;
@end

FOUNDATION_EXPORT NSString * const BUFoundationLog;
FOUNDATION_EXPORT BOOL BU_LOG_ENABLED;

// 对枚举值进行日志字符串转换， 例如对于一个枚举值   1表示激励视频广告的意思， 将返回：   激励视频广告(value:1)
FOUNDATION_EXPORT NSString *NSStringLogFromBUAdEnumItem(NSInteger enumItem, NSDictionary *dic, NSString *defaultValue);
// 对枚举值进行字符串转换   例如对于一个枚举值   1表示rewarded_ad的字符串， 将返回：  rewarded_ad
FOUNDATION_EXPORT NSString *NSStringFromBUAdEnumItem(NSInteger enumItem, NSDictionary *dic, NSString *defaultValue);
