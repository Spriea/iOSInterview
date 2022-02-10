//
//  ATAdManager.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 04/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kAdAssetsCustomEventKey;
extern NSString *const kAdAssetsCustomObjectKey;

//Banner's ad size, the value is a NSValue wrapped CGSize; for banner ad loading, we only support (320.0f, 50.0f) now, so the value you pass via this key will be ignored.
extern NSString *const kExtraInfoAdSizeKey;
extern NSString *const kATAdLoadingExtraGDTEnableDefaultAudioSessionKey;
@protocol ATAdLoadingDelegate;
@interface ATAdManager : NSObject
+(instancetype) sharedManager;
@property(nonatomic, strong) NSDictionary *extra;
/*
 We mark this method as deprecated because we move customData into ATAPI's shared instance. customData passed via this method will just be ignored.
 */
-(void) loadADWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra customData:(NSDictionary*)customData delegate:(id<ATAdLoadingDelegate>)delegate DEPRECATED_ATTRIBUTE;
-(void) loadADWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra delegate:(id<ATAdLoadingDelegate>)delegate;
-(void) clearCache DEPRECATED_ATTRIBUTE;
@end
