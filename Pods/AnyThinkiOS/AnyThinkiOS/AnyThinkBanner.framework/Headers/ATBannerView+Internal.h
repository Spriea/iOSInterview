//
//  ATBanner+Internal.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 28/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATBanner_Internal_h
#define ATBanner_Internal_h
#import "ATBannerView.h"
@class ATBanner;
@interface ATBannerView(Internal)
-(instancetype) initWithFrame:(CGRect)frame banner:(ATBanner*)banner;
-(void) loadNextWithoutRefresh;
@property(nonatomic) ATBanner *banner;
@end
#endif /* ATBanner_Internal_h */
