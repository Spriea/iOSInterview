//
//  ATInterstitialDelegate.h
//  AnyThinkInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATInterstitialDelegate_h
#define ATInterstitialDelegate_h
#import <AnyThinkSDK/AnyThinkSDK.h>

extern NSString *const kATInterstitialDelegateExtraNetworkIDKey;
extern NSString *const kATInterstitialDelegateExtraAdSourceIDKey;
extern NSString *const kATInterstitialDelegateExtraIsHeaderBidding;
extern NSString *const kATInterstitialDelegateExtraPrice;
extern NSString *const kATInterstitialDelegateExtraPriority;
@protocol ATInterstitialDelegate<ATAdLoadingDelegate>

-(void) interstitialDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) interstitialFailedToShowForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra;
-(void) interstitialDidStartPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) interstitialDidEndPlayingVideoForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) interstitialDidFailToPlayVideoForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra;
-(void) interstitialDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) interstitialDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) interstitialDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success;

@end

#endif /* ATInterstitialDelegate_h */
