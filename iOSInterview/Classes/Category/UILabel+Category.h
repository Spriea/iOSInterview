//
//  UILabel+Category.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

/**
 快捷设置Label的字体大小、颜色、标题
 
 @param font 字体大小
 @param title 标题
 @param color 字体颜色
 */
- (void)sk_TitleFont:(UIFont *)font title:(NSString *)title color:(UIColor *)color;

@end
