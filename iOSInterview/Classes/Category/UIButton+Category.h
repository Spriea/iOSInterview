//
//  UIButton+Category.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/**
 快捷设置按钮的字体大小、颜色、标题

 @param font 字体大小
 @param title 标题
 @param color 字体颜色
 */
- (void)sk_TitleFont:(UIFont *)font title:(NSString *)title color:(UIColor *)color;


/**
 快捷设置按钮圆角和边角

 @param cornerRadius 圆角大小
 @param color 边角颜色
 @param borderWidth 边角线宽
 */
- (void)sk_CornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end
