//
//  SKSameLabel.m
//  DayDayEdu
//
//  Created by dayday30 on 2018/11/6.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import "SKSameLabel.h"

@implementation SKSameLabel

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 0.5);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor whiteColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    //    self.shadowColor = alpColor(@"#000000", 0.5);
    //    self.shadowOffset = CGSizeMake(0, kSCALE_X(2));
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

@end
