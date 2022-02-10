//
//  SKBaseVC.m
//  DMFTCar
//
//  Created by Somer.King on 2017/12/4.
//  Copyright © 2017年 Somer.King. All rights reserved.
//

#import "SKBaseVC.h"
//#import "SKNoMoreDataV.h"

@interface SKBaseVC ()

//@property (nonatomic, strong)id dataObject;
//@property (nonatomic, strong)id parameterObject;
//@property (nonatomic, strong)id productId;

@property (weak, nonatomic) UIButton *sk_navLeftBtn;
@property (weak, nonatomic) UIButton *sk_navRightBtn;
@property (weak, nonatomic) UILabel *navTitleL;

@property (weak, nonatomic) UIView *sk_view;
@property (weak, nonatomic) UIView *navBarView;

@end

@implementation SKBaseVC
@synthesize dataObject;
@synthesize parameterObject;
@synthesize productId;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 自定义导航栏
    [self sk_initNavBar];
}

/** 自定义导航栏*/
- (void)sk_initNavBar{
    UIView *sk_view = [[UIView alloc] initWithFrame:CGRectMake(0, kNavH, kScreenW, kScreenH - kNavH)];
    [self.view addSubview:sk_view];
    self.sk_view = sk_view;
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kNavH)];
    navView.backgroundColor = kMainColor;
//    [navView sk_setBackgroundGradual];
    [self.view addSubview:navView];
    UIView *stautsV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kStatusH)];
    [navView addSubview:stautsV];
    UIView *navContV = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusH, kScreenW, kNavBarH)];
    [navView addSubview:navContV];
    self.navBarView = navContV;
    
    UIButton *sk_leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    sk_leftBtn.backgroundColor = [UIColor redColor];
    [navContV addSubview:sk_leftBtn];
    [sk_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navContV.mas_left);
        make.centerY.equalTo(navContV.mas_centerY);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(40);
    }];
    if (self.navigationController.childViewControllers.count > 1) {
        UIImage *img = [UIImage imageNamed:@"back_btn"];
        [sk_leftBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//        [sk_leftBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    }
    sk_leftBtn.tintColor = alpColor(@"#FFFFFF", 0.9);
    [sk_leftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    self.sk_navLeftBtn = sk_leftBtn;
    
    UIButton *sk_rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navContV addSubview:sk_rightBtn];
    [sk_rightBtn setTitleColor:Color(@"#aaaaaa") forState:UIControlStateHighlighted];
    [sk_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(navContV.mas_right).offset(- 6);
        make.centerY.equalTo(navContV.mas_centerY);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(40);
    }];
    self.sk_navRightBtn = sk_rightBtn;
    [sk_rightBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    //    sk_rightBtn.backgroundColor = [UIColor redColor];
    //    sk_rightBtn.hidden = YES;
    
    UILabel *navTitleL = [[UILabel alloc] init];
    navTitleL.textAlignment = NSTextAlignmentCenter;
    
    [navContV addSubview:navTitleL];
    if (self.navigationController.childViewControllers.count > 1) {
        [navTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(navContV.mas_left).offset(50);
            make.right.equalTo(navContV.mas_right).offset(- kSCALE_X(60));
            make.centerY.equalTo(navContV.mas_centerY);
            make.height.mas_equalTo(44);
        }];
        [navTitleL sk_TitleFont:kMedFontSize(17) title:@"" color:alpColor(@"#FFFFFF", 0.9)];
    }else{
        [navTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(navContV.mas_left).offset(kSCALE_X(15));
            make.centerY.equalTo(navContV.mas_centerY);
            make.height.mas_equalTo(44);
        }];
        [navTitleL sk_TitleFont:kMedFontSize(17) title:@"" color:alpColor(@"#FFFFFF", 0.9)];
    }
    self.navTitleL = navTitleL;
}

- (void)setHiddenNav{
    UIView *tempV = [self.navBarView superview];
    [tempV removeFromSuperview];
//    CALayer *tempLayer = nil;
//    for (CALayer *chid in tempV.layer.sublayers) {
//        if ([chid isKindOfClass:[CAGradientLayer class]]) {
//            tempLayer = chid;
//            break;
//        }
//    }
//    [tempLayer removeFromSuperlayer];
    self.sk_view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
}

- (void)setNavBackground:(UIColor *)color{
    [self.navBarView superview].backgroundColor = color;
}

- (void)setNavClearColor{
    UIView *tempV = [self.navBarView superview];
    tempV.backgroundColor = [UIColor clearColor];
//    CALayer *tempLayer = nil;
//    for (CALayer *chid in tempV.layer.sublayers) {
//        if ([chid isKindOfClass:[CAGradientLayer class]]) {
//            tempLayer = chid;
//        }
//    }
//    [tempLayer removeFromSuperlayer];
    self.sk_view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
}

