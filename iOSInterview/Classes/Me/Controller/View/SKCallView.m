//
//  SKCallView.m
//  ProjectInit
//
//  Created by Pcea on 2019/9/27.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKCallView.h"

@implementation SKCallView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
    }
    return self;
}

- (void)showCallView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)closeClick{
    [self dismissCallView];
}

- (void)dismissCallView{
    [self removeFromSuperview];
}

- (void)phoneClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
            NSString *str=[NSString stringWithFormat:@"tel://%@",@"15555540292"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }break;
        case 1:{
//            [SKCustomFunction phoneCallNumber:@"08162377777"];
            kAlertMsg(@"已复制到剪贴板！")
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = @"279208070@qq.com";
        }break;
        default:
            break;
    }
}

- (void)setupChildView{
    self.backgroundColor = alpColor(@"#000000", 0.6);
    UIView *contenV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCALE_X(267), kSCALE_X(220))];
    contenV.backgroundColor = [UIColor whiteColor];
    contenV.layer.cornerRadius = kSCALE_X(10);
    [self addSubview:contenV];
    contenV.center = CGPointMake(kScreenW*0.5, kScreenH*0.5+kSCALE_X(14));
    
    SKImgView *iconImg = [[SKImgView alloc] initWithFrame:CGRectMake(contenV.sk_x-kSCALE_X(3), contenV.sk_y-kSCALE_X(24), kSCALE_X(67), kSCALE_X(67))];
    iconImg.image = kImageInstance(@"contact_us");
    [self addSubview:iconImg];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake(contenV.sk_right-kSCALE_X(35), contenV.sk_y-kSCALE_X(28), kSCALE_X(33), kSCALE_X(33));
    close.contentEdgeInsets = UIEdgeInsetsMake(kSCALE_X(10), kSCALE_X(10), kSCALE_X(10), kSCALE_X(10));
    [close setImage:kImageInstance(@"close_contact") forState:UIControlStateNormal];
    [self addSubview:close];
    [close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleL = [[UILabel alloc] init];
    [titleL sk_TitleFont:kFontWithSize(17) title:@"客服电话" color:Color(@"#3F4BDD")];
    [contenV addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contenV).offset(kSCALE_X(18));
        make.centerX.equalTo(contenV);
    }];
    
    UIButton *phone1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone1 sk_TitleFont:kFontWithSize(19) title:@"13608118885" color:Color(@"#222222")];
    [contenV addSubview:phone1];
    [phone1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(contenV).offset(kSCALE_X(45));
        make.top.equalTo(titleL.mas_bottom)
        .offset(kSCALE_X(12));
        //        make.left.equalTo(self.sk_view).offset(kSCALE_X(15));
        make.centerX.equalTo(contenV);
        make.width.mas_equalTo(kSCALE_X(260));
        make.height.mas_equalTo(kSCALE_X(34));
    }];
    phone1.tag = 0;
    
    UILabel *addL = [[UILabel alloc] init];
    [addL sk_TitleFont:kFontWithSize(17) title:@"客服邮箱" color:Color(@"#3F4BDD")];
    [contenV addSubview:addL];
    [addL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contenV).offset(kSCALE_X(125));
        make.centerX.equalTo(contenV);
    }];
    
    UIButton *phone2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone2 sk_TitleFont:kFontWithSize(19) title:@"279208070@qq.com" color:Color(@"#222222")];
    [contenV addSubview:phone2];
    [phone2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addL.mas_bottom)
        .offset(kSCALE_X(12));
        //        make.left.equalTo(self.sk_view).offset(kSCALE_X(15));
        make.centerX.equalTo(contenV);
        make.width.mas_equalTo(kSCALE_X(260));
        make.height.mas_equalTo(kSCALE_X(34));
    }];
    phone2.tag = 1;
    [phone1 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [phone2 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
}

@end
