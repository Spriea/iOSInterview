//
//  SKNewVersionView.m
//  DayDayEdu
//
//  Created by dayday30 on 2018/11/2.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import "SKNewVersionView.h"
@interface SKNewVersionView ()

@property (weak, nonatomic) SKImgView *contView;

@end

@implementation SKNewVersionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
    }
    return self;
}

- (void)downRefrsh{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downUrl]];
}

- (void)noRefrsh{
    [self removeFromSuperview];
}

- (void)setupChildView{
    self.backgroundColor = alpColor(@"#000000", 0.5);
    
    CGRect contFrame = contFrame = CGRectMake(0, 0, kSCALE_X(300), kSCALE_X(200));;
    
    SKImgView *contView = [[SKImgView alloc] initWithFrame:contFrame];
//    contView.layer.cornerRadius = kSCALE_X(30);
//    contView.clipsToBounds = YES;
    contView.layer.cornerRadius = kSCALE_X(15);
    contView.center = self.center;
    contView.backgroundColor = [UIColor whiteColor];
    contView.userInteractionEnabled = YES;
    self.contView = contView;
    [self addSubview:contView];
    
    
    UILabel *versionL = [[UILabel alloc] init];
    versionL.numberOfLines = 0;
    [contView addSubview:versionL];
    self.versionL = versionL;
    [versionL sk_TitleFont:kFontWithSize(14) title:@"xxAPP\n版本更新\nV1.0" color:nil];
    [versionL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(kSCALE_X(138));
        make.top.equalTo(contView).offset(kSCALE_X(20));
    }];
    
    UILabel *updateL = [[UILabel alloc] init];
    [contView addSubview:updateL];
    
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.numberOfLines = 0;
    
    [contView addSubview:contentL];
    
    self.contentL = contentL;
    
    [updateL sk_TitleFont:kMedFontSize(18) title:@"版本更新" color:Color(@"#4A4A4A")];
    [contentL sk_TitleFont:kFontWithSize(14) title:@"" color:Color(@"#9B9B9B")];
    
    [updateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView).offset(kSCALE_X(20));
        make.centerX.equalTo(contView);
    }];
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView).offset(kSCALE_X(52));
        make.left.equalTo(contView).offset(kSCALE_X(21));
        make.right.equalTo(contView).offset(-kSCALE_X(21));
    }];
}

- (void)setIsMust:(BOOL)isMust{
    _isMust = isMust;
    UIButton *jumpClick = [UIButton buttonWithType:UIButtonTypeCustom];
    
    jumpClick.backgroundColor = Color(@"#30B5FF");
    [jumpClick sk_CornerRadius:kSCALE_X(10) borderColor:nil borderWidth:0];
    [jumpClick sk_TitleFont:[SKCustomFunction SemiboldIPhoneFontWithSize:14] title:@"下载更新" color:nil];
        
    
    [jumpClick addTarget:self action:@selector(downRefrsh) forControlEvents:UIControlEventTouchUpInside];
    [self.contView addSubview:jumpClick];
    if (isMust) { // 强制更新
        [jumpClick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contView).offset(-kSCALE_X(25));
            make.centerX.equalTo(self.contView);
            make.left.equalTo(self.contView).offset(kSCALE_X(25));
            make.height.mas_equalTo(kSCALE_X(40));
        }];
    }else{
        UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [noBtn addTarget:self action:@selector(noRefrsh) forControlEvents:UIControlEventTouchUpInside];
        [self.contView addSubview:noBtn];
        
        [noBtn sk_TitleFont:[SKCustomFunction SemiboldIPhoneFontWithSize:14] title:@"暂不更新" color:Color(@"#9B9B9B")];
        [noBtn sk_CornerRadius:kSCALE_X(10) borderColor:Color(@"#9B9B9B") borderWidth:0.5];
        [jumpClick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contView).offset(-kSCALE_X(25));
            make.right.equalTo(self.contView).offset(-kSCALE_X(25));
            make.width.mas_equalTo(kSCALE_X(110));
            make.height.mas_equalTo(kSCALE_X(40));
        }];
        [noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contView).offset(-kSCALE_X(25));
            make.left.equalTo(self.contView).offset(kSCALE_X(25));
            make.width.mas_equalTo(kSCALE_X(110));
            make.height.mas_equalTo(kSCALE_X(40));
        }];
    }
}

@end
