//
//  SKHomeVC.m
//  Urgency
//
//  Created by Somer.King on 2019/4/4.
//  Copyright © 2019 Somer.King. All rights reserved.
//

#import "SKHomeVC.h"
#import "SKTypeChoseV.h"
#import "SKHomeCell.h"
#import "SKNewVersionView.h"
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>
#import <AnyThinkBanner/AnyThinkBanner.h>

#define kUserPosition @"user_position"

static NSArray *viewTypeArr;
static NSArray *titlARr;
@interface SKHomeVC () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *choseView;
@property (weak, nonatomic) UIButton *typeBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) SKTypeChoseV *guideV;
@property (strong, nonatomic) NSMutableArray <SKHomeItem *>*dataArr;

@property (strong, nonatomic) UIView *topBannerV;
@property (assign, nonatomic) SKInterviewType type;

@end

@implementation SKHomeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if (self.topBannerV != nil) {
        [[ATAdManager sharedManager] loadADWithPlacementID:kBannerID extra:@{kATAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(kScreenW, kScreenW*0.25)]} delegate:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"面试题大全";
//    self.sk_view.backgroundColor = kBackColor;
    [self setupNavBtn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.sk_view.sk_heigth-kTabH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[SKHomeCell class] forCellReuseIdentifier:@"homeCell"];
    tableView.contentInset = UIEdgeInsetsMake(kSCALE_X(5), 0, kSCALE_X(5), 0);
    tableView.showsVerticalScrollIndicator = NO;
    [self.sk_view addSubview:tableView];
    self.tableView = tableView;
    kWEAK_SELF(weakS)
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakS loadData:NO];
    }];
    
    [self loadVersionData];
    
    
    self.topBannerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*0.25)];
    tableView.tableHeaderView = self.topBannerV;
    
}

#pragma mark - 请求数据后初始化
- (void)setupInit{
    viewTypeArr = [SKCustomFunction getListArr];
    NSString *typeStr = [[NSUserDefaults standardUserDefaults] stringForKey:kUserPosition];
    if (typeStr == nil) {
        kWEAK_SELF(weakS)
        self.guideV.choseResult = ^(NSInteger index) {
            weakS.type = index;
            [weakS completeGuide];
            [StatisticalTool analysisConfigEvent:@"first_sel_it" label:viewTypeArr[index]];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:self.guideV];
    }else{
        self.type = [typeStr integerValue];
        [self choseInterviewType:self.type];
    }
}

- (void)setType:(SKInterviewType)type{
    _type = type;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd",type] forKey:kUserPosition];
}

- (void)loadVersionData{
    NSString *urlString = @"https://www.yuque.com/docs/share/9ac5cc5e-068d-4815-8de1-83bd23ed6e74?# 《面试题大全》";
    [SKHTTPTool getHtmlWithURL:urlString successBlock:^(id returnValue, NSString *errorCode) {
        if (returnValue == nil) {
            SKCommonItem *comm = [SKCommonItem getComm];
            [self setupInit];
            if (comm == nil) {
                return;
            }
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
            if (comm.version > [app_build intValue]) {
                [self updateVersion];
            }else{
                if (comm.hasNoAD == 0) {
                    [[ATAdManager sharedManager] loadADWithPlacementID:kImageKey extra:nil delegate:self];
                }
            }
            return;
        }
        SKCommonItem *comm = [SKCommonItem mj_objectWithKeyValues:returnValue];
        [SKCommonItem saveComm:comm];

        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        if (comm.version > [app_build intValue]) {
            [self updateVersion];
        }else{
            if (comm.hasNoAD == 0) {
                [[ATAdManager sharedManager] loadADWithPlacementID:kImageKey extra:nil delegate:self];
            }
        }
        [self setupInit];
    } errorBlock:^(id errorCode) {
        [self setupInit];
    } HUD:YES];
}

