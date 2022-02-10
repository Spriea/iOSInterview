//
//  SKMineVC.m
//  iOSInterview
//
//  Created by Somer.King on 2021/2/26.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKMineVC.h"
#import <UIButton+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import "SKCallView.h"

static NSArray *viewTypeArr;
#define kUserPosition @"user_position"

@interface SKMineVC ()<UITextFieldDelegate>

//@property (weak, nonatomic) UIButton *loginBtn;
@property (weak, nonatomic) UIButton *headBtn;
@property (weak, nonatomic) UIButton *saveBtn;
@property (weak, nonatomic) UIButton *editBtn;
@property (weak, nonatomic) UIView *redIconV;
@property (strong, nonatomic) NSMutableArray *textArr;
@property (strong, nonatomic) NSMutableArray *labArr;
@property (strong, nonatomic) NSMutableArray *contentArr;

@property (weak, nonatomic) UILabel *nameL;

@property (strong, nonatomic) UIView *cover;

@property (weak, nonatomic) UILabel *badgeL;
@property (assign, nonatomic) NSInteger type;

@end

@implementation SKMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self setHiddenNav];
    
    [self setupChildView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    
    viewTypeArr = [SKCustomFunction getListArr];
}

/** 设置按钮*/
- (void)setingClick:(UIButton *)sender{
    kFeedbackWeekup
    [self pushChildrenViewController:@"SKSettingVC"];
//    if (self.loginBtn.hidden == NO) {
//        [SKCustomFunction jumpToLogin];
//    }else{
//        [self pushChildrenViewController:@"SKSettingVC"];
//    }
}

- (void)loginSuccess{
//    self.loginBtn.hidden = YES;
}
// mydownload
- (void)myDownload:(UIButton *)sender{
    kFeedbackWeekup
    [self pushChildrenViewController:@"SKMyDownloadVC"];
}

/** change headicon*/
- (void)changeHeadicon:(UIButton *)sender{
    kFeedbackWeekup
    [SKCustomFunction sharedManager].delegate = self;
    [[SKCustomFunction sharedManager] photoFromAlbumOrCamera:@"更换头像" isEdit:YES];
}
#pragma -mark 选择照片完毕后调用
- (void)customFunctionDidPickImage:(UIImage *)image{
    [self.headBtn setImage:image forState:UIControlStateNormal];
    [[SDImageCache sharedImageCache] storeImage:image forKey:@"head_icon" toDisk:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag < self.contentArr.count - 1) {
        UITextField *temp = self.textArr[textField.tag+1];
        [temp becomeFirstResponder];
    }else{
        [self.sk_view endEditing:YES];
    }
    return YES;
}

- (void)contactClick{
    [self pushChildrenViewController:@"SKAbaoutUS"];
}

- (void)setupChildView{
    self.sk_view.backgroundColor = kBackColor;
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kSCALE_X(251)+kSafeTop)];
    backImg.userInteractionEnabled = YES;
    backImg.contentMode = UIViewContentModeScaleToFill;
    UIImage *image = kImageInstance(@"head_back");
    backImg.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    backImg.tintColor = kMainColor;
//    backImg.backgroundColor = Color(@"#2D3BA9");
    [self.sk_view addSubview:backImg];
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kNavH)];
//    navView.backgroundColor = Color(@"#2D3BA9");
    [backImg addSubview:navView];
    UIView *stautsV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kStatusH)];
    [navView addSubview:stautsV];
    UIView *navContV = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusH, kScreenW, kNavBarH)];
    [navView addSubview:navContV];
    
    UILabel *navTitleL = [[UILabel alloc] init];
    navTitleL.textAlignment = NSTextAlignmentCenter;
    [navTitleL sk_TitleFont:kMedFontSize(17) title:@"个人中心" color:nil];
    [navContV addSubview:navTitleL];
    [navTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navContV.mas_left).offset(kSCALE_X(15));
        make.centerY.equalTo(navContV.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    
    // header icon
    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSCALE_X(70)+kSafeTop, kSCALE_X(120), kSCALE_X(120))];
    headBtn.sk_centerX = kScreenW * 0.5;
    headBtn.layer.borderWidth = 1;
    headBtn.layer.borderColor = Color(@"#ffffff").CGColor;
    headBtn.layer.cornerRadius = headBtn.sk_width*0.5;
    headBtn.clipsToBounds = YES;
    [backImg addSubview:headBtn];
    headBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [headBtn sd_setImageWithURL:[NSURL URLWithString:@"head_icon"] forState:UIControlStateNormal placeholderImage:kImageInstance(@"default_icon")];
    self.headBtn = headBtn;
    [headBtn addTarget:self action:@selector(changeHeadicon:) forControlEvents:UIControlEventTouchUpInside];
    
    SKUserItem *user = [SKUserItem getUser];
    UILabel *nameL = [[UILabel alloc] init];
    [nameL sk_TitleFont:kMedFontSize(18) title:@"Master" color:nil];
    [backImg addSubview:nameL];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headBtn.mas_bottom).offset(kSCALE_X(16));
        make.centerX.equalTo(headBtn);
    }];
    self.nameL = nameL;
    
    NSString *typeStr = [[NSUserDefaults standardUserDefaults] stringForKey:kUserPosition];
    self.type = [typeStr integerValue];
    nameL.text = [NSString stringWithFormat:@"%@ Master",viewTypeArr[self.type]];
    
    // 个人信息模块
    UIView *personView = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(14), backImg.sk_bottom-kSCALE_X(37), kScreenW-kSCALE_X(14)*2, kSCALE_X(48))];
    personView.backgroundColor = [UIColor whiteColor];
    personView.layer.cornerRadius = kSCALE_X(10);
    [self.sk_view insertSubview:personView belowSubview:backImg];
    personView.hidden = YES;
    
