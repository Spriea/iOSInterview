//
//  SKBaseVC.h
//  DMFTCar
//
//  Created by Somer.King on 2017/12/4.
//  Copyright © 2017年 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKBaseVC : UIViewController

@property (nonatomic, strong)id dataObject;  // 数据
@property (nonatomic, strong)id parameterObject;  // 请求参数
@property (nonatomic, strong)id productId;  // id值

@property (assign, nonatomic) BOOL isNotFirst; // 是否是第一次进来
@property (nonatomic, assign) BOOL isNoWrap;

@property (readonly, weak, nonatomic) UIButton *sk_navLeftBtn;
@property (readonly, weak, nonatomic) UIButton *sk_navRightBtn;
@property (readonly, weak, nonatomic) UIView *sk_view;
@property (readonly, weak, nonatomic) UIView *navBarView;

- (void)setHiddenNav;
- (void)setNavBackground:(UIColor *)color;
- (void)setNavClearColor;
- (void)setLeftBtnTitle:(NSString *)title;
- (void)setRightBtnTitle:(NSString *)title;
- (void)setLeftBtnImg:(UIImage *)img;
- (void)setRightBtnImg:(UIImage *)img;
- (void)setRightBtnTitle:(NSString *)title offY:(CGFloat)offY;
- (void)confirm;
- (void)backBtn;

#pragma mark - 网络请求
/**
 POST网络请求无参、无errorBlock
 @param url 网络请求地址
 @param errorDict 请求返回错误列表
 @param hud 是否有加载动画
 */
- (void)requsetURL:(NSString *)url
      successBlock:(SuccessBlock)block
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud;

/**
 POST网络请求无errorBlock
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param errorDict 请求返回错误列表
 @param hud 是否有加载动画
 */
- (void)requsetURL:(NSString *)url
         parameter:(NSDictionary *)parameter
      successBlock:(SuccessBlock)successBlock
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud;

/**
 POST网络请求
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param errorBlock 请求失败调用
 @param errorDict 请求返回错误列表
 @param hud 是否有加载动画
 */
- (void)requsetURL:(NSString *)url
         parameter:(NSDictionary *)parameter
      successBlock:(SuccessBlock)successBlock
        errorBlock:(ErrorCodeBlock)errorBlock
   errorDictionary:(NSDictionary *)errorDict
               HUD:(BOOL)hud;

/**
 GET网络请求
 @param url 网络请求地址
 @param parameter 请求参数
 @param successBlock 请求成功调用
 @param errorBlock 请求失败调用
 @param errorDict 请求返回错误列表
 @param hud 是否有加载动画
 */
- (void)requsetGetURL:(NSString *)url
            parameter:(NSDictionary *)parameter
         successBlock:(SuccessBlock)successBlock
           errorBlock:(ErrorCodeBlock)errorBlock
      errorDictionary:(NSDictionary *)errorDict
                  HUD:(BOOL)hud;

/**
 监测会员次数
 */
- (void)checkBal;

#pragma mark - 跳转控制器相应的方法
/**
 跳转控制器
 @param name 控制器的名称
 */
- (void)pushChildrenViewController:(NSString *)name;

/**
 通过stroyboard的形式跳转控制器
 @param name stroyboard控制器的名称
 */
- (void)pushXIBChildrenViewController:(NSString *)name;

/**
 跳转控制器
 @param name 控制器名称
 @param type 控制器如果有属性，则传入控制器的属性
 */
- (void)pushChildrenViewController:(NSString *)name parameterObject:(id)type;

/**
 跳转控制器
 @param name 控制器名称
 @param type 控制器如果有属性，则传入控制器的属性
 @param dObject 跳转控制器向控制器传递数据
 */
- (void)pushChildrenViewController:(NSString *)name parameterObject:(id)type dataObject:(id)dObject;

/**
 跳转控制器
 @param name 控制器名称
 @param type 控制器如果有属性，则传入控制器的属性
 @param dObject 跳转控制器向控制器传递数据
 @param ID 控制器中可以用到的ID
 */
- (void)pushChildrenViewController:(NSString *)name parameterObject:(id)type dataObject:(id)dObject productId:(id)ID;

/**
 处理列表数据信息
 @param scrollView 加载数据的scrollView
 @param allCount 数据总条数
 @param loadCount 服务器请求一次的数据条数
 @param ListRow 一页多少行
 */
- (void)handleNoData:(UIScrollView *)scrollView allCount:(NSInteger)allCount loadCount:(NSInteger)loadCount listRow:(NSInteger)ListRow;

/**
 显示没有数据
 @param img 没有数据的图片
 @param title 没有数据的文字提示
 */
- (void)showNoDataImage:(UIImage *)img desTitle:(NSString *)title;

/**
 显示没有数据加按钮
 @param img 没有数据的图片
 @param title 没有数据的文字提示
 @param btnTitle 没有数据按钮提示
 */
- (void)showNoDataImage:(UIImage *)img desTitle:(NSString *)title btnTitle:(NSString *)btnTitle;

- (void)showNoDataInView:(UIView *)view;
- (void)dismissNoData;
@end
