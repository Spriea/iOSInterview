//
//  SKSettingVC.m
//  ProjectInit
//
//  Created by Somer.King on 2019/8/13.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKSettingVC.h"

@interface SKSettingVC ()

@end

@implementation SKSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildView];
    self.title = @"系统设置";
    self.sk_view.backgroundColor = kBackColor;
}

- (void)changePwdClick{
    [self pushChildrenViewController:@"SKChangePwdVC"];
}

- (void)clearMermeary{
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"缓存清除成功！"];
    });
}

/** logout action*/
- (void)loginOutClick{
    [SKCustomFunction alertSheetWithTitle:nil message:@"是否确认退出登录？" confTitle:nil confirmHandler:^(UIAlertAction *action) {
        [SKUserItem saveUser:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD showSuccessWithStatus:@"退出登录成功！"];
    } cancleHandler:^(UIAlertAction *action) {}];
}

- (void)setupChildView{
    UIView *clearV = [[UIView alloc] initWithFrame:CGRectMake(-1, kSCALE_X(15), kScreenW+2, kSCALE_X(40))];
    clearV.backgroundColor = [UIColor whiteColor];
    clearV.layer.borderWidth = 0.5;
    clearV.layer.borderColor = kLineColor.CGColor;
    [self.sk_view addSubview:clearV];
    
    SKImgView *rightImg = [[SKImgView alloc] init];
    rightImg.image = kImageInstance(@"right_row");
    [clearV addSubview:rightImg];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(clearV).offset(-kSCALE_X(27));
        make.width.mas_equalTo(kSCALE_X(8));
        make.height.mas_equalTo(kSCALE_X(14));
        make.centerY.equalTo(clearV);
    }];
    
    UILabel *titleL0 = [[UILabel alloc] initWithFrame:CGRectMake(kSCALE_X(15), 0, kSCALE_X(200), clearV.sk_heigth)];
    [titleL0 sk_TitleFont:kFontWithSize(14) title:@"清除缓存" color:k3Color];
    [clearV addSubview:titleL0];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = clearV.bounds;
    [clearV addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clearMermeary) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *changePwd = [[UIView alloc] initWithFrame:CGRectMake(-1, clearV.sk_bottom, kScreenW+2, kSCALE_X(40))];
//    changePwd.backgroundColor = [UIColor whiteColor];
//    changePwd.layer.borderWidth = 0.5;
//    changePwd.layer.borderColor = kLineColor.CGColor;
//    [self.sk_view addSubview:changePwd];
//    SKImgView *rightImg1 = [[SKImgView alloc] init];
//    rightImg1.image = kImageInstance(@"right_row");
//    [changePwd addSubview:rightImg1];
//    [rightImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(changePwd).offset(-kSCALE_X(27));
//        make.width.mas_equalTo(kSCALE_X(8));
//        make.height.mas_equalTo(kSCALE_X(14));
//        make.centerY.equalTo(changePwd);
//    }];
    
//    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(kSCALE_X(15), 0, kSCALE_X(200), changePwd.sk_heigth)];
//    [titleL sk_TitleFont:kFontWithSize(14) title:@"修改密码" color:k3Color];
//    [changePwd addSubview:titleL];
//    UIButton *changBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    changBtn.frame = changePwd.bounds;
//    [changePwd addSubview:changBtn];
//    [changBtn addTarget:self action:@selector(changePwdClick) forControlEvents:UIControlEventTouchUpInside];
//
//    UILabel *currentL = [[UILabel alloc] init];
//    [currentL sk_TitleFont:kFontWithSize(16) title:[NSString stringWithFormat:@"当前版本号：%@",[SKCustomFunction  getCurrentVersion]] color:kAColor];
//    [self.sk_view addSubview:currentL];
//    [currentL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(changePwd.mas_bottom)
//        .offset(kSCALE_X(22));
//        make.centerX.equalTo(self.sk_view);
//    }];
    
//    // logout button
//    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    logoutBtn.frame = CGRectMake(kSCALE_X(38), changePwd.sk_bottom+kSCALE_X(70), kScreenW-kSCALE_X(38)*2, kSCALE_X(40));
//    [logoutBtn sk_TitleFont:kFontWithSize(15) title:@"退出登录" color:nil];
//    [logoutBtn sk_CornerRadius:kSCALE_X(40)*0.5 borderColor:nil borderWidth:0];
//    logoutBtn.backgroundColor = Color(@"#eb3d3d");
//    [self.sk_view addSubview:logoutBtn];
//    [logoutBtn addTarget:self action:@selector(loginOutClick) forControlEvents:UIControlEventTouchUpInside];
}

@end
