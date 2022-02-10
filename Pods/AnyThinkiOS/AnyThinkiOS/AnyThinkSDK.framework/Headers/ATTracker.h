//
//  ATTracker.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 19/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAd.h"
extern NSString *const kATTrackerExtraErrorKey;
extern NSString *const kATTrackerExtraAutoloadFlagKey;
extern NSString *const kATTrackerExtraSDKCalledFlagKey;
extern NSString *const kATTrackerExtraSDKNotCalledReasonKey;
extern NSString *const kATTrackerExtraLoadFailureReasonKey;
extern NSString *const kATTrackerExtraASIDKey;
extern NSString *const kATTrackerExtraStatusKey;
extern NSString *const ATTrackerExtraShownNetworkPriorityInfoKey;
extern NSString *const kATTrackerExtraHeaderBiddingInfoKey;
extern NSString *const kATTrackerExtraResourceTypeKey;
extern NSString *const kATTrackerExtraUnitIDKey;//Ad source id
extern NSString *const kATTrackerExtraNetworkFirmIDKey;
extern NSString *const kATTrackerExtraRefreshFlagKey;//for banner&native banner refresh
extern NSString *const kATTrackerExtraDefaultLoadFlagKey;
extern NSString *const kATTrackerExtraFilledWithinNetworkTimeoutFlagKey;
extern NSString *const kATTrackerExtraFillRequestFlagKey;
extern NSString *const kATTrackerExtraFillTimeKey;
extern NSString *const kATTrackerExtraASResultKey;
extern NSString *const kATTrackerExtraAppIDKey;
extern NSString *const kATTrackerExtraLastestRequestIDKey;
extern NSString *const kATTrackerExtraLastestRequestIDMatchFlagKey;
extern NSString *const kATTrackerExtraAdFilledByReadyFlagKey;
extern NSString *const kATTrackerExtraAutoloadOnCloseFlagKey;
extern NSString *const kATTrackerExtraLoadTimeKey;
extern NSString *const kATTrackerExtraClickAddressKey;
extern NSString *const kATTrackerExtraMyOfferDefaultFalgKey;
extern NSString *const kATTrackerExtraOfferLoadedByAdSourceStatusFlagKey;
extern NSString *const kATTrackerExtraCustomObjectKey;
extern NSString *const kATTrackerExtraAdObjectKey;
extern NSString *const kATTrackerExtraAdShowSceneKey;
extern NSString *const kATTrackerExtraAdShowSDKTimeKey;
extern NSString *const kATTrackerExtraTrafficGroupIDKey;
extern NSString *const kATTrackerExtraUGUnitIDKey;
extern NSString *const kATTrackerExtraASIDKey;
extern NSString *const kATTrackerExtraFormatKey;
extern NSString *const kATTrackerExtraRequestExpectedOfferNumberFlagKey;

// ofm
extern NSString *const kATTrackerExtraOFMTrafficIDKey;
extern NSString *const kATTrackerExtraOFMSystemKey;
extern NSString *const kATTrackerExtraOFMPreECPMKey;
extern NSString *const kATTrackerExtraOFMKey;

typedef NS_ENUM(NSInteger, ATNativeADTrackType) {
    ATNativeADTrackTypeADRequest = 1,
    //Send when the ad's been successfully downloaded.
    ATNativeADTrackTypeADRecalledSuccessfully = 2,
    //Send when the ad's failed to be downloaded.
    ATNativeADTrackTypeADRecallFailed = 3,
    ATNativeADTrackTypeADShow = 4, // impression
    ATNativeADTrackTypeADRefreshShow = 5,
    ATNativeADTrackTypeADClicked = 6,
    ATNativeADTrackTypeVideoPlayed = 7,
    ATNativeAdTrackTypeVideoStart = 8,
    ATNativeAdTrackTypeVideoEnd = 9,
    ATNativeAdTrackTypeLoad = 10,
    ATNativeAdTrackTypeBidSort = 11,
    ATNativeAdTrackTypeLoadResult = 12,//currently sent when loading succeeds
    ATNativeAdTrackTypeShowAPICall = 13,
    ATNativeADTrackTypeRankAndShuffle = 15
};

typedef NS_ENUM(NSInteger, ATNativeADSourceType) {
    ATNativeADSourceTypeUnknown = 0,
    ATNativeADSourceTypeVideo = 1,
    ATNativeADSourceTypeImage = 2
};
@interface ATTracker : NSObject
+(instancetype)sharedTracker;
-(void) trackWithPlacementID:(NSString*)placementID requestID:(NSString*)requestID trackType:(ATNativeADTrackType)trackType extra:(nullable NSDictionary*)extra;
-(void) trackClickWithAd:(nonnull id<ATAd>)ad extra:(nullable NSDictionary*)extra;
/*
 * For header bidding
 */
+(nullable NSDictionary*)headerBiddingTrackingExtraWithAd:(id<ATAd>)ad requestID:(NSString*)requestID;

+(nullable NSDictionary*)dataElementWithPlacementID:(NSString*)placementID requestID:(NSString*)requestID trackType:(ATNativeADTrackType)trackType extra:(NSDictionary*)extra;
+(nullable NSDictionary*)commonParameters;
@end
