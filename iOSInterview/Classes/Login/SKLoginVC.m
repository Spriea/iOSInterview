//
//  SKLoginVC.m
//  records_ios
//
//  Created by Somer.King on 2019/4/12.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKLoginVC.h"
#import "SKMainTabVC.h"
#import "SKBaseNav.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "EKWKWebview.h"

@interface SKLoginVC ()

@property (weak, nonatomic) UITextField *accountText;
@property (weak, nonatomic) UITextField *passwordText;
@property (weak, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) UIButton *agreeBtn;

/**动画*/
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
//登录时加一个看不见的蒙版，让控件不能再被点击
@property (nonatomic,strong) UIView *HUDView;
//执行登录按钮动画的view (动画效果不是按钮本身，而是这个view)
@property (nonatomic,strong) UIView *LoginAnimView;

@end

@implementation SKLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHiddenNav];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setupChildView];
}

/**
 点击按钮登录按钮
 */
- (void)loginClick{
    [self.sk_view endEditing:YES];
    
//    if (!self.agreeBtn.selected) {
//        [SVProgressHUD showErrorWithStatus:@"需要同意《用户协议》才能登录"];
//        return;
//    }
//
//    self.accountText.text = [self.accountText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    if (self.accountText.text.length == 0) {
//        kAlertMsg(@"请输入手机号码")
//        return;
//    }else{
//        if (![SKHTTPTool isMobileNumber:self.accountText.text]) {
//            kAlertMsg(@"手机号码错误")
//            return;
//        }
//    }
//    if (self.passwordText.text.length == 0) {
//        kAlertMsg(@"请输入密码")
//        return;
//    }
    
    [self loginBegainAnimation];
    SKUserItem *user = [SKUserItem getUser];
    if (user == nil) {
        [self loginApp:YES];
    }
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
    if ([_accountText.text isEqualToString:userName] && [_passwordText.text isEqualToString:pwd]) {
        [self loginApp:YES];
    }else{
        [self loginApp:NO];
    }
}

- (void)loginApp:(BOOL)hud{
//    [SVProgressHUD showWithStatus:@"登录中..."];
    kWEAK_SELF(weakS)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (hud) {
            [SKUserItem saveUser:[SKUserItem new]];
            [[NSUserDefaults standardUserDefaults] setObject:weakS.accountText.text forKey:kUserName];
            [[NSUserDefaults standardUserDefaults] setObject:weakS.passwordText.text forKey:kUserPassword];
            [[NSUserDefaults standardUserDefaults] synchronize];
//            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [weakS dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
        }else{
//            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"用户名或密码错误！"];
        }
        [self loginEndAnimation];
    });
}

- (void)loginBegainAnimation{
    //HUDView，盖住view，以屏蔽掉点击事件
    self.HUDView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.HUDView];
    self.HUDView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    //执行登录按钮转圈动画的view
    self.LoginAnimView = [[UIView alloc] initWithFrame:self.loginBtn.frame];
    self.LoginAnimView.layer.cornerRadius = 10;
    self.LoginAnimView.layer.masksToBounds = YES;
    self.LoginAnimView.frame = self.loginBtn.frame;
    self.LoginAnimView.backgroundColor = self.loginBtn.backgroundColor;
    [self.view addSubview:self.LoginAnimView];
    self.loginBtn.hidden = YES;
    
    //把view从宽的样子变圆
    CGPoint centerPoint = self.LoginAnimView.center;
    CGFloat radius = MIN(self.loginBtn.frame.size.width, self.loginBtn.frame.size.height);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.LoginAnimView.frame = CGRectMake(0, 0, radius, radius);
        self.LoginAnimView.center = centerPoint;
        self.LoginAnimView.layer.cornerRadius = radius/2;
        self.LoginAnimView.layer.masksToBounds = YES;
        
    }completion:^(BOOL finished) {
        
        //给圆加一条不封闭的白色曲线
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path addArcWithCenter:CGPointMake(radius/2, radius/2) radius:(radius/2 - 5) startAngle:0 endAngle:M_PI_2 * 2 clockwise:YES];
        self.shapeLayer = [[CAShapeLayer alloc] init];
        self.shapeLayer.lineWidth = 1.5;
        self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.fillColor = self.loginBtn.backgroundColor.CGColor;
        self.shapeLayer.frame = CGRectMake(0, 0, radius, radius);
        self.shapeLayer.path = path.CGPath;
        [self.LoginAnimView.layer addSublayer:self.shapeLayer];
        
        //让圆转圈，实现"加载中"的效果
        CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        baseAnimation.duration = 0.4;
        baseAnimation.fromValue = @(0);
        baseAnimation.toValue = @(2 * M_PI);
        baseAnimation.repeatCount = MAXFLOAT;
        [self.LoginAnimView.layer addAnimation:baseAnimation forKey:nil];
    }];
}

