//
//  SKHTTPTool.h
//  GuYunBike
//
//  Created by Somer.King on 2017/12/14.
//  Copyright © 2017年 HSD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKHTTPError.h"

typedef void(^SuccessBlock)(id returnValue, NSString *errorCode);
typedef void(^ErrorCodeBlock)(id errorCode);

// 定义请求的两种方式
typedef NS_ENUM(NSUInteger, SKRequsetType) {
    SKRequsetTypePOST = 0,
    SKRequsetTypeGET
};

@interface SKHTTPTool : NSObject

+ (AFHTTPSessionManager *)manager;

#pragma mark - 网络请求
/**
 POST网络请求无请求参数、无ErrorBlock
 @param url 网络请求地址
 @param hud 是否有加载动画
 */
+ (void)networkWithURL:(NSString *)url
          successBlock:(SuccessBlock)block
                   HUD:(BOOL)hud;

+ (void)getHtmlWithURL:(NSString *)url
          successBlock:(SuccessBlock)successBlock
            errorBlock:(ErrorCodeBlock)errorBlock
                   HUD:(BOOL)hud;

/**
 POST网络请求无ErrorBlock
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param hud 是否有加载动画
 */
+ (void)networkWithURL:(NSString *)url
             parameter:(NSDictionary *)parameter
          successBlock:(SuccessBlock)successBlock
                   HUD:(BOOL)hud;

/**
 POST网络请求
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param errorBlock 请求失败调用
 @param hud 是否有加载动画
 */
+ (void)networkWithURL:(NSString *)url
             parameter:(NSDictionary *)parameter
          successBlock:(SuccessBlock)successBlock
            errorBlock:(ErrorCodeBlock)errorBlock
                   HUD:(BOOL)hud;

#pragma mark - get请求
/**
 GET网络请求
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param errorBlock 请求失败调用
 @param hud 是否有加载动画
 */
+ (void)networkGetWithURL:(NSString *)url
                parameter:(NSDictionary *)parameter
             successBlock:(SuccessBlock)successBlock
               errorBlock:(ErrorCodeBlock)errorBlock
                      HUD:(BOOL)hud;

/**
 GET网络请求
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param errorBlock 请求失败调用
 @param hud 是否有加载动画
 @param requsetType 请求类型
 */
+ (void)requsetWithURL:(NSString *)url
             parameter:(id)parameter
          successBlock:(SuccessBlock)successBlock
            errorBlock:(ErrorCodeBlock)errorBlock
                   HUD:(BOOL)hud
           requustType:(SKRequsetType)requsetType;


+ (void)upLoadImgWithUrl:(NSString *)url
               parameter:(id)parameter
                   image:(UIImage *)headerImg
            successBlock:(SuccessBlock)successBlock
              errorBlock:(ErrorCodeBlock)errorBlock;

+ (void)upLoadImgWithUrl:(NSString *)url
               parameter:(id)parameter
                   image:(UIImage *)headerImg
                    name:(NSString *)strName
            successBlock:(SuccessBlock)successBlock
              errorBlock:(ErrorCodeBlock)errorBlock
                     HUD:(BOOL)hud;

/**
 判断是否是电话号码
 @param mobileNum 电话号码
 @return YES是电话
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
