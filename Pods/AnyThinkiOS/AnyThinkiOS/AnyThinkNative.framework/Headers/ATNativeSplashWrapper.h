 //
//  ATNativeSplashWrapper.h
//  AnyThinkSDKDemo
//
//  Created by Martin Lau on 2019/3/19.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kATNativeSplashShowingExtraRecommendTitleKey;
extern NSString *const kATNativeSplashShowingExtraCTAButtonBackgroundColorKey;
extern NSString *const kATNativeSplashShowingExtraCTAButtonTitleColorKey;
extern NSString *const kATNativeSplashShowingExtraContainerViewKey;
extern NSString *const kATNativeSplashShowingExtraCountdownIntervalKey;
extern NSString *const kATNatievSplashShowingExtraStyleKey;

extern NSString *const kATNativeSplashShowingExtraStylePortrait;
extern NSString *const kATNativeSplashShowingExtraStyleLandscape;

@protocol ATNativeSplashDelegate<NSObject>
-(void) finishLoadingNativeSplashAdForPlacementID:(NSString*)placementID;
-(void) failedToLoadNativeSplashAdForPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) didShowNativeSplashAdForPlacementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;
-(void) didClickNaitveSplashAdForPlacementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;
-(void) didCloseNativeSplashAdForPlacementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;

-(void) didShowNativeSplashAdForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didClickNaitveSplashAdForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didCloseNativeSplashAdForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra;
- (void)didNativeSplashDeeplinkOrJumpForPlacementID:(NSString*)placementID extra:(NSDictionary *)extra result:(BOOL)success;

@end

@interface ATNativeSplashWrapper : NSObject
+(instancetype) sharedWrapper;
+(void) loadNativeSplashAdWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra customData:(NSDictionary*)customData delegate:(id<ATNativeSplashDelegate>)delegate;
+(void) showNativeSplashAdWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra delegate:(id<ATNativeSplashDelegate>)delegate;
+(BOOL) splashNativeAdReadyForPlacementID:(NSString*)placementID;
@end
