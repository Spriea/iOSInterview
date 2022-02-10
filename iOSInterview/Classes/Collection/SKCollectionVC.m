//
//  SKDiscoverVC.m
//  iOSInterview
//
//  Created by Somer.King on 2021/2/26.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKCollectionVC.h"
#import "SKTypeChoseV.h"
#import "SKHomeCell.h"

#define kUserPosition @"user_position"
static NSArray *titlARr;
@interface SKCollectionVC () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *choseView;
@property (weak, nonatomic) UIButton *typeBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) SKTypeChoseV *guideV;
@property (strong, nonatomic) NSMutableArray <SKHomeItem *>*dataArr;

@property (strong, nonatomic) UIView *nodataV;

@end

@implementation SKCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏列表";
    self.sk_view.backgroundColor = kBackColor;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.sk_view.sk_heigth-kTabH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[SKHomeCell class] forCellReuseIdentifier:@"collCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(kSCALE_X(5), 0, kSCALE_X(5), 0);
    tableView.showsVerticalScrollIndicator = NO;
    [self.sk_view addSubview:tableView];
    self.tableView = tableView;
    [SKTableManager setExtraCellLineHidden:self.tableView];
    kWEAK_SELF(weakS)
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakS loadData];
    }];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}


- (void)loadData{
    [self.tableView.mj_header endRefreshing];
    self.dataArr = [SKHomeItem getCollectArr];
    if (self.dataArr.count == 0) {
        self.nodataV.hidden = NO;
    }else{
        self.nodataV.hidden = YES;
    }
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
    SKHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collCell" forIndexPath:indexPath];
    cell.homeItem = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kFeedbackWeekup
    [self pushChildrenViewController:@"SKInterviewDetail" parameterObject:@(indexPath.row) dataObject:self.dataArr];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UIView *)nodataV{
    if (!_nodataV) {
        _nodataV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCALE_X(100), kSCALE_X(100))];
        SKImgView *imgV = [[SKImgView alloc] initWithFrame:CGRectMake(0, 0, kSCALE_X(100), kSCALE_X(65.5))];
        imgV.image = kImageInstance(@"wushuju");
        [_nodataV addSubview:imgV];
        
        [self.tableView addSubview:_nodataV];
        _nodataV.center = CGPointMake(kScreenW*0.5, self.sk_view.sk_heigth*0.5-kSCALE_X(60));
        _nodataV.hidden = YES;
        UILabel *desL = [[UILabel alloc] init];
        [_nodataV addSubview:desL];
        [desL sk_TitleFont:kFontWithSize(14) title:@"您还没有收藏" color:kAColor];
        [desL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgV.mas_bottom).offset(kSCALE_X(6));
            make.centerX.equalTo(imgV);
        }];
    }
    return _nodataV;
}
@end

