//
//  SKCustomFunction.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKCustomFunction.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import "SKBaseNav.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import<AudioToolbox/AudioToolbox.h>

#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import <MapKit/MapKit.h>

#import "SKFileManager.h"
#import "SKNewVersionView.h"
#import "LBPhotoBrowserManager.h"

#import "SKAlertView.h"


struct utsname systemInfo;

@implementation SKCustomFunction
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static SKCustomFunction *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SKCustomFunction alloc] init];
    });
    return instance;
}

+ (NSString*)getDeviceVersion{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)getCurrentVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (UIBarButtonItem *)barItemWithTarget:(UIViewController *)vc img:(NSString *)img imgHeigth:(NSString *)imgHeigth action:(SEL)sel{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imgHeigth] forState:UIControlStateHighlighted];
    // 获取按钮背景图片
    [btn sizeToFit];
    
    [btn addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    
    // 返回UIBarButtonItem
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

 // 开启倒计时效果
+ (void)authCodeTimerWithButton:(UIButton *)authCodeBtn{
    __block NSInteger time = 59; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{

        if(time <= 0){ //倒计时结束，关闭

            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮的样式
                [authCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = YES;
                authCodeBtn.backgroundColor = kMainColor;
            });

        }else{

            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮显示读秒效果
                [authCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = NO;
                authCodeBtn.backgroundColor = alpColor(@"#13b1d2", 0.5);
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

// 弹出选择提示框
+ (void)alertSheetWithTitle:(NSString *)title message:(NSString *)message confTitle:(NSString *)btnTitle confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancleHandler:(void (^)(UIAlertAction *action))cancleHandler{
//    message = @"账号／密码错误或账号密码组合错误，详情请查看帮助。";
//    SKAlertView *myAlert = [SKAlertView initWithMsg:message confirmBtn:btnTitle confirmHandler:confirmHandler cancleHandler:cancleHandler];
//    [[UIApplication sharedApplication].keyWindow addSubview:myAlert];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (title != nil) {
        // change color of title
        NSMutableAttributedString *alertTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [alertTitle addAttribute:NSForegroundColorAttributeName value:Color(@"#333333") range:NSMakeRange(0, alertTitle.length)];
        [alertVc setValue:alertTitle forKey:@"attributedTitle"];
    }
    
    if (message != nil) {
        // change color of message
        NSMutableAttributedString *alertMsg = [[NSMutableAttributedString alloc] initWithString:message];
        [alertMsg addAttribute:NSForegroundColorAttributeName value:Color(@"#333333") range:NSMakeRange(0, alertMsg.length)];
        [alertVc setValue:alertMsg forKey:@"attributedMessage"];
    }
    
    if (cancleHandler != nil) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancleHandler];
        [alertVc addAction:action1];
        
        if (IOS_Later(9.0)) {
            [action1 setValue:Color(@"#999999") forKey:@"titleTextColor"];
        }
    }
    
    if (confirmHandler != nil) {
        if (btnTitle == nil) {
            btnTitle = @"确认";
        }
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:confirmHandler];
        [alertVc addAction:action2];
        
        if (IOS_Later(9.0)) {
            [action2 setValue:kMainColor forKey:@"titleTextColor"];
        }
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
}

// 根据编码获取对应语言文字
+ (NSString *)getStringWithCode:(NSString *)code inArray:(NSArray *)languages{
    NSArray *temp = languages[1];
    for (int i = 0; i < temp.count; i ++) {
        if ([code isEqualToString:temp[i]]) {
            return languages[0][i];
        }
    }
    return nil;
}

// 根据语言文字获取对应编码
+ (NSString *)getCodeWithString:(NSString *)code inArray:(NSArray *)languages{
    NSArray *temp = languages[0];
    for (int i = 0; i < temp.count; i ++) {
        if ([code isEqualToString:temp[i]]) {
            return languages[1][i];
        }
    }
    return nil;
}

//  压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.4);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//  压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.4);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 弹出选择提示框
+ (void)setTabarBadge:(NSInteger)index count:(NSInteger)count{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (![vc isKindOfClass:[UITabBarController class]]) {
        return;
    }
    // 标记消息红点
    UITabBarController *tab = (UITabBarController *)vc;
    UITabBarItem *item = [tab.tabBar.items objectAtIndex:index];
    if (count == 0) {
        item.badgeValue = nil;
    }else{
        item.badgeValue = [NSString stringWithFormat:@"%zd" , count];
    }
}

+ (void)checkTabarBadge:(NSInteger)index count:(NSInteger)count{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (![vc isKindOfClass:[UITabBarController class]]) {
        return;
    }
    // 标记消息红点
    UITabBarController *tab = (UITabBarController *)vc;
    UITabBarItem *item = [tab.tabBar.items objectAtIndex:index];
    if (count != 0) {
        item.badgeValue = [NSString stringWithFormat:@"%d", [item.badgeValue integerValue] + count];
    }
}

+ (void)addTabarCount:(NSInteger)index{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (![vc isKindOfClass:[UITabBarController class]]) {
        return;
    }
    // 标记消息红点
    UITabBarController *tab = (UITabBarController *)vc;
    UITabBarItem *item = [tab.tabBar.items objectAtIndex:index];
    
    if (item.badgeValue.length == 0) {
        item.badgeValue = @"1";
    }else{
        item.badgeValue = [NSString stringWithFormat:@"%d" , [item.badgeValue integerValue] + 1];
    }
}

+ (void)addTabarCount:(NSInteger)index count:(NSInteger)count{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (![vc isKindOfClass:[UITabBarController class]]) {
        return;
    }
    // 标记消息红点
    UITabBarController *tab = (UITabBarController *)vc;
    UITabBarItem *item = [tab.tabBar.items objectAtIndex:index];
    
    if (item.badgeValue.length == 0) {
        item.badgeValue = [NSString stringWithFormat:@"%zd", count];
    }else{
        item.badgeValue = [NSString stringWithFormat:@"%d" , [item.badgeValue integerValue] + count];
    }
}

// 获取当前时区
+ (NSInteger)getCurrentTimeZone{
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone] ;///获取当前时区信息
    NSInteger sourceGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]];///获取偏移秒数
