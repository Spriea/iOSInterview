//
//  EKWKWebview.m
//  JinwowoNew
//
//  Created by jww_mac_002 on 2017/2/28.
//  Copyright © 2017年 wubangxin. All rights reserved.
//

#import "EKWKWebview.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKWebsiteDataStore.h>
#import <WebKit/WKWebsiteDataRecord.h>

@interface EKWKWebview ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) CALayer *progressView;

@property (assign, nonatomic) BOOL isCanSideBack;

@end

@implementation EKWKWebview

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.ios13Pop) {
        [self.navBarView superview].sk_heigth = kNavBarH;
        self.navBarView.sk_y = 0;
        self.sk_view.sk_y = kNavBarH;
        self.sk_view.sk_heigth = kScreenH-kNavBarH-34;
    }
    if (self.isPresent) {
        self.sk_navLeftBtn.hidden = NO;
        [self.sk_navLeftBtn addTarget:self action:@selector(dismissClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [self webUI];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webHtmlUrl]];
    [self.wkWebView loadRequest:request];
    if ([self.webHtmlUrl containsString:@"//puzzle.xcxsc.net/christmas"]) {
        self.wkWebView.scrollView.bounces = NO;
    }
}

- (void)dismissClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backBtn{
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        // pop动画时，将代理置空（tableview,scroview）
        self.wkWebView.scrollView.delegate = nil;
        self.wkWebView.UIDelegate = nil;
        self.wkWebView.navigationDelegate=nil;
        if ([NSThread isMainThread]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        if (self.clickBackBlock) {
            self.clickBackBlock();
        }
    }
}

///添加WKwebView
- (void)webUI {
    self.wkWebView=nil;
    [self.wkWebView removeFromSuperview];
 
    if (self.islocCookie) {
        WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [WKUserContentController new];
        [config.userContentController addScriptMessageHandler:self name:@"myInviteCode"];
        [config.userContentController addScriptMessageHandler:self name:@"putInviteCode"];
        [config.userContentController addScriptMessageHandler:self name:@"backToHome"];
        [config.userContentController addScriptMessageHandler:self name:@"unlockChristmas"];
        [config.userContentController addScriptMessageHandler:self name:@"wechatCustomer"];
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:self.sk_view.bounds configuration:config];
    } else {
        self.wkWebView = [[WKWebView alloc] initWithFrame:self.sk_view.bounds];
    }
    if (kSafeBottom != 0) {
        self.wkWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, -kSafeBottom, 0);
    }
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.wkWebView.scrollView.delegate = self;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate=self;
    self.wkWebView.backgroundColor = kBackColor;
    [self.sk_view addSubview:self.wkWebView];
//    if (@available(iOS 11.0, *)) {
        [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    }
    ///进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    [self.sk_view addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = kSelectCellColor.CGColor;
    [progress.layer addSublayer:layer];
    self.progressView = layer;
    self.webHtmlUrl = [self.webHtmlUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    ///支持左右滑动
    _wkWebView.allowsBackForwardNavigationGestures = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 让webview的内容一直居中显示
//    DLog(@"-%f",scrollView.contentOffset.y);
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - kScreenW)/2, scrollView.contentOffset.y<=-kNavH?-kNavH:scrollView.contentOffset.y);
}

///右的点击事件
- (void)clickRightBar:(id)bar {
//   // 跳转订单界面
//    NTMyOrderListVC *listVC = [[NTMyOrderListVC alloc] init];
//    [self.navigationController pushViewController:listVC animated:YES];
}

//#pragma mark - 导航每次跳转调用跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *url = navigationAction.request.URL.absoluteString;
    if ([url containsString:@".apple.com/cn/app/"]) { // 精品推荐app
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    }
//    else if ([url containsString:@"myInviteCode"]){ // 我的邀请码
//
//    }else if ([url containsString:@"putInviteCode"]){ // 输入邀请码
//
//    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

///开始请求
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.islocCookie) {
//         [super setupRightBarButtonItemWithImage:@"订单"];
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}


#pragma mark -  设置Cookie  实现动态语言和脚本语言都可以访问
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 2);
        if ([change[@"new"] floatValue] == 1) {
            kWEAK_SELF(weakS)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakS.progressView.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakS.progressView.frame = CGRectMake(0, 0, 0, 2);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebView) {
            self.title  = self.wkWebView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)backPrePage:(id)sender {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.clickBackBlock) {
            self.clickBackBlock();
        }
    }
}


////JS调用OC的注入
- (void)addScriptMessageHandlers:(NSArray *)arrayJsFunctionNames configuration:(WKWebViewConfiguration *)configuration {
    for (NSString  *name in arrayJsFunctionNames) {
        [configuration.userContentController addScriptMessageHandler:self name:name];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark 针对于web界面的三种提示框（警告框、确认框、输入框）分别对应三种代理方法。下面只举了警告框的例子。
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 完全离开界面
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView stopLoading];
     
    [self resetSideBack];
    self.wkWebView = nil;
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"canGoBack"];
    [self.wkWebView removeObserver:self forKeyPath:@"canGoForward"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView.configuration.userContentController removeAllUserScripts];
    self.wkWebView.scrollView.delegate = nil;
    self.wkWebView.UIDelegate = nil;
    self.wkWebView.navigationDelegate=nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self forbiddenSideBack];
//    if (@available(iOS 13.0, *)) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
//    }else{
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
 
#pragma mark - 解决侧滑偶尔卡死的情况
/**禁用边缘返*/
- (void)forbiddenSideBack{
    self.isCanSideBack = NO;
    //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
    }
}
/*恢复边缘返回*/
- (void)resetSideBack {
    self.isCanSideBack=YES;
    //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanSideBack;
}
@end

