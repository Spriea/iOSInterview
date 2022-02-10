//
//  SKFileManager.m
//  EduCare for Parents
//
//  Created by Somer.King on 17/4/15.
//  Copyright © 2017年 Somer. All rights reserved.
//

#import "SKFileManager.h"

@implementation SKFileManager

+ (void)deleteDirectory:(NSString *)directoryPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExists || !isDirectory) { // 不是文件夹 文件不存在
        // 报错
        NSException *excp = [NSException exceptionWithName:@"FileError" reason:@"笨蛋,文件不存在或者不是文件夹,请好好检查" userInfo:nil];
        [excp raise];
    }
//    SKLog(@"沙盒路径：%@", directoryPath);
    // 删除整个缓存文件夹
    NSError *error = nil;
    
    NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
    for (NSString *subPath in subpaths) {
        // 3.拼接完整文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 如果是隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        [mgr removeItemAtPath:filePath error:&error];
//        if (error != nil) {
//                SKLog(@"错误：%@", error);
//        }
        
    }
//    SKLog(@"error%@", error);
    
    // 创建新的缓存文件夹
    [mgr createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

// 指定一个文件夹路径,就能获取到文件夹尺寸
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void (^)(int))completion
{
    // 开启子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.文件管理者对象
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // 判断文件是否存在或者是否是文件夹
        // 是否是文件夹
        BOOL isDirectory;
        
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        
        if (!isExists || !isDirectory) { // 不是文件夹 文件不存在
            // 报错
            @throw  [NSException exceptionWithName:@"FileError" reason:@"笨蛋,文件不存在或者不是文件夹,请好好检查" userInfo:nil];
            
        }
        
        // 2.遍历文件夹里面所有文件
        // subpaths:获取文件夹下所有子文件,多级也可以获取
        NSInteger totalSize = 0;
        NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
        for (NSString *subPath in subpaths) {
            // 3.拼接完整文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 如果是隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 是否是文件夹
            BOOL isDirectory;
            
            [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            if (isDirectory) continue;
            
            // 4.获取文件尺寸
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 5.累加文件尺寸
            totalSize += [attr fileSize];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // 把结果返回出去,通知外界计算完成
            if (completion) {
                completion((int)totalSize);
            }
        });
        
        
    });
   
}

#pragma mark 使用NSSearchPathForDirectoriesInDomains创建文件目录
+ (NSString *)getDocumentCreateDir:(NSString *)dir {
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:dir]; // 在Document目录下创建 "archiver" 文件夹
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return dataFilePath;
}

+ (NSString *)getCacheCreateDir:(NSString *)dir {
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:dir]; // 在Document目录下创建 "archiver" 文件夹
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return dataFilePath;
}

+ (BOOL)isExistsFileAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:path];
    
    return existed;
}

+ (NSArray *)getPathFile:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *mutFile = [NSMutableArray array];
    NSArray *pathsArr = [fileManager subpathsAtPath:path];/*取得文件列表*/
    for (NSString *temp in pathsArr) {
        BOOL isDir = NO;
        // 判断是否一个目录
        NSString *fileP = [path stringByAppendingPathComponent:temp];
        BOOL existed = [fileManager fileExistsAtPath:fileP isDirectory:&isDir];
        if (!(existed && isDir)) {
            [mutFile addObject:temp];
        }
    }
    
    return mutFile;
}

@end
