//
//  SKNewVersionView.h
//  DayDayEdu
//
//  Created by dayday30 on 2018/11/2.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKNewVersionView : UIView

@property (assign, nonatomic) BOOL isMust;
@property (weak, nonatomic) UILabel *contentL;
@property (weak, nonatomic) UILabel *versionL;
@property (strong, nonatomic) NSString *downUrl;

@end

NS_ASSUME_NONNULL_END