//    NSLog(@"offset = %zd",sourceGMTOffset/3600);///除以3600即可获取小时数，即为当前时区
    return sourceGMTOffset/3600;
}


#pragma mark - 系统自带代码
- (void)saveToAlbumImage:(UIImage *)img {
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UILabel *hud = [[UILabel alloc] init];
    LBPhotoBrowserView *photoV = [LBPhotoBrowserManager defaultManager].photoBrowserView;
    [photoV addSubview:hud];
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(photoV.mas_centerX);
        make.bottom.equalTo(photoV.mas_bottom).offset(- kSCALE_X(140));
        make.width.mas_equalTo(kSCALE_X(155));
        make.height.mas_equalTo(kSCALE_X(32));
    }];
    hud.textAlignment = NSTextAlignmentCenter;
    hud.layer.cornerRadius = kSCALE_X(3);
    hud.clipsToBounds = YES;
    if (error) {
        [hud sk_TitleFont:kFontWithSize(16) title:@"图片保存失败" color:[UIColor blackColor]];
        hud.backgroundColor = [UIColor whiteColor];
        //        [SVProgressHUD showErrorWithStatus:kLanguage(@"home_msg_emecy_detail_save_err")];
        SKLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
    }else{
        //        [SVProgressHUD showSuccessWithStatus:kLanguage(@"home_msg_emecy_detail_save_suc")];
        [hud sk_TitleFont:kFontWithSize(16) title:@"图片保存成功" color:Color(@"#333333")];
        hud.backgroundColor = [UIColor whiteColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud removeFromSuperview];
        });
    }
    
}

+ (void)showImageBrowser:(UIView *)supView imgView:(UIView *)imgView img:(UIImage *)img{
    LBPhotoLocalItem *item = [[LBPhotoLocalItem alloc] initWithImage:img frame:imgView.frame];
    
    [LBPhotoBrowserManager.defaultManager showImageWithLocalItems:@[item] selectedIndex:0 fromImageViewSuperView:supView];
}

