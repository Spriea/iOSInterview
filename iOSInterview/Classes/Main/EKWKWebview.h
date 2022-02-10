//
//  EKWKWebview.h
//  JinwowoNew
//
//  Created by jww_mac_002 on 2017/2/28.
//  Copyright © 2017年 wubangxin. All rights reserved.
//

#import "SKBaseVC.h"
#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSObjectProtocol

- (void)TestNOParameter;

- (void)TestOneParameter:(NSString* )message;

@end

@interface EKWKWebview : SKBaseVC <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic, strong) NSMutableDictionary *shareDic;
///网页地址
@property(nonatomic, strong) NSString *webHtmlUrl;

@property (nonatomic, assign) BOOL islocCookie;  // 是否有js

@property (nonatomic, copy) void(^clickBackBlock)(void);
@property (nonatomic, copy) void(^contactWXBlock)(void);

@property (assign, nonatomic) BOOL ios13Pop;

@property (assign, nonatomic) BOOL isPresent;
@end
