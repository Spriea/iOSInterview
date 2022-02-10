//
//  UIView+Frame.h
//  04181-微博项目
//
//  Created by SprieaCT on 16/5/5.
//  Copyright (c) 2016年 Spriea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (assign, nonatomic) CGFloat sk_x;
@property (assign, nonatomic) CGFloat sk_y;
@property (assign, nonatomic) CGFloat sk_right;
@property (assign, nonatomic) CGFloat sk_bottom;
@property (assign, nonatomic) CGFloat sk_centerX;
@property (assign, nonatomic) CGFloat sk_centerY;
@property (assign, nonatomic) CGFloat sk_width;
@property (assign, nonatomic) CGFloat sk_heigth;
@property (assign, nonatomic) CGPoint sk_origin;
@property (assign, nonatomic) CGSize sk_size;

- (void)sk_removeSubviews;

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

- (void)sk_setBackgroundGradual;
- (void)sk_setBackgroundGradual:(UIColor *)fromColor toColor:(UIColor *)toColor;


@end