- (void)loginEndAnimation{
    //把蒙版、动画view等隐藏，把真正的login按钮显示出来
    self.loginBtn.hidden = NO;
    [self.HUDView removeFromSuperview];
    [self.LoginAnimView removeFromSuperview];
    [self.LoginAnimView.layer removeAllAnimations];
    
    //给按钮添加左右摆动的效果(路径动画)
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.LoginAnimView.layer.position;
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    [self.loginBtn.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
}
/**
 点击忘记密码
 */
- (void)forgetBtnClick{
    [self pushChildrenViewController:@"SKFindPwdVC"];
}

/**
 注册账号
 */
- (void)registerBtnClick{
    [self pushChildrenViewController:@"SKRegisterDetailVC"];
}

/** 显示或不显示密码*/
- (void)lookOrNo:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    self.passwordText.secureTextEntry = !sender.isSelected;
}

- (void)setupChildView{
    
    UIImageView *headB = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kSCALE_X(333))];
    [headB addRoundedCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight withRadii:CGSizeMake(kSCALE_X(25), kSCALE_X(25))];
    headB.backgroundColor = kMainColor;
    [self.sk_view addSubview:headB];
    
    // title lable
    UILabel *titleL = [[UILabel alloc] init];
    [titleL sk_TitleFont:kMedFontSize(36) title:@"建材商城" color:nil];
    [self.sk_view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sk_view).offset(kSCALE_X(109));
        make.centerX.equalTo(self.sk_view.mas_centerX);
    }];
    
    UIView *inputCV = [[UIView alloc] initWithFrame:CGRectMake(0, kSCALE_X(179), kSCALE_X(319), kSCALE_X(253))];
    inputCV.backgroundColor = [UIColor whiteColor];
    inputCV.layer.cornerRadius = kSCALE_X(10);
    inputCV.layer.shadowColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:0.25].CGColor;
    inputCV.layer.shadowOffset = CGSizeMake(kSCALE_X(2),kSCALE_X(1));
    inputCV.layer.shadowOpacity = kSCALE_X(1);
    inputCV.layer.shadowRadius = kSCALE_X(8);
    inputCV.sk_centerX = kScreenW*0.5;
    
    // 动画
    CAKeyframeAnimation *inputAni = [CAKeyframeAnimation animation];
    NSValue *v0 = [NSValue valueWithCGPoint:CGPointMake(kScreenW*0.5, kScreenH+inputCV.sk_heigth*0.5)];

    NSValue *v3 = [NSValue valueWithCGPoint:inputCV.layer.position];
    inputAni.keyPath = @"position";
    inputAni.values = @[v0,v3];
    inputAni.duration = 0.5;
    [inputCV.layer addAnimation:inputAni forKey:@"input"];
    
    [self.sk_view addSubview:inputCV];
    
    // input text
    NSArray *iconIA = @[@"account",@"password"];
    NSArray *plaA = @[@"请输入手机号",@"请输入密码"];
    NSArray *plaCont = @[@"test",@"test"];
    for (int i = 0; i < 2; i ++) {
        UIView *contV = [[UIView alloc] initWithFrame:CGRectMake(0, kSCALE_X(7)+kSCALE_X(76)*i, kScreenW, kSCALE_X(76))];
        [inputCV addSubview:contV];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kSCALE_X(26), kSCALE_X(50), kSCALE_X(18), kSCALE_X(18))];
        icon.image = kImageInstance(iconIA[i]);
        [contV addSubview:icon];
        
        UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(kSCALE_X(60), kSCALE_X(41), kSCALE_X(267), kSCALE_X(36))];
        textF.font = kFontWithSize(17);
        textF.textColor = k3Color;
        textF.placeholder = plaA[i];
        textF.delegate = self;
        textF.tag = i;
        [contV addSubview:textF];
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(26), kSCALE_X(83), kSCALE_X(267), kSCALE_X(0.3))];
        lineV.backgroundColor = Color(@"#E2E2E2");
        [contV addSubview:lineV];
        
        if (i == 1) {
            textF.secureTextEntry = YES;
            textF.returnKeyType = UIReturnKeyDone;
            self.passwordText = textF;
            NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
            textF.text = NIL2EMPTY(password);
        }else{
            textF.keyboardType = UIKeyboardTypePhonePad;
            textF.returnKeyType = UIReturnKeyNext;
            self.accountText = textF;
            NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
            textF.text = NIL2EMPTY(account);
        }
        textF.text = plaCont[i];
    }
    
    UILabel *lowL = [[UILabel alloc] init];
    [lowL sk_TitleFont:kFontWithSize(14) title:@"" color:Color(@"#A2A2A2")];
    [self.sk_view addSubview:lowL];
    [lowL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sk_view.mas_bottom)
        .offset(-(kSCALE_X(100)+kSafeBottom));
        make.centerX.equalTo(self.sk_view).offset(kSCALE_X(13));
    }];
    lowL.attributedText = [@"需要同意《用户协议》才能登录" masString:@"《用户协议》" lineSpace:0 withColor:Color(@"#8795C0") withFont:kFontWithSize(14)];
    lowL.userInteractionEnabled = YES;
    lowL.enabledTapEffect = NO;
    lowL.textAlignment = NSTextAlignmentJustified;
    kWEAK_SELF(weakS)
    [lowL yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(7, 6))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        kFeedbackWeekup
        
