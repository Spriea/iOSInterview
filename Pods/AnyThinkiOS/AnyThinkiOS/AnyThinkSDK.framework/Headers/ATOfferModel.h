//
//  ATOfferModel.h
//  AnyThinkSDK
//
//  Created by stephen on 21/8/2020.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import "ATModel.h"
#import <UIKit/UIKit.h>

extern NSString *const kATOfferBannerSize320_50;
extern NSString *const kATOfferBannerSize320_90;
extern NSString *const kATOfferBannerSize300_250;
extern NSString *const kATOfferBannerSize728_90;

@interface ATVideoPlayingTKItem : NSObject

@property (nonatomic, copy) NSArray<NSString *> *urls;
@property (nonatomic) NSInteger triggerTime;
@property (nonatomic) BOOL sent;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface ATOfferModel : ATModel

@property(nonatomic, readwrite) NSString *resourceID;
@property(nonatomic, readwrite) NSString *offerID;
@property(nonatomic, readwrite) NSString *pkgName;
@property(nonatomic, readwrite) NSString *title;
@property(nonatomic, readwrite) NSString *text;
@property(nonatomic, readwrite) NSInteger rating;
@property(nonatomic, readwrite) NSString *iconURL;
@property(nonatomic, readwrite) NSString *fullScreenImageURL;
@property(nonatomic, readwrite) ATInterstitialType interstitialType;//check the offer for video or image
@property(nonatomic, readwrite) NSString *logoURL;//adv_u
@property(nonatomic, readwrite) NSString *CTA;
@property(nonatomic, readwrite) NSString *videoURL;
@property(nonatomic, readwrite) NSString *storeURL;
@property(nonatomic, readwrite) ATLinkType linkType;
@property(nonatomic, readwrite) NSString *clickURL;
@property(nonatomic, readwrite) NSString *deeplinkUrl;
@property(nonatomic, readwrite) NSString *localResourceID;
@property(nonatomic, readwrite) ATOfferModelType offerModelType;
@property(nonatomic, readwrite) ATOfferCrtType crtType;

@property(nonatomic, copy) NSString *jumpUrl;
@property(nonatomic) NSInteger offerFirmID;

//banner(myoffer:5.6.6)
@property(nonatomic, readwrite) NSString *bannerImageUrl;
@property(nonatomic, readwrite) NSString *bannerBigImageUrl;
@property(nonatomic, readwrite) NSString *rectangleImageUrl;
@property(nonatomic, readwrite) NSString *homeImageUrl;

@property(nonatomic, readwrite) NSArray<NSString*>* resourceURLs;

@property(nonatomic) NSInteger displayDuration;

@property(nonatomic, readwrite) NSArray<NSString*>* clickTKUrl;
@property(nonatomic, readwrite) NSArray<NSString*>* openSchemeFailedTKUrl;

//to do
@property(nonatomic) NSInteger videoCurrentTime;
@property(nonatomic) NSInteger videoResumeTime;

@property(nonatomic, copy) NSDictionary *tapInfoDict;
@end