- (void)setTitle:(NSString *)title{
    self.navTitleL.text = title;
}

- (void)setLeftBtnTitle:(NSString *)title{
    [self.sk_navLeftBtn setImage:nil forState:UIControlStateNormal];
    [self.sk_navLeftBtn.titleLabel setFont:kFontWithSize(17)];
    [self.sk_navLeftBtn setTitle:title forState:UIControlStateNormal];
    [self.sk_navLeftBtn sizeToFit];
    CGFloat with = self.sk_navLeftBtn.sk_width;
    [self.sk_navLeftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navBarView.mas_left).offset(kSCALE_X(13));
        make.centerY.equalTo(self.navBarView.mas_centerY);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(with + kSCALE_X(6));
    }];
    [self.sk_navLeftBtn setTitleColor:alpColor(@"ffffff", 0.4) forState:UIControlStateDisabled];
}

- (void)setRightBtnTitle:(NSString *)title{
    [self setRightBtnTitle:title offY:0];
}

- (void)setRightBtnImg:(UIImage *)img{
    [self.sk_navRightBtn setImage:img forState:UIControlStateNormal];
    self.sk_navRightBtn.hidden = NO;
}

- (void)setLeftBtnImg:(UIImage *)img{
    [self.sk_navLeftBtn setImage:img forState:UIControlStateNormal];
    self.sk_navLeftBtn.hidden = NO;
}

- (void)setRightBtnTitle:(NSString *)title offY:(CGFloat)offY{
    [self.sk_navRightBtn.titleLabel setFont:kMedFontSize(14)];
    self.sk_navRightBtn.hidden = NO;
    [self.sk_navRightBtn setTitle:title forState:UIControlStateNormal];
    [self.sk_navRightBtn sizeToFit];
    CGFloat with = self.sk_navRightBtn.sk_width;
    [self.sk_navRightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBarView.mas_right).offset(- kSCALE_X(5));
        make.centerY.equalTo(self.navBarView.mas_centerY).offset(offY);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(with + kSCALE_X(6));
    }];
    [self.sk_navRightBtn setTitleColor:alpColor(@"ffffff", 0.4) forState:UIControlStateDisabled];
}

- (void)requsetURL:(NSString *)url
      successBlock:(SuccessBlock)successBlock
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud{
    [self requsetURL:url parameter:nil successBlock:successBlock errorDictionary:errorDict HUD:hud];
}

- (void)requsetURL:(NSString *)url
         parameter:(NSDictionary *)parameter
      successBlock:(SuccessBlock)successBlock
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud{
    [self requsetURL:url parameter:parameter successBlock:successBlock errorBlock:nil errorDictionary:errorDict HUD:hud];
}

- (void)requsetURL:(NSString *)url
         parameter:(NSDictionary *)parameter
      successBlock:(SuccessBlock)successBlock
        errorBlock:(ErrorCodeBlock)errorBlock
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud{
    [self requsetURL:url parameter:parameter successBlock:successBlock errorBlock:errorBlock errorDictionary:errorDict HUD:hud requustType:SKRequsetTypePOST];
}

- (void)requsetGetURL:(NSString *)url
            parameter:(NSDictionary *)parameter
         successBlock:(SuccessBlock)successBlock
           errorBlock:(ErrorCodeBlock)errorBlock
      errorDictionary:(NSDictionary *)errorDict
                  HUD:(BOOL)hud{
    [self requsetURL:url parameter:parameter successBlock:successBlock errorBlock:errorBlock errorDictionary:errorDict HUD:hud requustType:SKRequsetTypeGET];
}

- (void)requsetURL:(NSString *)url
         parameter:(NSDictionary *)parameter
      successBlock:(SuccessBlock)successBlock
        errorBlock:(ErrorCodeBlock)errorBlock
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud
       requustType:(SKRequsetType)requsetType{
    [SKHTTPTool requsetWithURL:url parameter:parameter successBlock:^(id returnValue, NSString *errorCode) {
        // 错误信息处理
        if (errorCode) {
            NSInteger code = [errorCode integerValue];
            if (code == 510 || code == 520) {
                
                return;
            }
            if (errorDict == nil) { // 无特殊错误
                return ;
            }
            SKHTTPError *httpError= [SKHTTPError sharedError];
            NSString *str = [httpError errorWithCode:errorCode inErrorDictionary:errorDict];
            if (str.length != 0) {
                [SVProgressHUD showErrorWithStatus:str];
            }
            return ;
        }
        
        // code请求返回成功参数调用
        if(self.isNoWrap)
        {
            successBlock([returnValue objectForKey:@"d"], errorCode);
        }
        else
        {
            successBlock(returnValue, errorCode);
        }
    } errorBlock:errorBlock HUD:hud requustType:requsetType];
}

