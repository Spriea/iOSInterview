//
//  ATSplashDelegate.h
//  AnyThinkSplash
//
//  Created by Martin Lau on 2018/12/20.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATSplashDelegate_h
#define ATSplashDelegate_h
#import <AnyThinkSDK/AnyThinkSDK.h>

extern NSString *const kATSplashDelegateExtraNetworkIDKey;
extern NSString *const kATSplashDelegateExtraAdSourceIDKey;
extern NSString *const kATSplashDelegateExtraIsHeaderBidding;
extern NSString *const kATSplashDelegateExtraPrice;
extern NSString *const kATSplashDelegateExtraPriority;

@protocol ATSplashDelegate<ATAdLoadingDelegate>

-(void)splashDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra;
-(void)splashDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra;
-(void)splashDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra;
-(void)splashDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success;

-(void)splashZoomOutViewDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra;
-(void)splashZoomOutViewDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra;
@end
#endif /* ATSplashDelegate_h */
