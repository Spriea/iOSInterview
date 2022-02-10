//
//  SKJsonManager.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKJsonManager.h"

static SKJsonManager *instance;
@implementation SKJsonManager

+ (instancetype)jsonManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SKJsonManager alloc] init];
    });
    return instance;
}

+ (void)loadDataJson:(NSString *)json
        successBlock:(SuccessBlock)successBlock
          errorBlock:(ErrorCodeBlock)errorBlock
                 HUD:(BOOL)hud{
    if (hud) {
        [SVProgressHUD show];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:json ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:plistPath];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if (error == nil) {
                if (successBlock) {
                    successBlock(dict,@"200");
                }
            }else{
                if (errorBlock) {
                    errorBlock(0);
                }else{
                    [SVProgressHUD showErrorWithStatus:@"未找到相关数据"];
                }
            }
        });
    });
}

@end
