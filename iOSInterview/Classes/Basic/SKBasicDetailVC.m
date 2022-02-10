//
//  SKBasicDetailVC.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/10.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKBasicDetailVC.h"
#import "SKHomeItem.h"
#import "SKBase64Tool.h"
#import <WebKit/WebKit.h>
#import <MMMarkdown/MMMarkdown.h>

@interface SKBasicDetailVC ()<WKNavigationDelegate>

@property (strong, nonatomic) SKHomeItem *hItem;
@property (strong, nonatomic) NSMutableArray <SKHomeItem *>*dataArr;
@property (assign, nonatomic) NSInteger selIndex;
@property (nonatomic, strong) WKWebView *wkWebView;

@property (strong, nonatomic) NSString *htmlString;

@property (weak, nonatomic) UIButton *collBtn;

@end

@implementation SKBasicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
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
    [self loadData:self.dataArr[self.selIndex].ID];
    self.collBtn.selected = self.dataArr[self.selIndex].isCollection;
}

- (void)loadData:(NSString *)ID{
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"html" inDirectory:@"AppWeb/view"];
//    NSURL * url = [NSURL URLWithString:path];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
    
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index_light" ofType:@"html" inDirectory:@"basic"];
//    NSData *data = [NSData dataWithContentsOfFile:indexPath];
//    NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"1-tree" ofType:@"md" inDirectory:@"basic"];
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    NSError *error;
    NSString *markdown = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'" withString:@"&apos"];
//    NSString *str = @"<div class=\"container\" id=\"contents\">";
//    htmlString = [NSString stringWithFormat:@"%@%@",str,htmlString];
//    htmlString = [htmlStr stringByReplacingOccurrencesOfString:str withString:htmlString];
    self.htmlString = htmlString;
//    NSError *error0;
//    plistPath = [[NSBundle mainBundle] pathForResource:@"load_complet" ofType:@"html" inDirectory:@"basic"];
//    [htmlString writeToFile:plistPath atomically:YES encoding:NSUTF8StringEncoding error:&error0];
//    SKLog(@"%@",dict);
//    [self.wkWebView loadFileURL:<#(nonnull NSURL *)#> allowingReadAccessToURL:<#(nonnull NSURL *)#>]
    NSURL * url = [NSURL fileURLWithPath:indexPath];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
//    [self.wkWebView loadHTMLString:htmlString baseURL:nil];
//    [SKJsonManager loadDataJson:ID successBlock:^(id returnValue, NSString *errorCode) {
//        NSString *html = returnValue[@"data"][@"html"];
//        html = [SKBase64Tool base64Dencode:html];
//        // body{background-color:#f4f4f5}
//        html = [NSString stringWithFormat:@"<style>*{color:#333333}\n*{font-family: \"Microsoft YaHei\", \"微软雅黑\" !important}\n*{text-align: justify}\nbody{background-color:#f4f4f5}</style>\n<body>%@</body><meta charset=\"utf-8\">\n <meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">",html];
////        html = [html stringByReplacingOccurrencesOfString:@"<h3>" withString:@"<h3 style=\"color:#999\">"];
//        [self.wkWebView loadHTMLString:html baseURL:nil];
//        self.dataArr[self.selIndex].isCollection = [SKHomeItem jugeIDCollect:ID];
//    } errorBlock:nil HUD:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *scriptStr = [NSString stringWithFormat:@"document.getElementById(\"contents\").innerHTML='%@';",self.htmlString];
    [webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable json, NSError * _Nullable error) {
        NSLog(@"json is %@, error is %@",json, error);
    }];
}

- (void)setupUI{
    CGFloat botH = kSCALE_X(44)+kSafeBottom;
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.sk_view.sk_heigth-botH)];
//    self.wkWebView.scrollView.contentInset = UIEdgeInsetsMake(kSCALE_X(10), 0, kSCALE_X(44), 0);
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    self.wkWebView.navigationDelegate = self;
    [self.sk_view addSubview:self.wkWebView];
//    self.sk_view.backgroundColor = kBackColor;
    [self loadData:self.hItem.ID];
    
    UIView *botV = [[UIView alloc] initWithFrame:CGRectMake(0, self.sk_view.sk_heigth-botH, kScreenW, botH)];
    botV.backgroundColor = kMainColor;
    [self.sk_view addSubview:botV];
    
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
@end
