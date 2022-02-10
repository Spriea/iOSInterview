//
//  ATRewardedVideoDelegate.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATRewardedVideoDelegate_h
#define ATRewardedVideoDelegate_h
#import <AnyThinkSDK/AnyThinkSDK.h>

extern NSString *const kATRewardedVideoCallbackExtraAdsourceIDKey;
extern NSString *const kATRewardedVideoCallbackExtraNetworkIDKey;
extern NSString *const kATRewardedVideoCallbackExtraIsHeaderBidding;
extern NSString *const kATRewardedVideoCallbackExtraPrice;
extern NSString *const kATRewardedVideoCallbackExtraPriority;
@protocol ATRewardedVideoDelegate<ATAdLoadingDelegate>

-(void) rewardedVideoDidStartPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) rewardedVideoDidEndPlayingForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) rewardedVideoDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error extra:(NSDictionary*)extra;
-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded extra:(NSDictionary*)extra;
-(void) rewardedVideoDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) rewardedVideoDidRewardSuccessForPlacemenID:(NSString*)placementID extra:(NSDictionary*)extra;
-(void) rewardedVideoDidDeepLinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra result:(BOOL)success;

@end
#endif /* ATRewardedVideoDelegate_h */
