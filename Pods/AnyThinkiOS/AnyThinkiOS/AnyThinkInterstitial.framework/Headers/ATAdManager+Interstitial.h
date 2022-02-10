//
//  ATAdManager+Interstitial.h
//  AnyThinkInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATInterstitialDelegate.h"
extern NSString *const kATInterstitialExtraMediationNameKey;
extern NSString *const kATInterstitialExtraUserIDKey;
extern NSString *const kATInterstitialExtraUserFeatureKey;
extern NSString *const kATInterstitialExtraLocationEnabledFlagKey;
extern NSString *const kATInterstitialExtraMuteStartPlayingFlagKey;
extern NSString *const kATInterstitialExtraFallbackFullboardBackgroundColorKey;
extern NSString *const kATInterstitialExtraAdSizeKey;//Supported by TT interstitial, defaults to 600 X 600
extern NSString *const kATInterstitialExtraUsesRewardedVideo;

extern NSString *const kATInterstitialExtraAdSize600_400;
extern NSString *const kATInterstitialExtraAdSize600_600;
extern NSString *const kATInterstitialExtraAdSize600_900;
@interface ATAdManager (Interstitial)
-(BOOL) interstitialReadyForPlacementID:(NSString*)placementID;
-(ATCheckLoadModel*) checkInterstitialLoadStatusForPlacementID:(NSString*)placementID;
-(void) showInterstitialWithPlacementID:(NSString*)placementID inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate;
-(void) showInterstitialWithPlacementID:(NSString*)placementID scene:(NSString*)scene inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate;
@end
