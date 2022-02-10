//
//  UIButton+Category.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

- (void)sk_TitleFont:(UIFont *)font title:(NSString *)title color:(UIColor *)color{
    [self.titleLabel setFont:font];
    if (color == nil) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)sk_CornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    if (color != nil ) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
    }
}

@end
