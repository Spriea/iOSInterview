//
//  SKJsonManager.h
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKHTTPTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface SKJsonManager : NSObject

+ (instancetype)jsonManager;

+ (void)loadDataJson:(NSString *)json
        successBlock:(SuccessBlock)successBlock
          errorBlock:(ErrorCodeBlock)errorBlock
                 HUD:(BOOL)hud;

@end

NS_ASSUME_NONNULL_END
