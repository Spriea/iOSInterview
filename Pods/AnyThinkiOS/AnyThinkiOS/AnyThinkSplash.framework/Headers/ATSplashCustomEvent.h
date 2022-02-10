//
//  ATSplashCustomEvent.h
//  AnyThinkSplash
//
//  Created by Martin Lau on 2018/12/20.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AnyThinkSDK/AnyThinkSDK.h>
//#import "ATAdCustomEvent.h"
extern NSString *const kATSplashExtraRequestIDKey;
@class ATSplash;
@protocol ATSplashDelegate;
@interface ATSplashCustomEvent : ATAdCustomEvent
-(instancetype) initWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo;
@property(nonatomic, assign) id<ATSplashDelegate> delegate;
@property(nonatomic, readonly) NSString *unitID;
@property(nonatomic, assign) NSInteger priorityIndex;
-(NSDictionary*)delegateExtra;
-(void) trackShowWithoutWaterfall;
-(void) trackClickWithoutWaterfall;
-(void) trackSplashAdClosed;
-(void) trackSplashAdLoaded:(id)splashAd;
-(void) trackSplashAdLoaded:(id)splashAd adExtra:(NSDictionary *)adExtra;
-(void) trackSplashAdShow;
-(void) trackSplashAdClick;
-(void) trackSplashAdLoadFailed:(NSError*)error;
-(void) trackSplashAdZoomOutViewClick;
-(void) trackSplashAdZoomOutViewClosed;
-(void) trackSplashAdDeeplinkOrJumpResult:(BOOL)success;

@end
