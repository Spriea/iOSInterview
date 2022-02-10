//
//  UIImage+Render.m
//  GiftSay
//
//  Created by YanMao on 16/10/2.
//  Copyright © 2016年 YanMao. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)
+ (UIImage *)imageNameOfOriginal:(NSString *)imageName
{
    UIImage *selImage = [UIImage imageNamed:imageName];
    // 返回一个没有被渲染的图片 *一定要去接收
    return [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
