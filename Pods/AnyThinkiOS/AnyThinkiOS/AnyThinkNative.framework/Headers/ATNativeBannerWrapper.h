//
//  ATNativeBannerWrapper.h
//  AnyThinkSDKDemo
//
//  Created by Martin Lau on 2019/4/10.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnyThinkNative/AnyThinkNative.h>
@class ATNativeBannerView;
@protocol ATNativeBannerDelegate<NSObject>
-(void) didFinishLoadingNativeBannerAdWithPlacementID:(NSString *)placementID;
-(void) didFailToLoadNativeBannerAdWithPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) didShowNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;
-(void) didClickNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;
-(void) didClickCloseButtonInNativeBannerAdView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;
-(void) didAutorefreshNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID DEPRECATED_ATTRIBUTE;
-(void) didFailToAutorefreshNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID error:(NSError*)error DEPRECATED_ATTRIBUTE;

-(void) didShowNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didClickNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didClickCloseButtonInNativeBannerAdView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didAutorefreshNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra;
-(void) didFailToAutorefreshNativeBannerAdInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra error:(NSError*)error;
- (void)didNativeBannerDeeplinkOrJumpInView:(ATNativeBannerView*)bannerView placementID:(NSString*)placementID extra:(NSDictionary *)extra result:(BOOL)success;

@end

@interface ATNativeBannerView:UIView
@property(nonatomic, weak) id<ATNativeBannerDelegate> delegate;
@end

extern NSString *const kATNativeBannerAdShowingExtraBackgroundColorKey;
extern NSString *const kATNativeBannerAdShowingExtraAdSizeKey;
extern NSString *const kATNativeBannerAdShowingExtraAutorefreshIntervalKey;
extern NSString *const kATNativeBannerAdShowingExtraHideCloseButtonFlagKey;
extern NSString *const kATNativeBannerAdShowingExtraCTAButtonBackgroundColorKey;
extern NSString *const kATNativeBannerAdShowingExtraCTAButtonTitleFontKey;
extern NSString *const kATNativeBannerAdShowingExtraCTAButtonTitleColorKey;
extern NSString *const kATNativeBannerAdShowingExtraTitleFontKey;
extern NSString *const kATNativeBannerAdShowingExtraTitleColorKey;
extern NSString *const kATNativeBannerAdShowingExtraTextFontKey;
extern NSString *const kATNativeBannerAdShowingExtraTextColorKey;
extern NSString *const kATNativeBannerAdShowingExtraAdvertiserTextFontKey;
extern NSString *const kATNativeBannerAdShowingExtraAdvertiserTextColorKey;
@interface ATNativeBannerWrapper:NSObject
+(instancetype) sharedWrapper;
+(void) loadNativeBannerAdWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra customData:(NSDictionary*)customData delegate:(id<ATNativeBannerDelegate>)delegate;
+(ATNativeBannerView*) retrieveNativeBannerAdViewWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra delegate:(id<ATNativeBannerDelegate>)delegate;
+(BOOL) nativeBannerAdReadyForPlacementID:(NSString*)placementID;
@end
