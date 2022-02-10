//
//  SKFileManager.h
//  EduCare for Parents
//
//  Created by Somer.King on 17/4/15.
//  Copyright © 2017年 Somer. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用于管理文件业务逻辑
 */
@interface SKFileManager : NSObject

/**
 指定一个文件夹路径,就能获取到文件夹尺寸
 @param directoryPath 文件夹路径
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void (^)(int totalSize))completion;

/**
 指定文件夹路径,删除它
 @param directoryPath 文件夹路径
 */
+ (void)deleteDirectory:(NSString *)directoryPath;

/**
 获取到一个创建的文件差路径
 @param dir document中的文件名称
 @return 文件路径
 */
+ (NSString *)getDocumentCreateDir:(NSString *)dir;

/**
 获取到一个创建的文件差路径
 @param dir cache中的文件名称
 @return 文件路径
 */
+ (NSString *)getCacheCreateDir:(NSString *)dir;

/**
 判断该文件是否存在
 @param path 文件路径
 @return 是否存在
 */
+ (BOOL)isExistsFileAtPath:(NSString *)path;

+ (NSArray *)getPathFile:(NSString *)path;

@end
