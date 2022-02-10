//
//  ATBannerView.h
//  AnyThinkBanner
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ATBannerDelegate;
@interface ATBannerView : UIView
//to be move into a internal category
@property(nonatomic, weak) id<ATBannerDelegate> delegate;
@property(nonatomic, weak) UIViewController *presentingViewController;

- (void)sendImpressionTracking;
@end
