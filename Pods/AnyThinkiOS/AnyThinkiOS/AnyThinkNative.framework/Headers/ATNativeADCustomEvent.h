//
//  ATNativeADCustomEvent.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 25/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

#import "ATNativeADView.h"
//#import "ATTracker.h"
#import "ATNativeADDelegate.h"
//#import "ATAdCustomEvent.h"

@class ATNativeADCache;
@interface ATNativeADCustomEvent : ATAdCustomEvent
-(void) trackNativeAdLoaded:(NSDictionary*)assets;
-(void) trackNativeAdLoadFailed:(NSError*)error;
-(void) didAttachMediaView;
-(void) willDetachOffer:(ATNativeADCache*)offer fromAdView:(ATNativeADView*)adView;
/**
 *@para refresh: whether the show is trigered by a ad refresh.
 */
- (void)trackNativeAdShow:(BOOL)refresh;
- (void)trackNativeAdClick;
- (void)trackNativeAdVideoStart;
- (void)trackNativeAdVideoEnd;
- (void)trackNativeAdClosed;
- (void)trackNativeAdImpression;
-(void) trackNativeAdDeeplinkOrJumpResult:(BOOL)success;

/// If it returns YES, then when sending the embedding points of "show", the embedding points of "impression" will be sent together. Otherwise, it will not be sent. Same for the banner ads (ATBannerCustomEvent.h).
- (BOOL)sendImpressionTrackingIfNeed;

-(NSDictionary*)delegateExtra;
-(ATNativeADSourceType) sourceType;
@property(nonatomic, copy) void(^requestCompletionBlock)(NSArray<NSDictionary*> *assets, NSError *error);
@property(nonatomic, weak) ATNativeADView *adView;
@property(nonatomic) NSInteger requestNumber;
/**
 * Failed or successful, a request's considered finished.
 */
@property(nonatomic) NSInteger numberOfFinishedRequests;
@property(nonatomic, readonly) NSMutableArray<NSDictionary*>* assets;
@property(nonatomic) NSDictionary *requestExtra;
@end

@interface ATNativeADView(Event)
-(void) notifyNativeAdClick;
-(void) notifyVideoStart;
-(void) notifyVideoEnd;
-(void) notifyVideoEnterFullScreen;
-(void) notifyVideoExitFullScreen;
-(void) notifyCloseButtonTapped;
-(void) notifyDeeplinkOrJumpResult:(BOOL)success;

@end
