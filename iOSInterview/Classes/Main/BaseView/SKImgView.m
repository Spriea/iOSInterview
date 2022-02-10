//
//  SKImgView.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/2/5.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKImgView.h"

@implementation SKImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
