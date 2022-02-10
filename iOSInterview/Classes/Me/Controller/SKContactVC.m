//
//  SKContactVC.m
//  ProjectInit
//
//  Created by Somer.King on 2019/9/2.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKContactVC.h"

@interface SKContactVC ()

@end

@implementation SKContactVC

- (void)phoneClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
//            [SKCustomFunction phoneCallNumber:@"08162964058"];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = @"somerking@foxmail.com";
            kAlertMsg(@"已复制到粘贴板")
        }break;
        case 1:{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = @"somerking";
            kAlertMsg(@"已复制到粘贴板")
        }break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    
    UILabel *titleL = [[UILabel alloc] init];
    [titleL sk_TitleFont:kFontWithSize(16) title:@"邮箱：" color:k3Color];
    [self.sk_view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sk_view).offset(kSCALE_X(40));
//        make.centerX.equalTo(self.sk_view);
        make.left.equalTo(self.sk_view).offset(kSCALE_X(15));
    }];
    
    UIButton *phone1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone1 sk_TitleFont:kFontWithSize(18) title:@"somerking@foxmail.com" color:Color(@"3F4BDD")];
    [self.sk_view addSubview:phone1];
    [phone1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sk_view).offset(kSCALE_X(80));
        make.centerX.equalTo(self.sk_view);
        make.width.mas_equalTo(kSCALE_X(260));
        make.height.mas_equalTo(kSCALE_X(34));
    }];
    phone1.tag = 0;
    
    UILabel *title0L = [[UILabel alloc] init];
    [title0L sk_TitleFont:kFontWithSize(16) title:@"微信：" color:k3Color];
    [self.sk_view addSubview:title0L];
    [title0L mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone1.mas_bottom).offset(kSCALE_X(20));
//        make.centerX.equalTo(self.sk_view);
        make.left.equalTo(self.sk_view).offset(kSCALE_X(15));
    }];
    
    [self.sk_view addSubview:title0L];
    UIButton *phone2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone2 sk_TitleFont:kFontWithSize(18) title:@"somerking" color:Color(@"3F4BDD")];
    [self.sk_view addSubview:phone2];
    [phone2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title0L.mas_bottom)
        .offset(kSCALE_X(10));
        make.centerX.equalTo(self.sk_view);
        make.width.mas_equalTo(kSCALE_X(260));
        make.height.mas_equalTo(kSCALE_X(34));
    }];
    phone2.tag = 1;
    [phone1 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [phone2 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
}

@end
