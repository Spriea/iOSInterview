//
//  ATModel.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 11/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ATEndCardClickable) {
    ATEndCardClickableFullscreen = 1,
    ATEndCardClickableCTA,
    ATEndCardClickableBanner
};

typedef NS_ENUM(NSInteger, ATScreenOrientation) {
    ATScreenOrientationPortrait,
    ATScreenOrientationLandscape
};

typedef NS_ENUM(NSInteger, ATInterstitialType) {
    ATInterstitialVideo = 1,
    ATInterstitialPicture
};

typedef NS_ENUM(NSInteger, ATLinkType) {
    ATLinkTypeAppStore = 1,
    ATLinkTypeSafari,
    ATLinkTypeWebView,
    ATLinkTypeInnerSafari = 5
};

typedef NS_ENUM(NSInteger, ATClickMode) {
    ATClickModeSync = 1,
    ATClickModeAsync
};

typedef NS_ENUM(NSInteger, ATLoadType) {
    ATLoadTypeBrowser = 1,
    ATLoadTypeInternalBrowser
};

typedef NS_ENUM(NSInteger, ATUserAgentType) {
    ATUserAgentWebView = 1,
    ATUserAgentSystem
};

typedef NS_ENUM(NSInteger, ATLoadStorekitTime) {
    ATLoadStorekitTimePreload = 1,
    ATATLoadStorekitTimeClick,
    ATATLoadStorekitTimeNone
};
typedef NS_ENUM(NSInteger, ATVideoClickable) {
    ATVideoClickableNone = 1,
    ATVideoClickableWithCTA
};

typedef NS_ENUM(NSInteger, ATNetworkFirmId) {
    ATNetworkFirmIdADX =  66,
    ATNetworkFirmIdMyOffer = 35,
    ATNetworkFirmIdGDTOnline = 42
};

typedef NS_ENUM(NSInteger, ATOfferModelType) {
    ATOfferModelMyOffer = 1,
    ATOfferModelADX =  2,
    ATOfferModelOnlineApi =  3
};

typedef NS_ENUM(NSInteger, ATOfferCrtType) {
    ATOfferCrtTypeOneImage = 1,
    ATOfferCrtTypeImages = 2,
    ATOfferCrtTypeOneImageWithText = 3,
    ATOfferCrtTypeImagesWithText = 4,
    ATOfferCrtTypeVideo = 5,
    ATOfferCrtTypeXHTML = 6
};

typedef NS_ENUM(NSInteger, ATDeepLinkClickMode) {
    ATDeepLinkModeNone = 1,
    ATDeepLinkModePreClickUrl = 2,
    ATDeepLinkModeLastClickUrl = 3
};

typedef NS_ENUM(NSInteger, ATClickType) {
    ATClickTypeClickUrl = 1,
    ATClickTypeDeepLinkUrl,
    ATClickTypeClickJumpUrl
};


@interface ATModel : NSObject
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
