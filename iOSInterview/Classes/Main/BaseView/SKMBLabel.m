//
//  SKMBLabel.m
//  DayDayEdu
//
//  Created by dayday30 on 2018/10/29.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import "SKMBLabel.h"

@implementation SKMBLabel

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 0.5);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = textColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = [UIColor whiteColor];
//    self.shadowColor = alpColor(@"#000000", 0.5);
//    self.shadowOffset = CGSizeMake(0, kSCALE_X(2));
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}



@end
