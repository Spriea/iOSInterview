//
//  ATRewardedVideoAdapter.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATRewardedVideoAdapter_h
#define ATRewardedVideoAdapter_h
#import <AnyThinkSDK/AnyThinkSDK.h>
//#import "ATAdAdapter.h"
#import "ATRewardedVideoDelegate.h"
#import "ATRewardedVideo.h"
#import <UIKit/UIKit.h>

@protocol ATRewardedVideoAdapter<ATAdAdapter>
@optional
+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info;
+(void) showRewardedVideo:(ATRewardedVideo*)rewardedVideo inViewController:(UIViewController*)viewController delegate:(id<ATRewardedVideoDelegate>)delegate;
@end
#endif /* ATRewardedVideoAdapter_h */
