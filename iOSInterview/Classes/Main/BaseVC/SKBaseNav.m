//
//  SKBaseNav.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/2/12.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKBaseNav.h"

@interface SKBaseNav ()<UIGestureRecognizerDelegate>

@end

@implementation SKBaseNav

+ (void)load
{
    UINavigationBar *itemBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //描述文字的字典
    NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
    //设置导航条文字属性
    titleDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleDict[NSFontAttributeName] = kFontWithSize(15);
    [itemBar setTitleTextAttributes:titleDict];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏下面的View为空（及那条线）
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置导航栏颜色背景
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kMainColor] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(- 0.8, 0);
    self.view.layer.shadowOpacity = 0.6;
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setHidden:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
//    self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

// 允许同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldBeRequiredToFailByGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:
            UIScreenEdgePanGestureRecognizer.class];
}


@end
