//
//  SKInterviewDetail.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKInterviewDetail.h"
#import "SKHomeItem.h"
#import "SKBase64Tool.h"
#import <WebKit/WebKit.h>
#import <MMMarkdown/MMMarkdown.h>
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>
#import <AnyThinkBanner/AnyThinkBanner.h>

#define kBannerDetailID @"b60854de96b4e6"
@interface SKInterviewDetail ()<WKNavigationDelegate>

@property (strong, nonatomic) SKHomeItem *hItem;
@property (strong, nonatomic) NSMutableArray <SKHomeItem *>*dataArr;
@property (assign, nonatomic) NSInteger selIndex;
@property (nonatomic, strong) WKWebView *wkWebView;

@property (strong, nonatomic) NSString *htmlString;

@property (weak, nonatomic) UIButton *collBtn;

@property (strong, nonatomic) UIView *botBannerV;

@end

@implementation SKInterviewDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selIndex = [self.parameterObject integerValue];
    self.dataArr = self.dataObject;
    self.hItem = self.dataArr[self.selIndex];
    self.title = self.hItem.title;
    
    [self setupUI];
    
    [self setRightBtnTitle:[NSString stringWithFormat:@"%zd/%zd",self.selIndex+1,self.dataArr.count]];
    self.sk_navRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
}

- (void)collClick:(UIButton *)sender{
    kFeedbackWeekup
    sender.selected = !sender.selected;
    self.dataArr[self.selIndex].isCollection = sender.selected;
    if (sender.selected) {
        [SKHomeItem addCollectItem:self.dataArr[self.selIndex]];
    }else{
        [SKHomeItem removeCollectItem:self.dataArr[self.selIndex]];
    }
}
- (void)clickChange:(UIButton *)sender{
    kFeedbackWeekup
    if (sender.tag == 0) { // 上一题
        if (self.selIndex <= 0) {
            self.selIndex = self.dataArr.count-1;
        }else{
            self.selIndex--;
        }
    }else{
        if (self.selIndex >= self.dataArr.count-1){
            self.selIndex = 0;
        }else{
            self.selIndex++;
        }
    }
    if (self.dataArr[self.selIndex].file.length != 0) {
        [self loadBasicData:self.dataArr[self.selIndex].file];
    }else{
        [self loadData:self.dataArr[self.selIndex].ID];
    }
    self.title = self.dataArr[self.selIndex].title;
    self.collBtn.selected = self.dataArr[self.selIndex].isCollection;
    [self setRightBtnTitle:[NSString stringWithFormat:@"%zd/%zd",self.selIndex+1,self.dataArr.count]];
}

- (void)loadData:(NSString *)ID{
    [[ATAdManager sharedManager] loadADWithPlacementID:kBannerDetailID extra:@{kATAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(kScreenW, kScreenW*5.0/32)]} delegate:self];
    [SVProgressHUD show];
    [SKJsonManager loadDataJson:ID successBlock:^(id returnValue, NSString *errorCode) {
        NSString *html = returnValue[@"data"][@"html"];
        html = [SKBase64Tool base64Dencode:html];
        // body{background-color:#f4f4f5}
//        html = [NSString stringWithFormat:@"<style>*{color:#333333}\n*{font-family: \"Microsoft YaHei\", \"微软雅黑\" !important}\n*{text-align: justify}\nbody{background-color:#f4f4f5}</style>\n<body>%@</body><meta charset=\"utf-8\">\n <meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">",html];
//        html = [html stringByReplacingOccurrencesOfString:@"<h3>" withString:@"<h3 style=\"color:#999\">"];
        
        html = [html stringByReplacingOccurrencesOfString:@"'" withString:@"&apos"];
        html = [html stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        self.htmlString = html;
//        [self.wkWebView loadHTMLString:html baseURL:nil];
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index_light" ofType:@"html" inDirectory:@"basic"];
        NSURL * url = [NSURL fileURLWithPath:indexPath];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.wkWebView loadRequest:request];
        self.dataArr[self.selIndex].isCollection = [SKHomeItem jugeIDCollect:ID];
        [SVProgressHUD dismiss];
    } errorBlock:nil HUD:NO];
}
- (void)loadBasicData:(NSString *)file{
    [[ATAdManager sharedManager] loadADWithPlacementID:kBannerDetailID extra:@{kATAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(kScreenW, kScreenW*5.0/32)]} delegate:self];
    kWEAK_SELF(weakS)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index_light" ofType:@"html" inDirectory:@"basic"];

        NSString *plistPath = [[NSBundle mainBundle] pathForResource:file ofType:@"md" inDirectory:@"basic"];
        NSData *data = [NSData dataWithContentsOfFile:plistPath];
        NSError *error;
        NSString *markdown = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown extensions:MMMarkdownExtensionsGitHubFlavored error:&error];
        
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'" withString:@"&apos"];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        weakS.htmlString = htmlString;
        
//        htmlString = [SKBase64Tool base64Encode:htmlString];
//        htmlString = [NSString stringWithFormat:@"{\"data\":{\"html\":\"%@\"},\"code\":200}",htmlString];
//
//        [htmlString writeToFile:@"/Users/Spriea/Desktop/轻食菜谱/1001.json" atomically:YES encoding:NSUTF8StringEncoding error:0];
        

        NSURL * url = [NSURL fileURLWithPath:indexPath];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakS.wkWebView loadRequest:request];
        });
    });
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *scriptStr = [NSString stringWithFormat:@"document.getElementById(\"contents\").innerHTML='%@';",self.htmlString];
    [webView evaluateJavaScript:scriptStr completionHandler:nil];
}

