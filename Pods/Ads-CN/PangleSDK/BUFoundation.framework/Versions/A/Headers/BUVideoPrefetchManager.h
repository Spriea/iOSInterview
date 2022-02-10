//
//  BUVideoPrefetchManager.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUPlayerSettingsProtocol.h"

@interface BUVideoPrefetchManager : NSObject<BUPlayerSettingsProtocol>

+ (instancetype)sharedInstance;

- (void)prefetchWithVideoUrl:(NSURL *)videoUrl
                  storgeName:(NSString *)storgeName
               largeFragment:(BOOL)largeFragment
          prefetchStartBlock:(void(^)(void))prefetchStartBlock
          prefetchFinshBlock:(void(^)(NSError *))prefetchFinshBlock;

@end
