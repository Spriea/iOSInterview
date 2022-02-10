//
//  SKAlertView.h
//  DayDayEdu
//
//  Created by dayday30 on 2018/11/14.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKAlertView : UIView

+ (instancetype)initWithMsg:(NSString *)msg confirmBtn:(NSString *)btnTitle confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancleHandler:(void (^)(UIAlertAction *action))cancleHandler;

@end

NS_ASSUME_NONNULL_END