+ (void)showAlbumImgsAt:(NSArray *)supViews imgViews:(NSArray *)imgViews imgs:(NSArray *)imgs selectTag:(NSInteger)tag{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imgs.count; i++ ) {
        UIView *tempV = imgViews[i];
        LBPhotoWebItem *item = [[LBPhotoWebItem alloc] initWithURLString:imgs[i] frame:tempV.frame];
        item.placeholdImage = kImageInstance(@"pla");
        [items addObject:item];
    }
    
    
    UIView *tempV = supViews[tag];
    [[[LBPhotoBrowserManager.defaultManager showImageWithWebItems:items selectedIndex:tag fromImageViewSuperView:tempV] addLongPressShowTitles:@[@"保存",@"取消"]] addTitleClickCallbackBlock:^(UIImage *image, NSIndexPath *indexPath, NSString *title) {
        if ([title isEqualToString:@"保存"]) {
            [[SKCustomFunction sharedManager] saveToAlbumImage:image];
        }
    }].lowGifMemory = YES;
    [LBPhotoBrowserManager defaultManager].needPreloading = NO;
}

+ (void)showAlbumImgsAt:(UICollectionView *)collectionView imgs:(NSArray *)imgs indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imgs.count; i++ ) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        LBPhotoWebItem *item = nil;
        item = [[LBPhotoWebItem alloc]initWithURLString:imgs[i] frame:cell.frame];
        item.placeholdImage = [UIImage imageNamed:@"pla"];
        [items addObject:item];
    }
    
    [[[[[LBPhotoBrowserManager defaultManager]showImageWithWebItems:items selectedIndex:indexPath.row fromImageViewSuperView:collectionView] addCollectionViewLinkageStyle:UICollectionViewScrollPositionCenteredHorizontally cellReuseIdentifier:@"cell"] addLongPressShowTitles:@[@"保存",@"取消"]]addTitleClickCallbackBlock:^(UIImage *image, NSIndexPath *indexPath, NSString *title) {
        if ([title isEqualToString:@"保存"]) {
            [[SKCustomFunction sharedManager] saveToAlbumImage:image];
        }
    }].lowGifMemory = YES;
    [LBPhotoBrowserManager defaultManager].needPreloading = NO;
}

- (void)photoFromAlbumOrCamera:(NSString *)title isEdit:(BOOL)edit{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    kWEAK_SELF(weakS)
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [SKCustomFunction checkCameraAuth:^{
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = weakS;
                picker.allowsEditing = edit;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
            }];
        } else {
            [SVProgressHUD showErrorWithStatus:@"没有访问相机的权限"];
        }
    }];
    [alertVC addAction:action1];
    
    if (IOS_Later(9.0)) {
        [action1 setValue:kMainColor forKey:@"titleTextColor"];
    }
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [SKCustomFunction checkPhotoAuth:^{
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = weakS;
                picker.allowsEditing = edit;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
            }];
        } else {
            [SVProgressHUD showErrorWithStatus:@"没有访问相机的权限"];
        }
    }];
    [alertVC addAction:action2];
    
    if (IOS_Later(9.0)) {
        [action2 setValue:kMainColor forKey:@"titleTextColor"];
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertVC addAction:action3];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
}
#pragma -mark 选择照片完毕后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *images = [info objectForKey:UIImagePickerControllerOriginalImage];
    // 压缩图片
//    UIImage *image = [UIImage imageWithData:UIImageJPEGRepresentation(images, 0.4)];
    UIImage *image = [SKCustomFunction imageWithImageSimple:images];
    
//    image = [UIImage imageWithData:UIImagePNGRepresentation(image)];
    
    if ([self.delegate respondsToSelector:@selector(customFunctionDidPickImage:)]) {
        [self.delegate customFunctionDidPickImage:image];
    }
    
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        //存储拍摄的照片
        //        UIImageWriteToSavedPhotosAlbum(images, self, nil, nil);
    }
}

+ (BOOL)compareTime:(NSString *)dt last_dt:(NSString *)last_dt{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* startDate = [formater dateFromString:last_dt];
    NSDate* endDate = [formater dateFromString:dt];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    if(time < 60){
        return YES;
    }else{
        return NO;
    }
}