- (void)setupUI{
    CGFloat botBannerH = kScreenW*5.0/32;
    CGFloat botH = kSCALE_X(44)+kSafeBottom;
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.sk_view.sk_heigth-botH-botBannerH)];
//    self.wkWebView.scrollView.contentInset = UIEdgeInsetsMake(kSCALE_X(10), 0, kSCALE_X(44), 0);
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    self.wkWebView.navigationDelegate = self;
    [self.sk_view addSubview:self.wkWebView];
//    self.sk_view.backgroundColor = kBackColor;
    if (self.hItem.file.length != 0) {
        [self loadBasicData:self.hItem.file];
    }else{
        [self loadData:self.hItem.ID];
    }
    
    
    UIView *botV = [[UIView alloc] initWithFrame:CGRectMake(0, self.sk_view.sk_heigth-botH, kScreenW, botH)];
    botV.backgroundColor = kMainColor;
    [self.sk_view addSubview:botV];
    
    self.botBannerV = [[UIView alloc] initWithFrame:CGRectMake(0, self.sk_view.sk_heigth-botH-botBannerH, kScreenW, botBannerH)];
    self.botBannerV.backgroundColor = [UIColor whiteColor];
    [self.sk_view addSubview:self.botBannerV];
    
    UIButton *collBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collBtn.frame = CGRectMake(kSCALE_X(25), kSCALE_X(2), kSCALE_X(40), kSCALE_X(40));
    collBtn.contentEdgeInsets = UIEdgeInsetsMake(kSCALE_X(6), kSCALE_X(6), kSCALE_X(6), kSCALE_X(6));
    [collBtn setImage:kImageInstance(@"collection_nor") forState:UIControlStateNormal];
    [collBtn setImage:kImageInstance(@"collection_sel") forState:UIControlStateSelected];
    [botV addSubview:collBtn];
    [collBtn addTarget:self action:@selector(collClick:) forControlEvents:UIControlEventTouchUpInside];
    self.collBtn = collBtn;
    collBtn.selected = self.hItem.isCollection;
    
    CGFloat x = kSCALE_X(90);
    CGFloat w = (kScreenW - x-kSCALE_X(10)-kSCALE_X(15))*0.5;
    NSArray *btnArr = @[@"上一题",@"下一题"];
    for (int i = 0; i < btnArr.count; i ++) {
        UIButton *cellB = [UIButton buttonWithType:UIButtonTypeCustom];
        cellB.frame = CGRectMake(x+(w+kSCALE_X(10))*i, kSCALE_X(4), w, kSCALE_X(36));
        cellB.layer.cornerRadius = kSCALE_X(4);
        cellB.layer.borderWidth = 1;
        cellB.layer.borderColor = kAColor.CGColor;
        cellB.backgroundColor = kMainColor;
        [cellB sk_TitleFont:kMedFontSize(16) title:btnArr[i] color:kAColor];
        [botV addSubview:cellB];
        cellB.tag = i;
        [cellB addTarget:self action:@selector(clickChange:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - loading delegate
- (void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    if ([kImageKey isEqualToString:placementID]) {
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementID inViewController:self delegate:self];
    }else if ([kBannerDetailID isEqualToString:placementID]){
        if ([[ATAdManager sharedManager] bannerAdReadyForPlacementID:placementID]) {
            [self showBanner];
        } else {
            //Load banner here
        }
    }else{
//        [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:placementID inViewController:self delegate:self];
    }
}

-(void)showBanner {
    if ([[ATAdManager sharedManager] bannerAdReadyForPlacementID:kBannerDetailID]) {
//        [StatisticalTool analysisConfigEvent:@"banner_update_count" label:@"首页"];
    //Retrieve banner view
        ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:kBannerDetailID];
        bannerView.delegate = self;
        bannerView.presentingViewController = self;
        bannerView.translatesAutoresizingMaskIntoConstraints = NO;
//        bannerView.tag = tag;
        //kScreenW*13.0/30
        bannerView.frame = self.botBannerV.bounds;
        
        [self.botBannerV addSubview:bannerView];
        //Layour banner
//        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.scrollV).offset(self.topMar);
//            make.left.equalTo(self.scrollV);
//            make.width.mas_equalTo(kScreenW);
//            make.height.mas_equalTo(kScreenW*13.0/30);
//        }];
    } else {
//        NSLog(@"Banner ad's not ready for placementID:%@", _placementIDs[_name]);
    }
}

- (void) didFailToLoadADWithPlacementID:(NSString* )placementID error:(NSError *)error {
    if ([placementID isEqualToString:kReardVideoKey]) {
        [SVProgressHUD showErrorWithStatus:@"未拉取到视频，请稍后再试"];
    }
}

-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded extra:(NSDictionary *)extra {
//    [self pushChildrenViewController:@"SKPlayPPTVC" parameterObject:@(self.index) dataObject:self.titleStr];
//    [StatisticalTool analysisConfigEvent:@"video_complet" label:[NSString stringWithFormat:@"首页视频：%zd",self.index]];
}
@end