#pragma mark - loading delegate
- (void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    if ([kImageKey isEqualToString:placementID]) {
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementID inViewController:self delegate:self];
    }else if ([kBannerID isEqualToString:placementID]){
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
    if ([[ATAdManager sharedManager] bannerAdReadyForPlacementID:kBannerID]) {
//        [StatisticalTool analysisConfigEvent:@"banner_update_count" label:@"首页"];
    //Retrieve banner view
        ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:kBannerID];
        bannerView.delegate = self;
        bannerView.presentingViewController = self;
        bannerView.translatesAutoresizingMaskIntoConstraints = NO;
//        bannerView.tag = tag;
        //kScreenW*13.0/30
        bannerView.frame = self.topBannerV.bounds;
        
        [self.topBannerV addSubview:bannerView];
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


- (void)loadData:(BOOL)hud{
    NSString *json = [NSString stringWithFormat:@"%@",viewTypeArr[self.type]];
    [SKJsonManager loadDataJson:json successBlock:^(id returnValue, NSString *errorCode) {
        self.dataArr = [SKHomeItem mj_objectArrayWithKeyValuesArray:returnValue[@"data"]];
        kWEAK_SELF(weakS)
        [self.dataArr enumerateObjectsUsingBlock:^(SKHomeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            CGFloat h = [obj.title sizeWithMaxWidth:(kScreenW-kSCALE_X(25)) andFont:kFontWithSize(15)].height;
            NSAttributedString *att = [obj.title getAttributedStringWithLineSpace:kSCALE_X(6) kern:0];
            CGFloat h = [NSString sizeWithAttText:att font:kFontWithSize(18) width:kScreenW-kSCALE_X(58)].height;
            obj.cellH = h + kSCALE_X(105);
            obj.type = weakS.type;
            obj.isCollection = [SKHomeItem jugeIDCollect:obj.ID];
        }];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } errorBlock:^(id errorCode) {
        [self.tableView.mj_header endRefreshing];
    } HUD:hud];
}

- (void)updateVersion{
    SKNewVersionView *newVersion = [[SKNewVersionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    newVersion.contentL.text = [SKCommonItem getComm].updateContent;
    newVersion.downUrl = [NSString stringWithFormat:@"https://apps.apple.com/cn/app/id%@?mt=8",[SKCommonItem getComm].downUrl];
    newVersion.isMust = [SKCommonItem getComm].is_force;
    [[UIApplication sharedApplication].keyWindow addSubview:newVersion];
}

- (void)completeGuide{
    // 平移
    CABasicAnimation *anima1 = [CABasicAnimation animation];
    anima1.keyPath = @"transform.translation.y";
    anima1.toValue = @(-kScreenH*0.5+kStatusH+22);
    
    CABasicAnimation *anima3 = [CABasicAnimation animation];
    anima3.keyPath = @"transform.translation.x";
    anima3.toValue = @(kScreenW*0.5-25);
    
    // 缩放
    CABasicAnimation *anima2 = [CABasicAnimation animation];
    anima2.keyPath = @"transform.scale";
    anima2.toValue = @(0.0);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anima1,anima3,anima2];
    
    group.removedOnCompletion = NO;
    group.duration = 0.35;
    group.fillMode = kCAFillModeForwards;
    
    [self.guideV.layer addAnimation:group forKey:nil];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.guideV.alpha = 0.3;
    } completion:^(BOOL finished) {
        [self.guideV removeFromSuperview];
    }];
    [self.typeBtn setTitle:viewTypeArr[self.type] forState:UIControlStateNormal];
    [self.tableView.mj_header beginRefreshing];
}

- (void)choseInterviewType:(NSInteger)type{
    self.type = type;
    [self.typeBtn setTitle:viewTypeArr[type] forState:UIControlStateNormal];
    self.typeBtn.selected = NO;
    [self dissmisTypeView];
    [self loadData:YES];
}

