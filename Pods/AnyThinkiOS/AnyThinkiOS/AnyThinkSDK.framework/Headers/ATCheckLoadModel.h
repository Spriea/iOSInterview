//
//  ATCheckLoadModel.h
//  AnyThinkSDK
//
//  Created by Topon on 9/29/20.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATCheckLoadModel : NSObject

@property(nonatomic) BOOL isLoading;
@property(nonatomic) BOOL isReady;
@property(nonatomic, readwrite) NSDictionary *adOfferInfo;

@end

NS_ASSUME_NONNULL_END
