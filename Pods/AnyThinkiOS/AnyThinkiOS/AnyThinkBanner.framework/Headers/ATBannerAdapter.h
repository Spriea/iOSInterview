//
//  ATBannerAdapter.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 2018/10/8.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATBannerAdapter_h
#define ATBannerAdapter_h
@class ATBanner;
@protocol ATBannerAdapter<ATAdAdapter>
+(void) showBanner:(ATBanner*)banner inView:(UIView*)view presentingViewController:(UIViewController*)viewController;
@end
#endif /* ATBannerAdapter_h */
