//
//  AppDelegate.m
//  Urgency
//
//  Created by Somer.King on 2019/4/4.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "SKHomeVC.h"
#import "SKBaseNav.h"
#import "SKMainTabVC.h"
#import "SKLoginVC.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkSplash/AnyThinkSplash.h>
#import <BUAdSDK/BUAdSDK.h>
#import "GlobalSingleton.h"
#import <UMCommon/UMCommon.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#define kTimeJump 15*60
@interface AppDelegate ()<ATSplashDelegate>

@property (assign, nonatomic) BOOL flag;
@property (assign, nonatomic) NSTimeInterval preTime;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1、创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [ATAPI setLogEnabled:YES];
    NSError *error;
    [[ATAPI sharedInstance] startWithAppID:@"a60731ebc57dd9" appKey:@"8932125c17c9a87b3ca13c9866c3017d" error:&error];
       // v 5.7.6版本以上支持，新的加载方法
    
    [UMConfigure initWithAppkey:@"607322a618b72d2d244e3e3d" channel:@"App Store"];
    
    // 1.1.启动配置设置
    [self setupConfig];
    
    // 2.创建根控制器
//    [self setupRootVC];
//ID: a60731ebc57dd9
//穿山甲_开屏
//ID: b60731ee27a6cc
//    SKMainTabVC *homeVC = [[SKMainTabVC alloc] init];
//    SKBaseNav *homeNav = [[SKBaseNav alloc] initWithRootViewController:homeVC];
//    self.window.rootViewController = homeNav;
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle: nil];
    UIViewController *desVC = [board instantiateInitialViewController];
    self.window.rootViewController = desVC;
    [self loadAd];
    
//    SKMainTabVC *mainVC = [[SKMainTabVC alloc] init];
//    self.window.rootViewController = mainVC;
    
    //    [self getLocation];
    // 3、查看是否有推送的消息
    //    self.userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    // 4、APP启动登录
    //    [SKLoginVC autoLogin:self.window withMsg:self.userInfo];
//    application.statusBarHidden = YES;
    
//    NSString *idfa = [GlobalSingleton shareInstance].IDFAStr;
//    SKLog(@"idfa&&&   %@",idfa);
    // 5、显示并设置key
    [self.window makeKeyAndVisible];
    
    [StatisticalTool analysisConfigEvent:@"app_lanch" label:@"程序启动"];
    
    
    self.timer = [NSTimer timerWithTimeInterval:kTimeJump
                                    target:self
                                  selector:@selector(loadAd)
                                  userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:self.timer
                                 forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self nt_idfaWithResult:nil];
    });
    
    return YES;
}

- (void)loadAd{
    if ([SKCommonItem getComm].hasNoAD == 1 || [SKCommonItem getComm] == nil) {
        self.window.rootViewController = [SKMainTabVC new];
    }else{
        [[ATAdManager sharedManager] loadADWithPlacementID:@"b60731ee27a6cc" extra:@{kATSplashExtraTolerateTimeoutKey:@5.5} delegate:self containerView:nil];
        [StatisticalTool analysisConfigEvent:@"app_ad_splash" label:@"开屏广告加载"];
        self.preTime = [[NSDate date] timeIntervalSince1970];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    if (self.flag && [SKCommonItem getComm].hasNoAD == 0) {
        [self loadAd];
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    self.flag = YES;
}

- (void)setupConfig{
    [self initMonitorNetWorking];
    [self configBaseTool];
}

- (void)configBaseTool{
    [SVProgressHUD setMinimumDismissTimeInterval:0.75];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//设置HUD的Style
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO; //不显示键盘上工具条
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;//点击空白地方 隐藏键盘
    [[IQKeyboardManager sharedManager] setEnable:YES]; // 设置是否启用IQKeyboardManager
}

#pragma mark - loading delegate
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    UIWindow *mainWindow = nil;
    if (@available(iOS 13.0, *)) {
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
        [mainWindow makeKeyWindow];
    }else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    [[ATAdManager sharedManager] showSplashWithPlacementID:placementID window:mainWindow delegate:self];
}


- (void)didFailToLoadADWithPlacementID:(NSString* )placementID error:(NSError *)error {
    if (![self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        self.window.rootViewController = [SKMainTabVC new];
    }
    SKLog(@"错误--：%@",error);
}

#pragma mark - AT Splash Delegate method(s)
- (void)splashDidShowForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    
}

- (void)splashDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    
}

- (void)splashDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary*)extra {
    if (![self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        self.window.rootViewController = [SKMainTabVC new];
    }
}

#pragma mark - 监听网络状态
- (void)initMonitorNetWorking{
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager sharedManager];
    [networkManager startMonitoring];
    [networkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {//失去网络
            [SKCustomFunction alertSheetWithTitle:nil message:@"无法连接到互联网，请检查网络" confTitle:nil confirmHandler:^(UIAlertAction *action) {
                
            } cancleHandler:nil];
        }
    }];
}

/// 在这里写支持的旋转方向，为了防止横屏方向，应用启动时候界面变为横屏模式
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 可以这么写
    if (self.allowOrentitaionRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)nt_idfaWithResult:(void(^)(NSString *))result{
    static NSString *idfa = @"NULL";
    if (@available(iOS 14, *)) {
        ATTrackingManagerAuthorizationStatus status = ATTrackingManager.trackingAuthorizationStatus;
        switch (status) {
            case ATTrackingManagerAuthorizationStatusNotDetermined:
            {
                NSLog(@"用户未做选择或未弹窗");
                static NSString *idfa1 = @"NULL";
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                    if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
//                        idfa1 = [ASIdentifierManager.sharedManager advertisingIdentifier].UUIDString;
//                        idfa = idfa1.length ? idfa1 : @"NULL";
                    }else{
                        NSLog(@"为了更好的广告体验,请在设置-隐私-Tracking中允许App请求跟踪");
                        idfa = idfa1.length ? idfa1 : @"NULL";
//                        [NT_USER_DEFAULTS setObject:idfa forKey:@"NTCatergories.UIDevice.idfa"];
                    }
                }];
            }
                break;
            case ATTrackingManagerAuthorizationStatusRestricted:
                //用户在系统级别开启了限制广告追踪
                NSLog(@"请在设置-隐私-Tracking中允许App请求跟踪");
                
                break;
            case ATTrackingManagerAuthorizationStatusDenied:
                NSLog(@"用户拒绝");

                break;
            case ATTrackingManagerAuthorizationStatusAuthorized:
                NSLog(@"用户允许");
                static NSString *idfa2 = @"NULL";
                break;
        }
    }
}

@end
