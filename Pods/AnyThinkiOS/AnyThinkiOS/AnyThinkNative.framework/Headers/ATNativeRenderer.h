//
//  ATNativeRenderer.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 25/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>
#import "ATNativeADRenderer.h"
//#import "ATAPI.h"
@protocol ATNativeADRenderer;
@class ATNativeADCache;
@interface ATNativeRenderer : NSObject<ATNativeADRenderer>
//This method has been added specifically for Mopub; renderers of other networks don't implement it.
+(id) retrieveRendererWithOffer:(ATNativeADCache*)offer;
-(UIView*)retriveADView;
-(instancetype) initWithConfiguraton:(ATNativeADConfiguration*)configuration adView:(ATNativeADView*)adView;
-(__kindof UIView*)createMediaView;
@property(nonatomic, weak) ATNativeADView *ADView;
@property(nonatomic, readonly) ATNativeADConfiguration *configuration;
@end
