//
//  SKAlertView.m
//  DayDayEdu
//
//  Created by dayday30 on 2018/11/14.
//  Copyright © 2018年 dayday30. All rights reserved.
//

#import "SKAlertView.h"

typedef void(^ActionBlock)(UIAlertAction *action);
@interface SKAlertView()

@property (copy, nonatomic) ActionBlock confirmHandler;
@property (copy, nonatomic) ActionBlock cancleHandler;

@end

@implementation SKAlertView

+ (instancetype)initWithMsg:(NSString *)msg confirmBtn:(NSString *)btnTitle confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancleHandler:(void (^)(UIAlertAction *action))cancleHandler{
//    SKAlertView *cover = [[SKAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
//    cover.backgroundColor = alpColor(@"#000000", 0.6);
//    cover.confirmHandler = confirmHandler;
//    cover.cancleHandler = cancleHandler;
//
//    CGRect backFrame = CGRectMake(0, 0, kSCALE_X(700), kSCALE_X(600));
//
//    UIImageView *backImg = [[UIImageView alloc] initWithFrame:backFrame];
//    backImg.userInteractionEnabled = YES;
//    backImg.image = kImageInstance(@"alert_back");
//    [cover addSubview:backImg];
//    backImg.center = cover.center;
//
//    UILabel *msgL = [[UILabel alloc] init];
//    msgL.textAlignment = NSTextAlignmentCenter;
//    msgL.numberOfLines = 0;
//    UIFont *mslFont = [SKCustomFunction SemiboldIPhoneFontWithSize:kChangeSize(38)];
//    [msgL sk_TitleFont:mslFont title:msg color:Color(@"#234580")];
//    [backImg addSubview:msgL];
//
//    UIButton *confBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [msgL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backImg).offset(kChangeSCALE_X(168));
//        make.bottom.equalTo(backImg).offset(-kChangeSCALE_X(310));
//        make.width.mas_equalTo(kChangeSCALE_X(520));
//        make.centerX.equalTo(backImg);
//    }];
//    [confBtn setTitleEdgeInsets:UIEdgeInsetsMake(-kChangeSCALE_X(3), 0, kChangeSCALE_X(4), 0)];
//
//    UIFont *confFont = [SKCustomFunction SemiboldIPhoneFontWithSize:kChangeSize(32)];;
//
//    if (btnTitle.length == 0) {
//        [confBtn sk_TitleFont:confFont title:@"确定" color:nil];
//    }else{
//        [confBtn sk_TitleFont:confFont title:btnTitle color:nil];
//    }
//
//    [confBtn setBackgroundImage:kImageInstance(@"alert_btn_bac") forState:UIControlStateNormal];
//    [confBtn addTarget:cover action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
//    [backImg addSubview:confBtn];
//    if (cancleHandler == nil) {
//        confBtn.frame = CGRectMake(kChangeSCALE_X(185), kChangeSCALE_X(401), kChangeSCALE_X(330), kChangeSCALE_X(100));
//    }else{
//        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIFont *cancleFont = [SKCustomFunction SemiboldIPhoneFontWithSize:kChangeSize(32)];;
//        [cancleBtn sk_TitleFont:cancleFont title:@"取消" color:nil];
//        [cancleBtn setBackgroundImage:kImageInstance(@"alert_btn_bac") forState:UIControlStateNormal];
//        [backImg addSubview:cancleBtn];
//
//        [cancleBtn setTitleEdgeInsets:UIEdgeInsetsMake(-kChangeSCALE_X(3), 0, kChangeSCALE_X(4), 0)];
//        cancleBtn.frame = CGRectMake(kChangeSCALE_X(50), kChangeSCALE_X(401), kChangeSCALE_X(300), kChangeSCALE_X(100));
//        confBtn.frame = CGRectMake(kChangeSCALE_X(350), kChangeSCALE_X(401), kChangeSCALE_X(300), kChangeSCALE_X(100));
//
//        [cancleBtn addTarget:cover action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    return nil;
}


- (void)confirmClick{
    [self removeFromSuperview];
    if (self.confirmHandler) {
        self.confirmHandler([[UIAlertAction alloc] init]);
    }
}
- (void)cancleClick{
    [self removeFromSuperview];
    if (self.cancleHandler) {
        self.cancleHandler([[UIAlertAction alloc] init]);
    }
}

@end
