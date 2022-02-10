//
//  UILabel+Category.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (void)sk_TitleFont:(UIFont *)font title:(NSString *)title color:(UIColor *)color{
    self.text = title;
    [self setFont:font];
    
    if (color == nil) {
        [self setTextColor:[UIColor whiteColor]];
    }else{
        [self setTextColor:color];
    }
    
}

@end
