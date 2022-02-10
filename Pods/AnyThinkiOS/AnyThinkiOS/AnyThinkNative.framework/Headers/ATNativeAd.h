//
//  ATNativeAd.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 02/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATNativeAd : NSObject
@property(nonatomic, readonly) NSString *advertiser;
@property(nonatomic, readonly) NSString *title;
@property(nonatomic, readonly) NSString *mainText;
@property(nonatomic, readonly) NSString *ctaText;
@property(nonatomic, readonly) UIImage *icon;
@property(nonatomic, readonly) UIImage *mainImage;
@property(nonatomic, readonly) UIImage *logo;
@property(nonatomic, readonly) NSNumber *rating;
@property(nonatomic, readonly) UIImage *sponsorImage;
/**
 * For some ads, this property does not always determines whether the ad is a video ad or not; however, to do this, you can always use the corresponding ad view's isVideoContents method instead.
 */
@property(nonatomic, readonly, getter=isVideoContents) BOOL videoContents;
@end
