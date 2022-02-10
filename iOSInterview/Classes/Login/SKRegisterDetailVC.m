//
//  SKRegisterDetailVC.m
//  bs_custom
//
//  Created by Somer.King on 2019/8/11.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKRegisterDetailVC.h"

@interface SKRegisterDetailVC ()

@property (strong, nonatomic) NSMutableArray *textArr;

@end

@implementation SKRegisterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildView];
}

- (void)registerClick{
    UITextField *textF0 = self.textArr[0];
    UITextField *textF1 = self.textArr[1];
    UITextField *textF2 = self.textArr[2];
    
    if (textF0.text.length == 0 || textF1.text.length == 0
        || textF2.text.length == 0) {
        kAlertMsg(@"请将注册信息填写完整！");
        return;
    }
    if (![textF1.text isEqualToString:textF2.text]) {
        kAlertMsg(@"两次输入密码不一致！");
        return;
    }
    
    [SVProgressHUD show];
    kWEAK_SELF(weakS)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SKUserItem saveUser:[SKUserItem new]];
        [[NSUserDefaults standardUserDefaults] setObject:textF0.text forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:textF1.text forKey:kUserPassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        [weakS.navigationController popViewControllerAnimated:YES];
    });
    
    
}


- (void)setupChildView{
    NSArray *perArr;
    self.title = @"用户注册";
    perArr = @[@"手机号",@"设置密码",@"重新输入密码"];
    
    self.textArr = [NSMutableArray array];
    for (int i = 0; i < perArr.count; i ++) {
        UIView *cellV = [[UIView alloc] initWithFrame:CGRectMake(0,kSCALE_X(40) + i * kSCALE_X(50), kScreenW, kSCALE_X(50))];
        [self.sk_view addSubview:cellV];
        UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(kSCALE_X(15), 0, kScreenW-kSCALE_X(30), cellV.sk_heigth)];
        textF.placeholder = perArr[i];
        textF.font = kFontWithSize(14);
        textF.textColor = k3Color;
        textF.delegate = self;
        textF.tag = i;
        if (i == perArr.count - 1) {
            textF.returnKeyType = UIReturnKeyDone;
        }else{
            textF.returnKeyType = UIReturnKeyNext;
        }
        
        if (i == perArr.count-1 || i == perArr.count-2) {
            textF.secureTextEntry = YES;
        }
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(10), cellV.sk_heigth-1, kScreenW-kSCALE_X(20), 1)];
        lineV.backgroundColor = kLineColor;
        [cellV addSubview:lineV];
        [cellV addSubview:textF];
        [self.textArr addObject:textF];
    }
    
    // 确认
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login sk_CornerRadius:kSCALE_X(22) borderColor:nil borderWidth:0];
    login.frame = CGRectMake(0, kSCALE_X(50)*7+kSCALE_X(70), kSCALE_X(300), kSCALE_X(44));
    login.sk_centerX = kScreenW*0.5;
    login.backgroundColor = kMainColor;
//    [login sk_setBackgroundGradual];
    [login sk_TitleFont:kFontWithSize(18) title:@"点击注册" color:nil];
    [login addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sk_view addSubview:login];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag < self.textArr.count-1) {
        UITextField *textF = self.textArr[textField.tag+1];
        [textF becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

@end
