//
//  SKMainTabVC.m
//  Urgency
//
//  Created by Somer.King on 2019/4/10.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKMainTabVC.h"
#import "SKBaseNav.h"
#import "SKHomeVC.h"
#import "SKMineVC.h"
#import "UIImage+Render.h"


@interface SKMainTabVC ()<UITabBarDelegate>

@property (strong, nonatomic) NSMutableArray *tabArr;
@property (strong, nonatomic) NSArray *norImgArr;
@property (strong, nonatomic) NSArray *selImgArr;
@property (strong, nonatomic) NSMutableArray *backArr;
@property (weak, nonatomic) SKTabbar *selTabbar;

@end

@implementation SKMainTabVC

#pragma mark - 设置tabBarItem的字体大小和颜色
+ (void)load
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSDictionary *colorDict = @{
                                NSForegroundColorAttributeName : kMainColor
                                };
    
    [item setTitleTextAttributes:colorDict forState:UIControlStateSelected];//***注意方法
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabArr = [NSMutableArray array];
    self.norImgArr = @[@"info",@"record",@"map",@"mine"];
    self.selImgArr = @[@"info_rsel",@"record_rsel",@"map_rsel",@"mine_rsel"];
    self.backArr = [NSMutableArray array];
    [self setUpChildViewController];
    [self setUpAllTabBarItem];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
//    [self initSelfTabbar];
//    self.tabBar.hidden = YES;
}

#pragma mark - 设置子控制器
- (void)setUpChildViewController{
    //首页订单
    UIViewController *homePageVC = [[SKHomeVC alloc] init];
    SKBaseNav *homePageNavC = [[SKBaseNav alloc] initWithRootViewController:homePageVC];
    [self addChildViewController:homePageNavC];
    
    [self addChildViewController:[[SKBaseNav alloc] initWithRootViewController:[NSClassFromString(@"SKBasicVC") new]]];
    [self addChildViewController:[[SKBaseNav alloc] initWithRootViewController:[NSClassFromString(@"SKCollectionVC") new]]];
    
    //个人中心
    UIViewController *mePageVC = [[SKMineVC alloc] init];
    SKBaseNav *mePageNavC = [[SKBaseNav alloc] initWithRootViewController:mePageVC];
    [self addChildViewController:mePageNavC];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    kFeedbackWeekup
}

#pragma mark - 设置tabBar的各按钮的图片和文字
- (void)setUpAllTabBarItem
{
    NSArray *titleArr = @[@"面试题",@"基础",@"收藏",@"我的"];
    NSArray *imgArr = @[@"Tabbar_nor0",@"Tabbar_nor1",@"Tabbar_nor2",@"Tabbar_nor3"];
    NSArray *selImgArr = @[@"Tabbar_sel0",@"Tabbar_sel1",@"Tabbar_sel2",@"Tabbar_sel3"];
    self.tabBar.tintColor = kMainColor;
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = kAColor;
    } else {
        // Fallback on earlier versions
    }

    for (int i = 0; i < self.childViewControllers.count; i ++) {
        SKBaseNav *tempPage = self.childViewControllers[i];
        tempPage.tabBarItem.tag = i;
        tempPage.tabBarItem.image = [UIImage imageNameOfOriginal:imgArr[i]];
        tempPage.tabBarItem.selectedImage = [UIImage imageNameOfOriginal:selImgArr[i]];
        tempPage.tabBarItem.title = titleArr[i];
    }
}

//- (void)tabbarClick:(SKTabbar *)sender{
//    if (self.selTabbar == sender) {
//        return;
//    }
//    [self selBtn:sender];
//    [self setSelectedIndex:sender.tag];
//}

//- (void)selBtn:(SKTabbar *)tbBtn{
//    [tbBtn.imgV setImage:kImageInstance(self.selImgArr[tbBtn.tag])];
//    [tbBtn.titleL setTextColor:kMainColor];
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    CGPoint point = tbBtn.imgV.frame.origin;
//    point.y -= kSCALE_X(16);
//    anim.toValue = [NSNumber numberWithFloat:point.y];
//
//    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    anim1.toValue = [NSNumber numberWithFloat:1.94f];
//
//    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
//    groupAnimation.fillMode = kCAFillModeForwards;
//    groupAnimation.removedOnCompletion = NO;
//    groupAnimation.animations = [NSArray arrayWithObjects:anim,anim1, nil];
//    [tbBtn.imgV.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
//    UIView *backV = self.backArr[tbBtn.tag];
//
//
//    self.selTabbar.imgV.image = [UIImage imageNamed:self.norImgArr[self.selTabbar.tag]];
//    [self.selTabbar.titleL setTextColor:k3Color];
//    [self.selTabbar.imgV.layer removeAllAnimations];
//    self.selTabbar = tbBtn;
//}


//- (void)initSelfTabbar{
//    UIView *taber = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.sk_heigth-kSCALE_X(56)-kSafeBottom, kScreenW, kSCALE_X(56)+kSafeBottom)];
////    taber.backgroundColor = [UIColor redColor];
//    [self.view addSubview:taber];
//
//    NSArray *titleArr = @[@"环保资讯",@"机械备案",@"我的设备",@"个人中心"];
//
//    CGFloat topMar = kSCALE_X(13);
//    UIView *contV = [[UIView alloc] initWithFrame:CGRectMake(0, topMar, kScreenW, taber.sk_heigth-topMar)];
//    [taber addSubview:contV];
//    contV.backgroundColor = [UIColor whiteColor];
//
//    CGFloat with = kScreenW / titleArr.count;
//    for (int i = 0; i < titleArr.count; i ++) {
//        SKTabbar *cellV = [SKTabbar buttonWithType:UIButtonTypeCustom];
//        cellV.frame = CGRectMake(i*with, 0, with, taber.sk_heigth-kSafeBottom);
//        [taber addSubview:cellV];
//
//        UILabel *titleL = [[UILabel alloc] init];
//        [titleL sk_TitleFont:kFontWithSize(10) title:titleArr[i] color:k3Color];
//        [cellV addSubview:titleL];
//        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(cellV.mas_bottom).offset(-kSCALE_X(5));
//            make.centerX.equalTo(cellV);
//        }];
//
//        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE_X(17), kSCALE_X(17))];
//        imgV.image = kImageInstance(self.norImgArr[i]);
//        imgV.sk_bottom = cellV.sk_heigth-kSCALE_X(19);
//        imgV.sk_centerX = cellV.sk_width * 0.5;
//        [cellV addSubview:imgV];
//        cellV.imgV = imgV;
//        cellV.titleL = titleL;
//        cellV.tag = i;
//        [self.tabArr addObject:cellV];
//        [cellV addTarget:self action:@selector(tabbarClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        UIView *cicrlB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCALE_X(21), kSCALE_X(21))];
//        cicrlB.backgroundColor = [UIColor whiteColor];
//        cicrlB.sk_bottom = cellV.sk_heigth-kSCALE_X(15);
//        cicrlB.sk_centerX = cellV.sk_width * 0.5;
//        [cellV insertSubview:cicrlB atIndex:0];
//        cicrlB.tag = i;
//        [self.backArr addObject:cicrlB];
//        if (cellV.tag == 1) {
//            [self tabbarClick:cellV];
//        }
//    }
//}

@end


@implementation SKTabbar



@end
