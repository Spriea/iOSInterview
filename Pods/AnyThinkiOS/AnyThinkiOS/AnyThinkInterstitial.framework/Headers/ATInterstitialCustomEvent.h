//
//  ATInterstitialCustomEvent.h
//  AnyThinkInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "ATInterstitial.h"
#import "ATInterstitialDelegate.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
@interface ATInterstitialCustomEvent : ATAdCustomEvent
-(void) trackInterstitialAdLoaded:(id)interstitialAd adExtra:(NSDictionary *)adExtra;
-(void) trackInterstitialAdLoadFailed:(NSError*)error;
-(void) trackInterstitialAdShow;
-(void) trackInterstitialAdShowFailed:(NSError*)error;
-(void) trackInterstitialAdVideoStart;
-(void) trackInterstitialAdVideoEnd;
-(void) trackInterstitialAdDidFailToPlayVideo:(NSError*)error;
-(void) trackInterstitialAdClick;
-(void) trackInterstitialAdClose;
-(void) trackInterstitialAdDeeplinkOrJumpResult:(BOOL)success;

-(NSDictionary*)delegateExtra;
-(ATNativeADSourceType) adSourceType;
-(instancetype) initWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo ;
@property(nonatomic, weak) id<ATInterstitialDelegate> delegate;
@property(nonatomic, weak) ATInterstitial *interstitial;
@property(nonatomic, readonly) NSString *unitID;
@property(nonatomic, assign) NSInteger priorityIndex;
@end
