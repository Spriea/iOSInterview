//
//  SKBasicListVC.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/11.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKBasicListVC.h"
#import "SKTypeChoseV.h"
#import "SKHomeCell.h"
#import "SKCateBasicItem.h"
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>
#import <AnyThinkBanner/AnyThinkBanner.h>

#define kUserPosition @"user_position"
#define kBannerList @"b60859bf15ae77"
static NSArray *viewTypeArr;
static NSArray *titlARr;
@interface SKBasicListVC () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) SKCateBasicItem *basicItem;


@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray <SKHomeItem *>*dataArr;

@property (assign, nonatomic) SKInterviewType type;

@property (strong, nonatomic) UIView *topBannerV;

@end

@implementation SKBasicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.basicItem = self.parameterObject;
    self.title = self.basicItem.book;
    kWEAK_SELF(weakS)
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakS setupInitData];
    });
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.sk_view.sk_heigth) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[SKHomeCell class] forCellReuseIdentifier:@"basicCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(kSCALE_X(5), 0, kSCALE_X(5), 0);
    tableView.showsVerticalScrollIndicator = NO;
    [self.sk_view addSubview:tableView];
    self.tableView = tableView;
    [SKTableManager setExtraCellLineHidden:self.tableView];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakS loadData];
    }];
    
    self.topBannerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*0.25)];
    tableView.tableHeaderView = self.topBannerV;
    [[ATAdManager sharedManager] loadADWithPlacementID:kBannerList extra:@{kATAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(kScreenW, kScreenW*0.25)]} delegate:self];
}

#pragma mark - loading delegate
- (void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    if ([kImageKey isEqualToString:placementID]) {
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementID inViewController:self delegate:self];
    }else if ([kBannerList isEqualToString:placementID]){
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
    if ([[ATAdManager sharedManager] bannerAdReadyForPlacementID:kBannerList]) {
//        [StatisticalTool analysisConfigEvent:@"banner_update_count" label:@"首页"];
    //Retrieve banner view
        ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:kBannerList];
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupInitData{
    kWEAK_SELF(weakS)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakS.dataArr = weakS.basicItem.summary;
        [weakS.dataArr enumerateObjectsUsingBlock:^(SKHomeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.avatar = weakS.basicItem.avatar;
            obj.cellH = kSCALE_X(126);
            obj.isCollection = [SKHomeItem jugeIDCollect:obj.ID];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakS.tableView reloadData];
        });
    });
}
- (void)loadData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArr[indexPath.row].cellH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SKHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    cell.homeItem = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kFeedbackWeekup
    [self pushChildrenViewController:@"SKInterviewDetail" parameterObject:@(indexPath.row) dataObject:self.dataArr];
}

@end

