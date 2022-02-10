//
//  BUCacheManager.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/9/19.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *BUCacheConfigurationKey;
extern NSString *BUCacheFinishedErrorKey;

@class BUCacheConfiguration;
@interface BUCacheManager : NSObject

+ (void)setCacheDirectory:(NSString *)cacheDirectory;
+ (NSString *)cacheDirectory;


/**
 How often trigger `BUCacheManagerDidUpdateCacheNotification` notification
 
 @param interval Minimum interval
 */
+ (void)setCacheUpdateNotifyInterval:(NSTimeInterval)interval;
+ (NSTimeInterval)cacheUpdateNotifyInterval;

+ (NSString *)cachedFilePathForURL:(NSURL *)url;
+ (BUCacheConfiguration *)cacheConfigurationForURL:(NSURL *)url;

+ (void)setFileNameRules:(NSString *(^)(NSURL *rulesUrl))rules;


/**
 Calculate cached files size
 
 @param error If error not empty, calculate failed
 @return files size, respresent by `byte`, if error occurs, return -1
 */
+ (unsigned long long)calculateCachedSizeWithError:(NSError **)error;
+ (BOOL)cleanAllCacheWithError:(NSError **)error;
+ (BOOL)cleanCacheForURL:(NSURL *)url error:(NSError **)error;


/**
 Useful when you upload a local file to the server
 
 @param filePath local file path
 @param url remote resource url
 @param error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information.
 */
+ (BOOL)addCacheFile:(NSString *)filePath forURL:(NSURL *)url error:(NSError **)error;
@end