/**
 点击返回按钮事件
 */
- (void)backBtn {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 点击返回按钮事件
 */
- (void)confirm {}

#pragma mark - 跳转控制器相应的方法
- (void)pushChildrenViewController:(NSString *)name {
    [self pushChildrenViewController:name parameterObject:nil];
}

- (void)pushChildrenViewController:(NSString *)name parameterObject:(id)type {
    [self pushChildrenViewController:name parameterObject:type dataObject:nil];
}

- (void)pushChildrenViewController:(NSString *)name parameterObject:(id)type dataObject:(id)dObject {
    [self pushChildrenViewController:name parameterObject:type dataObject:dObject productId:nil];
    
}

- (void)pushChildrenViewController:(NSString *)name parameterObject:(id)type dataObject:(id)dObject productId:(id)ID {
    id controller = [[NSClassFromString(name) alloc] init];
    if(controller) {
        if(type) {
            ((SKBaseVC *)controller).parameterObject = type;
        }
        if(dObject) {
            ((SKBaseVC *)controller).dataObject = dObject;
        }
        if (ID) {
            ((SKBaseVC *)controller).productId = ID;
        }
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)pushXIBChildrenViewController:(NSString *)name {
    UIStoryboard *story = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *vc = story.instantiateInitialViewController;
    [self.navigationController pushViewController:vc animated:YES];
}

// 没有数据处理
- (void)handleNoData:(UIScrollView *)scrollView allCount:(NSInteger)allCount loadCount:(NSInteger)loadCount listRow:(NSInteger)ListRow{
    //    scrollView.addSubview(self.noMoreDataV)
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scrollView.mj_footer setHidden:NO];
        [scrollView.mj_header endRefreshing];
        if (loadCount == 0){
            if (allCount != 0) {
                [scrollView.mj_footer endRefreshingWithNoMoreData];
            }else{  // 没有数据，隐藏
                [scrollView.mj_footer setHidden:YES];
            }
        }else{
            if (loadCount < ListRow) {
                if (scrollView.contentSize.height <= scrollView.sk_heigth - kNavH ){ // 数据小于一页，隐藏
                    [scrollView.mj_footer setHidden:YES];
                }else{
                    [scrollView.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [scrollView.mj_footer endRefreshing];
            }
        }
    });
//    if (allCount == 0){
////        if (self.noMoreData.hasInfo) {  // 设置了信息的情况
////            [scrollView addSubview:self.noMoreData];
////            self.noMoreData.hidden = NO;
////        }
//                [scrollView.mj_footer setHidden:YES];
//    }else{
////        if (self.noMoreData.hasInfo) { // 设置了信息的情况
////            self.noMoreData.hidden = YES;
////        }
//                [scrollView.mj_footer setHidden:NO];
//    }
}

//- (void)showNoDataImage:(UIImage *)img desTitle:(NSString *)title{
//    [self.noMoreData showNoDataImage:img desTitle:title btnTitle:nil];
//    self.noMoreData.hidden = YES;
//}
//
//- (void)showNoDataImage:(UIImage *)img desTitle:(NSString *)title btnTitle:(NSString *)btnTitle{
//    [self.noMoreData showNoDataImage:img desTitle:title btnTitle:btnTitle];
//    self.noMoreData.hidden = YES;
//}
//
//- (void)showNoDataInView:(UIView *)view{
//    [view addSubview:self.noMoreData];
//    self.noMoreData.hidden = NO;
//}

//- (void)dismissNoData{
//    [self.noMoreData removeFromSuperview];
//    self.noMoreData.hidden = YES;
//}

// 点击按钮时调用，需要用时继承
//- (void)noMoreDataVClickRefresh:(SKNoMoreDataV *)noMoreDataV{
//
//}

#pragma mark 懒加载
//- (SKNoMoreDataV *)noMoreData{
//    if (!_noMoreData) {
//        SKNoMoreDataV *noMore = [SKNoMoreDataV noMoreDataV];
//        noMore.frame = CGRectMake(0, 0, kScreenW, kScreenH - kNavH);
//        noMore.delegate = self;
//        _noMoreData = noMore;
//    }
//    return _noMoreData;
//}

- (void)dealloc{
    SKLog(@"控制器被销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

@end
