//
//  SKAddPersonView.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/7/12.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKAddPersonView.h"

@interface SKAddPersonView()

@property (weak, nonatomic) UIScrollView *scrollV;
@property (weak, nonatomic) UILabel *desL;

@end

@implementation SKAddPersonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setContStr:(NSString *)contStr{
    _contStr = contStr;
    CGFloat h = [contStr sizeWithMaxWidth:self.scrollV.sk_width-kSCALE_X(24) andFont:kFontWithSize(12)].height + kSCALE_X(13);
    self.desL.frame = CGRectMake(kSCALE_X(14), kSCALE_X(43), self.scrollV.sk_width-kSCALE_X(24), h);
    self.desL.text = contStr;
    
    self.scrollV.contentSize = CGSizeMake(0, h+kSCALE_X(43));
}

// 初始化
- (void)setup{
//    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    self.backgroundColor = alpColor(@"#000000", 0.3);
    
    UIImageView *contV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE_X(320), kSCALE_X(415))];
    contV.backgroundColor = [UIColor clearColor];
    contV.userInteractionEnabled = YES;
    contV.image = kImageInstance(@"login_chart");
//    contV.layer.cornerRadius = kSCALE_X(6);
//    contV.layer.masksToBounds = YES;
    contV.center = self.center;
    [self addSubview:contV];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, contV.sk_width, contV.sk_heigth-kSCALE_X(37))];
    scrollV.backgroundColor = [UIColor clearColor];
    [contV addSubview:scrollV];
    self.scrollV = scrollV;
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.numberOfLines = 0;
    titleL.textAlignment = NSTextAlignmentCenter;
    [titleL sk_TitleFont:kFontWithSize(14) title:@"学习指导" color:k3Color];
    [scrollV addSubview:titleL];
    CGFloat titlH = [@"学习指导" sizeWithMaxWidth:scrollV.sk_width andFont:kFontWithSize(12)].height;
    titleL.frame = CGRectMake(0, kSCALE_X(13), scrollV.sk_width, titlH);
    
    UILabel *desL = [[UILabel alloc] init];
    desL.numberOfLines = 0;

    [desL sk_TitleFont:kFontWithSize(12) title:@"" color:k3Color];
    [scrollV addSubview:desL];
    self.desL = desL;
    
//    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, contV.sk_heigth-kSCALE_X(37), contV.sk_width*0.5, kSCALE_X(37))];
//    [cancel sk_TitleFont:kFontWithSize(12) title:@"关闭" color:kAColor];
//    [contV addSubview:cancel];
//    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
//    cancel.layer.borderWidth = 0.5;
//    cancel.layer.borderColor = kLineColor.CGColor;
    
    UIButton *agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, contV.sk_heigth-kSCALE_X(37), kSCALE_X(80), kSCALE_X(30))];
    [agreeBtn sk_TitleFont:kFontWithSize(14) title:@"关闭" color:nil];
    [agreeBtn sk_CornerRadius:agreeBtn.sk_heigth*0.5 borderColor:nil borderWidth:0];
    agreeBtn.sk_centerX = contV.sk_width*0.5;
    agreeBtn.backgroundColor = RGB(72, 201, 151, 1.0);
    [contV addSubview:agreeBtn];
    [agreeBtn addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn.layer.borderWidth = 0.5;
    agreeBtn.layer.borderColor = kLineColor.CGColor;
}

- (void)cancelClick{
    [self removeFromSuperview];
}

- (void)agreeClick{
    if (self.agreeProtoclBlock) {
        self.agreeProtoclBlock();
    }
    [self removeFromSuperview];
}

@end
