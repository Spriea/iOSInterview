//
//  ATBannerDelegate.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATBannerDelegate_h
#define ATBannerDelegate_h
#import <AnyThinkSDK/AnyThinkSDK.h>
@class ATBannerView;

extern NSString *const kATBannerDelegateExtraNetworkIDKey;
extern NSString *const kATBannerDelegateExtraAdSourceIDKey;
extern NSString *const kATBannerDelegateExtraIsHeaderBidding;
extern NSString *const kATBannerDelegateExtraPrice;
extern NSString *const kATBannerDelegateExtraPriority;

@protocol ATBannerDelegate<ATAdLoadingDelegate>
-(void) bannerView:(ATBannerView*)bannerView failedToAutoRefreshWithPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) bannerView:(ATBannerView*)bannerView didShowAdWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) bannerView:(ATBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) bannerView:(ATBannerView*)bannerView didCloseWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra DEPRECATED_ATTRIBUTE;
-(void) bannerView:(ATBannerView*)bannerView didAutoRefreshWithPlacement:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) bannerView:(ATBannerView*)bannerView didTapCloseButtonWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void)  bannerView:(ATBannerView*)bannerView didDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success;

@end
#endif /* ATBannerDelegate_h */
