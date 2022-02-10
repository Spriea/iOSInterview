//
//  SKFindPwdVC.m
//  records_ios
//
//  Created by Somer.King on 2019/4/12.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKFindPwdVC.h"

@interface SKFindPwdVC ()

@property (strong, nonatomic) UIView *hudView;
@property (strong, nonatomic) NSMutableArray *textArr;

@end

@implementation SKFindPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    [self setupChildView];
}

- (void)confirmClick{
    UITextField *textF0 = self.textArr[0];
    UITextField *textF1 = self.textArr[1];
    UITextField *textF2 = self.textArr[2];
    
    textF0.text = [textF0.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (textF0.text.length == 0) {
        kAlertMsg(@"请输入手机号码")
        return;
    }else{
        if (![SKHTTPTool isMobileNumber:textF0.text]) {
            kAlertMsg(@"手机号码错误")
            return;
        }
    }
    
    if (textF1.text.length == 0) {
        kAlertMsg(@"请填写新密码")
        return;
    }
    if (textF2.text.length == 0) {
        kAlertMsg(@"请再次填写新密码")
        return;
    }
    
    if (![textF1.text isEqualToString:textF2.text]) {
        self.hudView.hidden = NO;
        return;
    }else{
        self.hudView.hidden = YES;
    }
    
    [SVProgressHUD show];
    kWEAK_SELF(weakS)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SKUserItem saveUser:[SKUserItem new]];
        [[NSUserDefaults standardUserDefaults] setObject:textF0.text forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:textF1.text forKey:kUserPassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"密码重置成功！"];
        [weakS.navigationController popViewControllerAnimated:YES];
    });
    
//    [self requsetURL:@"index.php/home/member/forgot" parameter:@{@"sms_code":textF1.text,@"username":textF0.text,@"password":textF2.text} successBlock:^(id returnValue, NSString *errorCode) {
//        [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
//        [self.navigationController popViewControllerAnimated:YES];
//    } errorDictionary:nil HUD:YES];
}

- (void)setupChildView{
    UIView *contV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(28), kSCALE_X(14), kSCALE_X(319), kSCALE_X(200))];
    contV.backgroundColor = [UIColor whiteColor];
    contV.layer.shadowColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:0.25].CGColor;
    contV.layer.shadowOffset = CGSizeMake(kSCALE_X(2),kSCALE_X(1));
    contV.layer.shadowOpacity = kSCALE_X(1);
    contV.layer.shadowRadius = kSCALE_X(8);
    contV.layer.cornerRadius = kSCALE_X(10);
    [self.sk_view addSubview:contV];
    
    NSArray *plaArr = @[@"手机号",@"新密码",@"确认新密码"];
    for (int i = 0; i < plaArr.count; i ++) {
        UIView *cellC = [[UIView alloc] initWithFrame:CGRectMake(0, kSCALE_X(5)+kSCALE_X(50)*i, contV.sk_width, kSCALE_X(50))];
        [contV addSubview:cellC];
        
        UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(kSCALE_X(26), kSCALE_X(14), kSCALE_X(267), kSCALE_X(36))];
        
        textF.font = kFontWithSize(17);
        textF.textColor = k3Color;
        textF.placeholder = plaArr[i];
        textF.delegate = self;
        textF.tag = i;
        [cellC addSubview:textF];
        [self.textArr addObject:textF];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(26), cellC.sk_heigth-kSCALE_X(0.3), kSCALE_X(267), kSCALE_X(0.3))];
        lineV.backgroundColor = Color(@"#E2E2E2");
        [cellC addSubview:lineV];
        
        if (i == 0) {
            textF.keyboardType = UIKeyboardTypePhonePad;
        }
        
        if (i != plaArr.count-1) {
            textF.returnKeyType = UIReturnKeyNext;
        }else{
            textF.returnKeyType = UIReturnKeyDone;
        }
        
        if (i == 1 || i == 2) {
            textF.secureTextEntry = YES;
        }
        
        if (i == 2){
            UIView *hudView = [[UIView alloc] init];
            [cellC addSubview:hudView];
            [hudView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cellC).offset(kSCALE_X(-12));
                make.top.bottom.equalTo(cellC);
                make.width.mas_equalTo(kSCALE_X(120));
            }];
            self.hudView = hudView;
            hudView.hidden = YES;
            
            UILabel *hudL = [[UILabel alloc] init];
            [hudL sk_TitleFont:kFontWithSize(12) title:@"两次密码填写不一致" color:Color(@"#f9a400")];
            [hudView addSubview:hudL];
            [hudL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(hudView);
                make.centerY.equalTo(hudView);
            }];
            
            SKImgView *icImg = [[SKImgView alloc] init];
            icImg.image = kImageInstance(@"hud_find");
            [hudView addSubview:icImg];
            [icImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(hudL.mas_left).offset(-kSCALE_X(5));
                make.centerY.equalTo(hudL);
                make.width.height.mas_equalTo(kSCALE_X(13));
            }];
        }
    }
    // confirm btn
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn sk_TitleFont:kFontWithSize(17) title:@"确定" color:nil];
    confirmBtn.backgroundColor = kMainColor;
    [confirmBtn sk_CornerRadius:kSCALE_X(10) borderColor:nil borderWidth:0];
    confirmBtn.frame = CGRectMake(0, contV.sk_bottom-kSCALE_X(22), kSCALE_X(267), kSCALE_X(50));
    confirmBtn.sk_centerX = kScreenW*0.5;
    [self.sk_view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag < self.textArr.count-1) {
        UITextField *temp = self.textArr[textField.tag+1];
        [temp becomeFirstResponder];
    }else{
        [self confirmClick];
    }
    return YES;
}

- (NSMutableArray *)textArr{
    if (!_textArr) {
        _textArr = [NSMutableArray array];
    }
    return _textArr;
}

@end
