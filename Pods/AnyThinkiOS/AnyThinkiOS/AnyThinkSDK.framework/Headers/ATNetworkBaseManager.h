//
//  ATNetworkBaseManager.h
//  AnyThinkSDK
//
//  Created by Topon on 11/11/20.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAPI+Internal.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATNetworkBaseManager : NSObject
+(void) initWithCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo;
@end

NS_ASSUME_NONNULL_END