+ (void)checkCameraAuth:(void(^)(void))checkSuccess{
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
{
        NSString *mesg = [NSString stringWithFormat:@"请在iPhone的“设置-隐私”选项中，允许%@访问你的相机。", app_Name];
        [SKCustomFunction alertSheetWithTitle:nil message:mesg confTitle:@"设置" confirmHandler:^(UIAlertAction *action) {
        // 无权限 引导去开启
        NSURL *url = [NSURL URLWithString: UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url] ) {
            NSURL*url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    } cancleHandler:^(UIAlertAction *action) {}];
    }else{
        checkSuccess();
    }
}

+ (void)checkPhotoAuth:(void(^)(void))checkSuccess{
    //相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        //无权限 引导去开启
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        checkSuccess();
    }
}

+ (void)jumpToNavigation:(CLLocationCoordinate2D)destination{
    NSString *urlScheme = @"pceaRecord://";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    　　 CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(destination.latitude, destination.longitude);
    UIApplication *application = [UIApplication sharedApplication];
    
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ( [application canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]){
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用iPhone自带地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil]];
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        }];
        if (IOS_Later(9.0)) {
            [action setValue:kMainColor forKey:@"titleTextColor"];
        }
        [alert addAction:action];
    }
    
    if ( [application canOpenURL:[NSURL URLWithString:@"baidumap"]]){
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",destination.latitude,destination.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        if (IOS_Later(9.0)) {
            [action setValue:kMainColor forKey:@"titleTextColor"];
        }
        [alert addAction:action];
    }
    
    if ([application canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",app_Name,urlScheme,destination.latitude,destination.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        if (IOS_Later(9.0)) {
            [action setValue:kMainColor forKey:@"titleTextColor"];
        }
        [alert addAction:action];
    }
    
    //    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
    //        　　UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //            　　NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //            　　[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    //
    //        }];
    //        　　[alert addAction:action];
    //
    //    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

// 跳转登录界面
+ (void)jumpToLogin{
    UIViewController *longinVC = [[NSClassFromString(@"SKLoginVC") alloc] init];
    SKBaseNav *longinNav = [[SKBaseNav alloc] initWithRootViewController:longinVC];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:longinNav animated:YES completion:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = longinNav;
}

/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}

