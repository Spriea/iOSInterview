//
//  SKHTTPTool.m
//  GuYunBike
//
//  Created by Somer.King on 2017/12/14.
//  Copyright © 2017年 HSD. All rights reserved.
//

#import "SKHTTPTool.h"
#import "SKTokenStatic.h"
#import "SKUserListModal.h"

typedef void (^SuccessB)(NSURLSessionDataTask * _Nonnull, id _Nullable);
typedef void (^ErrorB)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);

@interface SKHTTPTool()

@end

static AFHTTPSessionManager *_manager = nil;
@implementation SKHTTPTool
+ (void)load{
    [SKHTTPTool manager];
}

+ (AFHTTPSessionManager *)manager {  // 普通请求
    if (_manager != nil) {
        return _manager;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html",@"text/json", nil];
    
    // 设置请求头部信息
    [manager.requestSerializer setValue:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] forHTTPHeaderField:@"appVer"]; // 版本号
    [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"devType"]; // 设备
//    [manager.requestSerializer setValue:[SKCustomFunction iPhoneType] forHTTPHeaderField:@"devModel"];  // 设备型号
    [manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"devSys"];   // 系统型号
    [manager.requestSerializer setValue:[[UIDevice currentDevice].identifierForVendor UUIDString] forHTTPHeaderField:@"devId"];
//    [manager.requestSerializer setValue:kLanguageCurrent forHTTPHeaderField:@"devLang"];
    
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    _manager = manager;
    return _manager;
}

#pragma mark - post
// 网络post 请求。加载加载状态。
+ (void)networkWithURL:(NSString *)url successBlock:(SuccessBlock)block HUD:(BOOL)hud{
    [self networkWithURL:url parameter:nil successBlock:block HUD:hud];
}
+ (void)networkWithURL:(NSString *)url parameter:(id)parameter successBlock:(SuccessBlock)successBlock HUD:(BOOL)hud{
    [self networkWithURL:url parameter:parameter successBlock:successBlock errorBlock:nil HUD:hud];
}
+ (void)networkWithURL:(NSString *)url
             parameter:(id)parameter
          successBlock:(SuccessBlock)successBlock
            errorBlock:(ErrorCodeBlock)errorBlock
                   HUD:(BOOL)hud{
    [self requsetWithURL:url parameter:parameter successBlock:successBlock errorBlock:errorBlock HUD:hud requustType:SKRequsetTypePOST];
}
// get请求
+ (void)networkGetWithURL:(NSString *)url
                parameter:(NSDictionary *)parameter
             successBlock:(SuccessBlock)successBlock
               errorBlock:(ErrorCodeBlock)errorBlock
                      HUD:(BOOL)hud{
    [self requsetWithURL:url parameter:parameter successBlock:successBlock errorBlock:errorBlock HUD:hud requustType:SKRequsetTypeGET];
}

+ (void)getHtmlWithURL:(NSString *)url
          successBlock:(SuccessBlock)successBlock
            errorBlock:(ErrorCodeBlock)errorBlock
                   HUD:(BOOL)hud{
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString =  [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *dataVerson = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        NSString *str = [dataVerson mj_JSONString];
        
        NSArray *arr = [str componentsSeparatedByString:@"<title>"];
        str = arr[1];
        str = [[str componentsSeparatedByString:@" · 语雀</title>"] firstObject];
        str = [[str componentsSeparatedByString:@" · Yuque</title>"] firstObject];
    //    str = [[str componentsSeparatedByString:@"\">"] firstObject];
        str = [str stringByReplacingOccurrencesOfString:@"%" withString:@"\""];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        
        NSDictionary *dataStr;
        if (jsonData != nil) {
            dataStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if (err == nil) {
                successBlock(dataStr,nil);
            }else{
                errorBlock(err);
            }
        });
    });
}
// 网络请求
+ (void)requsetWithURL:(NSString *)url
             parameter:(id)parameter
          successBlock:(SuccessBlock)successBlock
            errorBlock:(ErrorCodeBlock)errorBlock
                   HUD:(BOOL)hud
           requustType:(SKRequsetType)requsetType{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"无法连接到互联网，请检查网络"];
        if (errorBlock) {
            NSError *err = [NSError errorWithDomain:@"not_get_network" code:-111 userInfo:nil];
            errorBlock(err);
        }
        return;
    }
    
    if (hud) {
        [SVProgressHUD showLoadingImage:[UIImage imageWithGIFNamed:@"loading"]];
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD setImageViewSize:CGSizeMake(kSCALE_X(100), kSCALE_X(100))];
    }
    NSMutableDictionary *parmarMut = [NSMutableDictionary dictionary];
    [parmarMut addEntriesFromDictionary:parameter];
