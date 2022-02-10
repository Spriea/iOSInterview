//
//  ATNativeADDelegate.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 08/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATNativeADDelegate_h
#define ATNativeADDelegate_h
#import <AnyThinkSDK/AnyThinkSDK.h>
@class ATNativeADView;
extern NSString *const kATNativeDelegateExtraNetworkIDKey;
extern NSString *const kATNativeDelegateExtraAdSourceIDKey;
extern NSString *const kATNativeDelegateExtraIsHeaderBidding;
extern NSString *const kATNativeDelegateExtraPrice;
extern NSString *const kATNativeDelegateExtraPriority;
@protocol ATNativeADDelegate<ATAdLoadingDelegate>
-(void) didShowNativeAdInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didClickNativeAdInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didStartPlayingVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didEndPlayingVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didEnterFullScreenVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didExitFullScreenVideoInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didTapCloseButtonInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didLoadSuccessDrawWith:(NSArray*)views placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didDeepLinkOrJumpInAdView:(ATNativeADView*)adView placementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success;

@end
#endif /* ATNativeADDelegate_h */