/*
 control 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = control.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = control.layer;
    control.frame = gradientLayer1.bounds;
}

+ (UIFont *)HzgbFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"hzgb" size:FONT_SIZE(size)];
}

+ (UIFont *)HzgbIPhoneFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"hzgb" size:FONT_SIZE(size)];
}

+ (UIFont *)SemiboldFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:FONT_SIZE(size)];
    if (font == nil) {
        font = kFontWithSize(size);
    }
    return font;
}

+ (UIFont *)SemiboldIPhoneFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:FONT_SIZE(size)];
    if (font == nil) {
        font = kFontWithSize(size);
    }
    return font;
}

+ (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % ((to - from) + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}


+ (void)downloadFile:(NSString *)urlStr toFile:(NSString *)filePath{
    if ([SKFileManager isExistsFileAtPath:filePath]) {
//        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        return;
    }
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [SVProgressHUD show];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *req = (NSHTTPURLResponse *)response;
        [SVProgressHUD dismiss];
        if (req.statusCode != 200) {
//            NSString *temp = [NSString stringWithFormat:@"code:%zd",req.statusCode];
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//            kAlert(@"下载错误", temp);
            return ;
        }
        
        if (!error) {
            NSError *saveError;            
            NSURL *saveUrl = [NSURL fileURLWithPath:filePath];
            
            //把下载的内容从cache复制到document下
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            
            if (!saveError) {
                SKLog(@"save success");
            }else{
                SKLog(@"save error:%@",saveError.localizedDescription);
            }
        }else{
            SKLog(@"download error:%@",error.localizedDescription);
        }
    }];
    [downloadTask resume];
}

+ (void)downloadFile:(NSString *)urlStr toFile:(NSString *)filePath completeHandler:(void (^)(void))completionHandler{
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *saveError;
            NSURL *saveUrl = [NSURL fileURLWithPath:filePath];
            //把下载的内容从cache复制到document下
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            
            completionHandler();
            
        }else{
            SKLog(@"download error:%@",error.localizedDescription);
        }
    }];
    [downloadTask resume];
}

+ (NSString *)LMFilePath:(NSString *)urlStr{
    NSString *cachePath = [SKFileManager getCacheCreateDir:@"speak.robot"];
    NSString *fileName = [NSString stringWithFormat:@"%@.languagemodel",[NSString md5WithString:urlStr]];
    NSString *savePath = [cachePath stringByAppendingPathComponent:fileName];
    return savePath;
}

+ (NSString *)DICFilePath:(NSString *)urlStr{
    NSString *cachePath = [SKFileManager getCacheCreateDir:@"speak.robot"];
    NSString *fileName = [NSString stringWithFormat:@"%@.dic",[NSString md5WithString:urlStr]];
    NSString *savePath = [cachePath stringByAppendingPathComponent:fileName];
    return savePath;
}

- (void)newVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@app_version_code=%@&app_platform=ios&",u_version,infoDictionary[@"CFBundleShortVersionString"]];
    
//    SKNewVersionView *newVersion = [[SKNewVersionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
//    newVersion.isMust = NO;
//    [[UIApplication sharedApplication].keyWindow addSubview:newVersion];
//    return;
    
    [SKHTTPTool networkWithURL:urlStr successBlock:^(id returnValue, NSString *errorCode) {
        if (errorCode != nil) {
            return ;
        }
        NSString *ver_num = returnValue[@"data"][@"app_compile"];  // 版本更新号
        NSString *ver_min_num = returnValue[@"data"][@"app_lowest_compile"]; // 最低版本要求
        NSString *ver_name = returnValue[@"data"][@"app_version_code"];  // 版本名称
        NSString *renew_detail = returnValue[@"data"][@"update_msg"];  // 内容
        NSString *downUrl = returnValue[@"data"][@"app_download"];
        
        [[NSUserDefaults standardUserDefaults] setObject:downUrl forKey:@"down_url"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([app_build integerValue] < [ver_num integerValue]) {
            SKNewVersionView *newVersion = [[SKNewVersionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
            newVersion.contentL.text = renew_detail;
            newVersion.downUrl = downUrl;
            newVersion.versionL.text = [NSString stringWithFormat:@"小爱英语\n版本更新\nV%@",ver_name];
            if ([app_build integerValue] < [ver_min_num integerValue]) { // 小于最小版本，强制更新
                newVersion.isMust = YES;
            }else{
                newVersion.isMust = NO;
            }
            [[UIApplication sharedApplication].keyWindow addSubview:newVersion];
        }
    } HUD:NO];
}

+ (CGFloat)getTopSafe{
    if (@available(iOS 11.0, *)) {
        if ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.top != 0) {
            CGFloat top = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top;
//            CGFloat bot = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;  44
            return top;
        }
        return 0;
    }else{
        return 0;
    }
}

+ (CGFloat)getBottomSafe{
    if (@available(iOS 11.0, *)) {// 34
        return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    }else{
        return 0;
    }
    
    
}

+ (CGFloat)getSacleSize:(CGFloat)size{
    if (kIS_PAD) {
        return ((kScreenH/667.f)*size);
    }else{
        return ((kScreenW/375.f)*size);
    }
}

+ (CGFloat)getSacleWith:(CGFloat)size{
    if (kIS_PAD) {
        return ((kScreenW/667.f)*size);
    }else{
        return ((kScreenW/375.f)*size);
    }
}

+ (void)headIcon:(UIImageView *)img imgUrl:(NSString *)imgUrl{
    [img sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:kImageInstance(@"user_head")];
}

+ (void)showGifHud:(NSString *)hudGif size:(CGSize)size{
    [SVProgressHUD showLoadingImage:[UIImage imageWithGIFNamed:hudGif]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setImageViewSize:size];
}

+ (void)dimissGifHud{
    [SVProgressHUD dismiss];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];
}

+ (NSArray *)getListArr{
    SKCommonItem *comm = [SKCommonItem getComm];
    if (comm == nil || comm.c == 1) {
        return @[@"iOS",@"PHP",@"H5",@"Python",@"Java",@"Unity3D"];
    }else{
        return @[@"iOS",@"PHP",@"H5",@"Python",@"Java",@"Unity3D",@"Android"];
    }
}
@end