//    if (!([url containsString:u_noticeRank] && [SKUserItem getUser] == nil)) {
//        [parmarMut setValue:[SKTokenStatic getToken] forKey:@"app_personal_label"];
//    }
    
    
    NSString *URLString = @"";
    if ([url containsString:@"http://"] ||  [url containsString:@"https://"]) {
        URLString = url;
    }else{
        URLString = [Base_Url stringByAppendingString:url];
    }
    SKLog(@"%@ %@", URLString, parmarMut);
    // 请求成功回调Block
    SuccessB successB = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#ifdef DEBUG   // 调试
        NSData *d = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        SKLog(@"responseObject-----%@", [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding]);
#endif
       
        if (hud) {
            [SVProgressHUD dismiss];
            [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
            [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
        }
        
        NSDictionary *dict = responseObject;
        NSString *reqFlag = [NSString stringWithFormat:@"%@", dict[@"code"]];
        if ([@"0" isEqualToString:reqFlag]) {
            successBlock(dict, nil);
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
            [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
            
            if ([URLString containsString:u_version] || [URLString containsString:u_noticeRank]) {
                return ;
            }
//            [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
//            SKLog(@"错误URL:%@  %@", URLString, parmarMut);
//            if ([@"5000" isEqualToString:reqFlag] || [@"4003" isEqualToString:reqFlag] || [@"4000" isEqualToString:reqFlag] || [@"4002" isEqualToString:reqFlag] || [@"2001" isEqualToString:reqFlag] || [@"2002" isEqualToString:reqFlag] || [@"2003" isEqualToString:reqFlag] || [@"4005" isEqualToString:reqFlag]) {
//                if ([url containsString:@"homework/getdictationhomework"]) {
//
//                }else{
//                    [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
//                }
//            }else
//
//            if ([@"4001" isEqualToString:reqFlag]) {
//                [SKCustomFunction alertSheetWithTitle:nil message:@"身份验证失效，请重新登录" confTitle:nil confirmHandler:^(UIAlertAction *action) {
//                    [SKUserListModal removeTokenValue:[SKTokenStatic getToken]];
//                    [SKTokenStatic saveToken:nil];
//                    [SKCustomFunction jumpToLogin];
//                } cancleHandler:^(UIAlertAction *action) {
//
//                }];
//            }else if([@"4006" isEqualToString:reqFlag]){
//                [SKCustomFunction alertSheetWithTitle:nil message:[NSString stringWithFormat:@"%@，需要重新登录",dict[@"msg"]] confTitle:nil confirmHandler:^(UIAlertAction *action) {
//                    [SKUserListModal removeTokenValue:[SKTokenStatic getToken]];
//                    [SKTokenStatic saveToken:nil];
//                    [SKCustomFunction jumpToLogin];
//                } cancleHandler:nil];
//            }else{
//                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
//            }
            successBlock(dict, reqFlag);
        }
    };
    
    // 请求失败回调Block
    ErrorB errorB = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
        [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
        if (hud) {
            [SVProgressHUD dismiss];
        }
        if (errorBlock && error) {
            errorBlock(error);
        }
        SKLog(@"error: %@" ,error);
        
        SKLog(@"错误URL:%@  %@", URLString, parmarMut);
        if (error) {
            NSError *derlyingErro = error.userInfo[@"NSUnderlyingError"];
            NSData *data = derlyingErro.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            SKLog(@"%@" ,result);
            
//            [SVProgressHUD showErrorWithStatus:@"服务器异常，请稍后再试！"];
        }
    };
    
    // 判读是什么网络请求
    if (requsetType == SKRequsetTypePOST) { // POST请求
        [[self manager] POST:URLString parameters:parmarMut headers:nil progress:nil success:successB failure:errorB];
    }else {
        [[self manager] GET:URLString parameters:parmarMut headers:nil progress:nil success:successB failure:errorB];
    }

}

+ (void)upLoadImgWithUrl:(NSString *)url
               parameter:(id)parameter
                   image:(UIImage *)headerImg
            successBlock:(SuccessBlock)successBlock
              errorBlock:(ErrorCodeBlock)errorBlock{
    [self upLoadImgWithUrl:url parameter:parameter image:headerImg name:@"usr_icon" successBlock:successBlock errorBlock:errorBlock HUD:YES];
}

+ (void)upLoadImgWithUrl:(NSString *)url
               parameter:(id)parameter
                   image:(UIImage *)headerImg
                    name:(NSString *)strName
            successBlock:(SuccessBlock)successBlock
              errorBlock:(ErrorCodeBlock)errorBlock
                     HUD:(BOOL)hud{
    if (hud) {
        [SVProgressHUD showLoadingImage:[UIImage imageWithGIFNamed:@"loading"]];
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD setImageViewSize:CGSizeMake(kSCALE_X(100), kSCALE_X(100))];
    }
    
    NSMutableDictionary *parmarMut = [NSMutableDictionary dictionary];
    [parmarMut addEntriesFromDictionary:parameter];
    [parmarMut setValue:[SKTokenStatic getToken] forKey:@"app_personal_label"];
    
    NSString *URLString = [Base_Url stringByAppendingString:url];
    
    SKLog(@"%@ %@", URLString, parmarMut);
    
//    [[self manager] POST:URLString parameters:parmarMut constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        if (headerImg == nil) {
//            return ;
//        }
//        if ([headerImg isKindOfClass:[UIImage class]]) {
//            NSData *imageData = UIImageJPEGRepresentation(headerImg, 1);
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *timeStr = [formatter stringFromDate:[NSDate date]];
//            NSString *imageName = [NSString stringWithFormat:@"%@.jpg", timeStr];
//            
//            [formData appendPartWithFileData:imageData name:strName fileName:imageName mimeType:@"image/jpeg"];
//        }else{
//            NSString *mimeType = [SKHTTPTool mimeTypeForFileAtPath:(NSString *)headerImg];
//            if (mimeType == nil) {
////                [SKCustomFunction alertSheetWithTitle:nil message:kLanguage(@"msg_chat_file_down_nofind") handler:^(UIAlertAction *action) {}];
//                return ;
//            }
//            [formData appendPartWithFileURL:[NSURL fileURLWithPath:(NSString *)headerImg] name:strName fileName:[(NSString *)headerImg lastPathComponent] mimeType:mimeType error:nil];
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//#ifdef DEBUG   // 调试
//        NSData *d = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        SKLog(@"responseObject-----%@", [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding]);
//#endif
//        
//        if (hud) {
//            [SVProgressHUD dismiss];
//            [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
//            [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
//        }
//        //        NSData *data = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSDictionary *dict = responseObject;
//        NSString *reqFlag = [NSString stringWithFormat:@"%@", dict[@"code"]];
//        if ([@"2000" isEqualToString:reqFlag]) {
//            successBlock(dict, nil);
//        }else{
//            if (hud) {
//                [SVProgressHUD dismiss];
//                [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
//                [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
//            }
//            if ([URLString containsString:u_version]) {
//                return ;
//            }
////            SKLog(@"错误URL:%@  %@", URLString, parmarMut);
////            if ([@"5000" isEqualToString:reqFlag] || [@"4003" isEqualToString:reqFlag] || [@"4000" isEqualToString:reqFlag] || [@"4002" isEqualToString:reqFlag]) {
////                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
////            }
//            
//            
//            if ([@"4001" isEqualToString:reqFlag]) {
//                [SKCustomFunction alertSheetWithTitle:nil message:@"身份验证失效，请重新登录" confTitle:nil confirmHandler:^(UIAlertAction *action) {
//                    [SKUserListModal removeTokenValue:[SKTokenStatic getToken]];
//                    [SKTokenStatic saveToken:nil];
//                    [SKCustomFunction jumpToLogin];
//                } cancleHandler:^(UIAlertAction *action) {
//                    
//                }];
//            }else{
//                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
//            }
//            successBlock(dict, reqFlag);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (errorBlock && error) {
//            errorBlock(error);
//        }
//        [SVProgressHUD dismiss];
//        [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
//        [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
//    }];
}

//通过图片Data数据第一个字节 来获取图片扩展名
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

//+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
//{
//    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
//        return nil;
//    }
//
//    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
//    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
//    CFRelease(UTI);
//    if (!MIMEType) {
//        return @"application/octet-stream";
//    }
//    return (__bridge NSString *)(MIMEType);
//}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
