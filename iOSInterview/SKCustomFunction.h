//
//  SKCustomFunction.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol SKCustomFunctionDelegate <NSObject>

@optional
- (void)customFunctionDidPickImage:(UIImage *)image;

@end

@interface SKCustomFunction : NSObject

@property (weak, nonatomic) id <SKCustomFunctionDelegate>delegate;

+ (instancetype)sharedManager;

/**
 获取当前设备
 */
+ (NSString*)getDeviceVersion;

+ (NSString *)getCurrentVersion;

// 传入控制器实现按钮的监听动作
+ (UIBarButtonItem *)barItemWithTarget:(UIViewController *)vc img:(NSString *)img imgHeigth:(NSString *)imgHeigth action:(SEL)sel;

// 按钮倒计时
+ (void)authCodeTimerWithButton:(UIButton *)authCodeBtn;

// 跳转登录界面
+ (void)jumpToLogin;

/**
 根据编码获取对应语言文字
 @param code 语言编码
 @param languages 语言文字及语言编码  数组中第一个为“语言文字” 数组中第二个为“语言编码”
 @return 语言文字
 */
+ (NSString *)getStringWithCode:(NSString *)code inArray:(NSArray *)languages;

/**
 根据语言文字获取对应编码
 @param code 语言文字
 @param languages 语言文字及语言编码  数组中第一个为“语言文字” 数组中第二个为“语言编码”
 @return 语言编码
 */
+ (NSString *)getCodeWithString:(NSString *)code inArray:(NSArray *)languages;

/**
 压缩图片
 @param image 原始图片
 @param newSize 图片尺寸
 @return 压缩后的图片
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 压缩图片
 @param image 原始图片
 @return 压缩后的图片
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image;

/**
  弹出信息提示
 @param title 标题
 @param message 描述信息
 @param btnTitle 确认按钮的标题
 @param confirmHandler 点击确认回调,nil则不显示按钮
 @param cancleHandler 点击取消回调,nil则不显示按钮
 */
+ (void)alertSheetWithTitle:(NSString *)title message:(NSString *)message confTitle:(NSString *)btnTitle confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancleHandler:(void (^)(UIAlertAction *action))cancleHandler;
/**
 设置消息个数
 @param count 当前消息个数
 */
+ (void)setTabarBadge:(NSInteger)index count:(NSInteger)count;

/**
 添加消息
 @param count 需要添加消息个数
 */
+ (void)checkTabarBadge:(NSInteger)index count:(NSInteger)count;

/**
 给tabbar增加红点
 @param index 第几个tabbar
 */
+ (void)addTabarCount:(NSInteger)index;
/**
 给tabbar增加红点
 @param index 第几个tabbar
 @param count 多少个
 */
+ (void)addTabarCount:(NSInteger)index count:(NSInteger)count;

/**
 获取当前时区
 @return 返回当前时区
 */
+ (NSInteger)getCurrentTimeZone;

/**
 保存图片到相册
 @param img 图片
 */
- (void)saveToAlbumImage:(UIImage *)img;

/**
 从系统相册或相机获取照片
 @param title alertsheet的标题
 @param edit 选择图片是否可编辑
 */
- (void)photoFromAlbumOrCamera:(NSString *)title isEdit:(BOOL)edit;


/**
 浏览显示单张图片
 @param supView 图片父控件
 @param imgView 图片控件
 @param img 图片
 */
+ (void)showImageBrowser:(UIView *)supView imgView:(UIView *)imgView img:(UIImage *)img;


/**
 浏览显示多张图片
 @param supViews 父控件数组
 @param imgViews 图片控件数组
 @param imgs 图片数组
 @param tag 显示第几张
 */
+ (void)showAlbumImgsAt:(NSArray *)supViews imgViews:(NSArray *)imgViews imgs:(NSArray *)imgs selectTag:(NSInteger)tag;

/**
 collectionView中显示浏览图片
 @param collectionView collectionView
 @param imgs 图片数组
 @param indexPath cell索引
 @param identifier cell重用标识
 */
+ (void)showAlbumImgsAt:(UICollectionView *)collectionView imgs:(NSArray *)imgs indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;


+ (NSString *)dollerConvert:(NSString *)doller;

/**
 对比两个时间差十分小于 60s
 @param dt 后一个时间
 @param last_dt 前一个时间
 @return bool值
 */
+ (BOOL)compareTime:(NSString *)dt last_dt:(NSString *)last_dt;

/** 检查相机访问权限*/
+ (void)checkCameraAuth:(void(^)(void))checkSuccess;

+ (void)checkPhotoAuth:(void(^)(void))checkSuccess;

/**
 用第三方地图来导航
 @param destination 需要到达的目的
 */
+ (void)jumpToNavigation:(CLLocationCoordinate2D)destination;

/**
 版本更新
 */
- (void)newVersion;

/**
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
/**
 control 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

+ (UIFont *)HzgbFontWithSize:(CGFloat)size;
+ (UIFont *)HzgbIPhoneFontWithSize:(CGFloat)size;
+ (UIFont *)SemiboldFontWithSize:(CGFloat)size;
+ (UIFont *)SemiboldIPhoneFontWithSize:(CGFloat)size;

/** 获取一个随机数*/
+ (int)getRandomNumber:(int)from to:(int)to;

+ (void)downloadFile:(NSString *)urlStr toFile:(NSString *)filePath;
+ (void)downloadFile:(NSString *)urlStr toFile:(NSString *)filePath completeHandler:(void (^)(void))completionHandler;
+ (NSString *)LMFilePath:(NSString *)urlStr;

+ (NSString *)DICFilePath:(NSString *)urlStr;

+ (CGFloat)getTopSafe;

+ (CGFloat)getBottomSafe;

+ (void)headIcon:(UIImageView *)img imgUrl:(NSString *)imgUrl;

/**
 显示gif加载图片
 @param hudGif gif的名称
 @param size gif显示的中间范围
 */
+ (void)showGifHud:(NSString *)hudGif size:(CGSize)size;
+ (void)dimissGifHud;

+ (NSArray *)getListArr;

@end