- (void)catchDataCode{
    NSArray *titlARr = @[@"1",@"2",@"3",@"4",@"7",@"8",@"9"];
    for (int i = 0; i < 7; i ++) {
        NSString *url = [NSString stringWithFormat:@"https://api.zhk1024.com/index.php/api/Interview/articleList?cid=%@&end=10000&start=0",titlARr[i]];
        [SKHTTPTool requsetWithURL:url parameter:nil successBlock:^(id returnValue, NSString *errorCode) {
            NSString *string = [NSString stringWithFormat:@"/Users/Spriea/Desktop/试题JSON/%d_%@.json",i,viewTypeArr[i]];
            NSString *json = [returnValue mj_JSONString];
            [json writeToFile:string atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            NSArray *arr = returnValue[@"data"];
            for (int j = 0; j < arr.count; j ++) {
                NSDictionary *tepD = arr[j];
                string = [NSString stringWithFormat:@"https://api.zhk1024.com/index.php/api/Interview/articleContentNew?id=%@",tepD[@"id"]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
                NSError *error;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                json = [dict mj_JSONString];
                string = [NSString stringWithFormat:@"/Users/Spriea/Desktop/试题JSON/detailJson/%@.json",tepD[@"id"]];
                [json writeToFile:string atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
        } errorBlock:nil HUD:YES requustType:SKRequsetTypeGET];
    }
}

#pragma mark - button action
- (void)choseTypeClick:(UIButton *)sender{
    kFeedbackWeekup
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self showTypeView];
    }else{
        [self dissmisTypeView];
    }
    [StatisticalTool analysisConfigEvent:@"home_chose_type" label:viewTypeArr[sender.tag]];
}
#pragma mark - 选择type
- (void)choseViewType:(UIButton *)sender{
    kFeedbackWeekup
    [self choseInterviewType:sender.tag];
}

- (void)setupNavBtn{
    SKChoseBtn *sk_rightBtn = [SKChoseBtn buttonWithType:UIButtonTypeCustom];
    [self.navBarView addSubview:sk_rightBtn];
    [sk_rightBtn sk_TitleFont:kFontWithSize(16) title:@"请选择" color:alpColor(@"#FFFFFF", 0.9)];
    [sk_rightBtn setImage:kImageInstance(@"chose_down") forState:UIControlStateNormal];
    [sk_rightBtn setImage:kImageInstance(@"chose_up") forState:UIControlStateSelected];
    sk_rightBtn.frame = CGRectMake(kScreenW-kSCALE_X(90), 0, kSCALE_X(90), 44);
    [sk_rightBtn addTarget:self action:@selector(choseTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.typeBtn = sk_rightBtn;
    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(kSCALE_X(15), 0, 44, 44)];
//    image.image = kImageInstance(@"icon_white");
//    [image addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadii:CGSizeMake(8, 8)];
//    [self.navBarView addSubview:image];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArr[indexPath.row].cellH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SKHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
//    cell.type = self.type;
    cell.homeItem = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kFeedbackWeekup
    [self pushChildrenViewController:@"SKInterviewDetail" parameterObject:@(indexPath.row) dataObject:self.dataArr];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    CATransform3D transform = CATransform3DIdentity;
////    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
//    transform = CATransform3DTranslate(transform, 0, 0, -50);//左边水平移动
//    transform = CATransform3DScale(transform, 0.6, 0.6, 0.6);//由小变大
//    cell.layer.transform = transform;
//    cell.layer.opacity = 0.3;
//    [UIView animateWithDuration:0.25 animations:^{
//        cell.layer.transform = CATransform3DIdentity;
//        cell.layer.opacity = 1;
//    }];
//}

- (void)showTypeView{
    [self.view addSubview:self.choseView];
    [UIView animateWithDuration:0.15 animations:^{
        self.choseView.alpha = 1.0;
    }] ;
}
- (void)dissmisTypeView{
    [UIView animateWithDuration:0.15 animations:^{
        self.choseView.alpha = 0.01;
    }completion:^(BOOL finished) {
        [self.choseView removeFromSuperview];
    }];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UIView *)choseView{
    if (!_choseView) {
        CGFloat height = kSCALE_X(40);
        _choseView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW-kSCALE_X(142), kNavH-5, kSCALE_X(120), height*viewTypeArr.count)];
        _choseView.backgroundColor = [UIColor whiteColor];
        [_choseView addRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft|UIRectCornerBottomRight withRadii:CGSizeMake(kSCALE_X(15), kSCALE_X(15))];
        _choseView.alpha = 0.01;
        NSArray *arr = viewTypeArr;
        for (int i = 0; i < arr.count; i ++) {
            UIButton *cellV = [UIButton buttonWithType:UIButtonTypeCustom];
            cellV.frame = CGRectMake(0, height*i, _choseView.sk_width, height);
            [_choseView addSubview:cellV];
            cellV.tag = i;
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCALE_X(15), kSCALE_X(8), kSCALE_X(24), kSCALE_X(24))];
            NSString *imgStr = [NSString stringWithFormat:@"list_chose_%d",i];
            imgV.image = kImageInstance(imgStr);
            [cellV addSubview:imgV];
            UILabel *titleL = [[UILabel alloc] init];
            [cellV addSubview:titleL];
            [titleL sk_TitleFont:kFontWithSize(14) title:arr[i] color:k3Color];
            [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imgV.mas_right).offset(kSCALE_X(12));
                make.centerY.equalTo(cellV);
            }];
            if (i != arr.count - 1) {
                UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(15), cellV.sk_heigth-0.5, cellV.sk_width-kSCALE_X(30), 0.5)];
                lineV.backgroundColor = kLineColor;
                [cellV addSubview:lineV];
            }
            [cellV addTarget:self action:@selector(choseViewType:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _choseView;
}
- (SKTypeChoseV *)guideV{
    if (!_guideV) {
        _guideV = [[SKTypeChoseV alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    }
    return _guideV;
}
@end


@implementation SKChoseBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView.sk_centerX <  self.titleLabel.sk_centerX) {
        [self.titleLabel sizeToFit];
        self.imageView.sk_size = CGSizeMake(kSCALE_X(8), kSCALE_X(8));
        self.titleLabel.sk_x = 0;
        self.titleLabel.sk_width = self.sk_width-kSCALE_X(22);
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.imageView.sk_x = self.sk_width-kSCALE_X(18);
        self.imageView.sk_centerY = self.titleLabel.sk_centerY;
    }
}

@end
