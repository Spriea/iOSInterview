//
//  ATInterstitialAdapter.h
//  AnyThinkInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATInterstitialAdapter_h
#define ATInterstitialAdapter_h
#import <AnyThinkSDK/AnyThinkSDK.h>
#import "ATInterstitialDelegate.h"
#import "ATInterstitial.h"
#import <UIKit/UIKit.h>

@protocol ATInterstitialAdapter<ATAdAdapter>
@optional
+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info;
+(void) showInterstitial:(ATInterstitial*)interstitial inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate;
@end

#endif /* ATInterstitialAdapter_h */
