//
//  ATRewardedVideoCustomEvent.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
//#import "ATAdCustomEvent.h"
#import "ATRewardedVideoDelegate.h"
#import "ATRewardedVideo.h"

@interface ATRewardedVideoCustomEvent : ATAdCustomEvent
-(void) trackRewardedVideoAdPlayEventWithError:(NSError*)error;
-(void) trackRewardedVideoAdCloseRewarded:(BOOL)rewarded;
-(void) trackRewardedVideoAdVideoStart;
-(void) trackRewardedVideoAdVideoEnd;
-(void) trackRewardedVideoAdClick;
-(void) trackRewardedVideoAdShow;
-(void) trackRewardedVideoAdLoadFailed:(NSError*)error;
-(void) trackRewardedVideoAdLoaded:(id)adObject adExtra:(NSDictionary *)adExtra;
-(void) trackRewardedVideoAdRewarded;
-(void) trackRewardedVideoAdDeeplinkOrJumpResult:(BOOL)success;

-(NSDictionary*)delegateExtra;

-(instancetype) initWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary *)localInfo;
@property(nonatomic, weak) id<ATRewardedVideoDelegate> delegate;
@property(nonatomic, weak) ATRewardedVideo *rewardedVideo;
@property(nonatomic, readonly) NSString *unitID;
@property(nonatomic) NSString *userID;
@property(nonatomic, assign) NSInteger priorityIndex;
@end
