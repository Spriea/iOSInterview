//
//  SKMainTabVC.h
//  Urgency
//
//  Created by Somer.King on 2019/4/10.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKMainTabVC : UITabBarController

@end

NS_ASSUME_NONNULL_END
@interface SKTabbar : UIButton

@property (weak, nonatomic) UIImageView *imgV;
@property (weak, nonatomic) UILabel *titleL;

@end
