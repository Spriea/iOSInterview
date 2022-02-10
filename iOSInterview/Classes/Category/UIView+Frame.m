//
//  UIView+Frame.m
//  04181-微博项目
//
//  Created by SprieaCT on 16/5/5.
//  Copyright (c) 2016年 Spriea. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)sk_x
{
    return self.frame.origin.x;
}
- (void)setSk_x:(CGFloat)x
{
    CGRect frame =  self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)sk_bottom{
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setSk_bottom:(CGFloat)sk_bottom{
    CGRect frame = self.frame;
    frame.origin.y = sk_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)sk_right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSk_right:(CGFloat)sk_right{
    CGRect frame = self.frame;
    frame.origin.x = sk_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)sk_y
{
    return self.frame.origin.y;
}
- (void)setSk_y:(CGFloat)y
{
    CGRect frame =  self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)sk_centerX
{
    return self.center.x;
}
- (void)setSk_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)sk_centerY
{
    return self.center.y;
}
- (void)setSk_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)sk_width
{
    return self.frame.size.width;
}
- (void)setSk_width:(CGFloat)width
{
    CGRect frame =  self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)sk_heigth
{
    return self.frame.size.height;
}
- (void)setSk_heigth:(CGFloat)heigth
{
    CGRect frame =  self.frame;
    frame.size.height = heigth;
    self.frame = frame;
}

- (CGSize)sk_size
{
    return self.frame.size;
}
- (void)setSk_size:(CGSize)size
{
    CGRect frame =  self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)sk_origin
{
    return self.frame.origin;
}
- (void)setSk_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)sk_removeSubviews{
    for (UIView *v in [self subviews]) {
        [v removeFromSuperview];
    }
}
#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)sk_setBackgroundGradual{
    CAGradientLayer *grad1 = [CAGradientLayer layer];
    grad1.colors = @[(__bridge id)Color(@"#0797e4").CGColor, (__bridge id)Color(@"#2be4ae").CGColor];
    grad1.locations = @[@0, @1.0];
    grad1.startPoint = CGPointMake(0, 0);
    grad1.endPoint = CGPointMake(1.0, 0);
    grad1.frame = self.bounds;
    [self.layer addSublayer:grad1];
}

- (void)sk_setBackgroundGradual:(UIColor *)fromColor toColor:(UIColor *)toColor {
    CAGradientLayer *grad1 = [CAGradientLayer layer];
    grad1.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    grad1.locations = @[@0, @1.0];
    grad1.startPoint = CGPointMake(0, 0);
    grad1.endPoint = CGPointMake(1.0, 0);
    grad1.frame = self.bounds;
    [self.layer addSublayer:grad1];
}
@end