//    NSArray *personContArr = @[NIL2EMPTY(user.contact),[NSString stringWithFormat:@"%@%@",NIL2EMPTY(user.zone),NIL2EMPTY(user.address)]];
//    for (int i = 0; i < personContArr.count ; i ++) {
//        SKImgView *iconImg = [[SKImgView alloc] initWithFrame:CGRectMake(kSCALE_X(27), kSCALE_X(75)+i*kSCALE_X(36), kSCALE_X(20), kSCALE_X(20))];
//        NSString *iconSt = [NSString stringWithFormat:@"person_%d",i];
//        iconImg.image = kImageInstance(iconSt);
//        [personView addSubview:iconImg];
//
//        UILabel *contL = [[UILabel alloc] init];
//        contL.numberOfLines = 0;
//        [contL sk_TitleFont:kFontWithSize(16) title:personContArr[i] color:k18Color];
//        [personView addSubview:contL];
//        [contL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(personView).offset(kSCALE_X(54));
//            make.centerY.equalTo(iconImg);
//            make.right.equalTo(personView).offset(-kSCALE_X(15));
//        }];
//    }
    
    UIView *setView = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(14), personView.sk_bottom+kSCALE_X(8), kScreenW-kSCALE_X(14)*2, kSCALE_X(60)*2)];
    setView.backgroundColor = [UIColor whiteColor];
    setView.layer.cornerRadius = kSCALE_X(10);
    setView.clipsToBounds = YES;
    [self.sk_view addSubview:setView];
    
//    NSArray *titleArr = @[@"赞助支持",@"关于我们",@"设置"];
    NSArray *titleArr = @[@"关于我们",@"设置"];
    
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *cellV = [UIButton buttonWithType:UIButtonTypeCustom];
        cellV.frame = CGRectMake(0, 0+kSCALE_X(60)*i, setView.sk_width, kSCALE_X(60));
        [setView addSubview:cellV];
        if(i == 0){
            [cellV addTarget:self action:@selector(contactClick) forControlEvents:UIControlEventTouchUpInside];
        }else if(i == 1){
            [cellV addTarget:self action:@selector(setingClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        SKImgView *iconImg = [[SKImgView alloc] initWithFrame:CGRectMake(kSCALE_X(27), kSCALE_X(25)+i*kSCALE_X(57), kSCALE_X(20), kSCALE_X(20))];
//        if (i == 0) {
//            iconImg.frame = CGRectMake(kSCALE_X(24.5), kSCALE_X(22.5)+i*kSCALE_X(57), kSCALE_X(25), kSCALE_X(25));
//        }
        iconImg.alpha = 0.6;
        NSString *iconSt = [NSString stringWithFormat:@"set_%d",i];
        iconImg.image = kImageInstance(iconSt);
        [setView addSubview:iconImg];
        
        SKImgView *rightImg = [[SKImgView alloc] init];
        rightImg.image = kImageInstance(@"right_row");
        [setView addSubview:rightImg];
        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cellV).offset(-kSCALE_X(27));
            make.width.mas_equalTo(kSCALE_X(8));
            make.height.mas_equalTo(kSCALE_X(14));
            make.centerY.equalTo(iconImg);
        }];
        
        UILabel *contL = [[UILabel alloc] init];
        contL.numberOfLines = 0;
        [contL sk_TitleFont:kMedFontSize(16) title:titleArr[i] color:kMainColor];
        [setView addSubview:contL];
        [contL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(personView).offset(kSCALE_X(58));
            make.centerY.equalTo(iconImg);
        }];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(27), kSCALE_X(61)+kSCALE_X(60)*i, cellV.sk_width-kSCALE_X(27)*2, 0.5)];
        lineV.backgroundColor = Color(@"#E2E2E2");
        [setView addSubview:lineV];
    }
    
    // logout button
//    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    logoutBtn.frame = CGRectMake(kSCALE_X(38), setView.sk_bottom+kSCALE_X(50), kScreenW-kSCALE_X(38)*2, kSCALE_X(40));
//    [logoutBtn sk_TitleFont:kFontWithSize(15) title:@"注册登录" color:nil];
//    [logoutBtn sk_CornerRadius:kSCALE_X(40)*0.5 borderColor:nil borderWidth:0];
//    logoutBtn.backgroundColor = kMainColor;
//    [self.sk_view addSubview:logoutBtn];
//    [logoutBtn addTarget:self action:@selector(loginOutClick) forControlEvents:UIControlEventTouchUpInside];
//    self.loginBtn = logoutBtn;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *typeStr = [[NSUserDefaults standardUserDefaults] stringForKey:kUserPosition];
    NSInteger type = [typeStr integerValue];
    self.nameL.text = [NSString stringWithFormat:@"%@ Master",viewTypeArr[type]];
    self.type = type;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSuccess" object:nil];
}

- (void)loginOutClick{
    [SKCustomFunction jumpToLogin];
}

@end