//        EKWKWebview *webV = [[EKWKWebview alloc] init];
//        webV.webHtmlUrl = [@"https://www.yuque.com/docs/share/5bc7aa6e-af1c-4279-989f-0af1b1d4b9d0?# 《用户协议》" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        SKBaseNav *nav = [[SKBaseNav alloc] initWithRootViewController:webV];
//        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [weakS.navigationController pushViewController:webV animated:YES];
    }];
    SQButton *btnAgree = [SQButton buttonWithType:UIButtonTypeCustom];
    [self.sk_view addSubview:btnAgree];
    [btnAgree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lowL.mas_left);
        make.centerY.equalTo(lowL);
        make.width.height.mas_equalTo(kSCALE_X(37));
    }];
    btnAgree.contentEdgeInsets = UIEdgeInsetsMake(kSCALE_X(10), kSCALE_X(10), kSCALE_X(10), kSCALE_X(10));
    [btnAgree setImage:kImageInstance(@"login_nor") forState:UIControlStateNormal];
    [btnAgree setImage:kImageInstance(@"login_sel") forState:UIControlStateSelected];
    self.agreeBtn = btnAgree;
    [btnAgree addTarget:self action:@selector(agreeJuge:) forControlEvents:UIControlEventTouchUpInside];
    
    // register
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn sk_TitleFont:kFontWithSize(16) title:@"快速注册 →" color:kMainColor];
    [self.sk_view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sk_view.mas_bottom)
        .offset(-(kSCALE_X(61)+kSafeBottom));
        make.centerX.equalTo(self.sk_view);
    }];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // forget password
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn sk_TitleFont:kFontWithSize(14) title:@"忘记密码？" color:Color(@"#666666")];
    [inputCV addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputCV).offset(kSCALE_X(193));
        make.right.equalTo(inputCV).offset(-kSCALE_X(18));
    }];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 登录按钮
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login sk_CornerRadius:kSCALE_X(10) borderColor:nil borderWidth:0];
    login.frame = CGRectMake(0, kSCALE_X(407), kSCALE_X(267), kSCALE_X(50));
    login.sk_centerX = kScreenW*0.5;
//    [login sk_setBackgroundGradual];
    [login sk_TitleFont:kMedFontSize(17) title:@"登录" color:nil];
    [login addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    
    CAKeyframeAnimation *loginAni = [CAKeyframeAnimation animation];
    NSValue *lv0 = [NSValue valueWithCGPoint:CGPointMake(kScreenW*0.5, kScreenH+login.sk_heigth*0.5)];
    NSValue *lv3 = [NSValue valueWithCGPoint:login.layer.position];
    loginAni.keyPath = @"position";
    loginAni.values = @[lv0,lv0,lv3];
    loginAni.duration = 0.75;
    [login.layer addAnimation:loginAni forKey:@"login"];
    [self.sk_view addSubview:login];
    login.backgroundColor = kMainColor;
    self.loginBtn = login;
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, kStatusH, kSCALE_X(50), kSCALE_X(50));
//    backBtn.contentEdgeInsets = UIEdgeInsetsMake(kSCALE_X(15), kSCALE_X(15), kSCALE_X(15), kSCALE_X(15));
//    [backBtn setImage:kImageInstance(@"loginBack") forState:UIControlStateNormal];
//    [self.sk_view addSubview:backBtn];
//    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)agreeJuge:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (NSMutableAttributedString *)masString:(NSString *)string lineSpace:(CGFloat)lineSpace withColor:(UIColor *)color withFont:(UIFont *)font{
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange rangel = [[textColor string] rangeOfString:string];
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:rangel];
    [textColor addAttribute:NSFontAttributeName value:font range:rangel];
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    [textColor addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[[textColor string] rangeOfString:self]];
    
    return textColor;
}
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 0) {
        [self.passwordText becomeFirstResponder];
    }else{
        [self loginClick];
    }
    return YES;
}

@end
