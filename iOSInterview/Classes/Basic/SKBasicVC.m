//
//  SKBasicVC.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKBasicVC.h"
#import <MMMarkdown/MMMarkdown.h>
#import "SKCateBasicItem.h"
#import "SQTitleBtn.h"

@interface SKBasicVC ()

@property (strong, nonatomic) NSArray <SKCateBasicItem *>*dataArr;

@end

@implementation SKBasicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"计算机基础";
    
//    summary
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"summary" ofType:@"json" inDirectory:@"basic"];
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    NSError *error;
    NSArray *titleArr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    self.dataArr = [SKCateBasicItem mj_objectArrayWithKeyValuesArray:titleArr];
    [self setupUI];
}

- (void)choseViewType:(UIButton *)sender{
    kFeedbackWeekup
    [self pushChildrenViewController:@"SKBasicListVC" parameterObject:self.dataArr[sender.tag]];
    [StatisticalTool analysisConfigEvent:@"basic_click" label:self.dataArr[sender.tag].book];
}

- (void)setupUI{
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.sk_view.sk_heigth-kTabH)];
    [self.sk_view addSubview:scrollV];
    scrollV.showsVerticalScrollIndicator = NO;
    CGFloat w = kSCALE_X(130);
    CGFloat mar = (kScreenW-w*2)/3;
    CGFloat y = mar;
    for (int i = 0; i < self.dataArr.count; i ++) {
        SQTitleBtn *cellV = [SQTitleBtn buttonWithType:UIButtonTypeCustom];
        int row = i / 2;
        int col = i % 2;
        cellV.frame = CGRectMake(mar+(mar+w)*col,y+(mar+w)*row,w,w);
        [scrollV addSubview:cellV];
        cellV.imgSize = CGSizeMake(kSCALE_X(54), kSCALE_X(54));
        cellV.imgY = kSCALE_X(20);
        cellV.titleTopMar = kSCALE_X(14);
        cellV.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cellV.layer.shadowColor = alpColor(@"#000000", 0.15).CGColor;
        cellV.layer.shadowOffset = CGSizeZero;
        cellV.layer.shadowOpacity = 1;
        cellV.layer.cornerRadius = kSCALE_X(15);
        cellV.backgroundColor = [UIColor whiteColor];
        cellV.tag = i;
        [cellV setImage:kImageInstance(self.dataArr[i].avatar) forState:UIControlStateNormal];

        [cellV sk_TitleFont:kMedFontSize(16) title:self.dataArr[i].book color:kMainColor];
        [cellV addTarget:self action:@selector(choseViewType:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == self.dataArr.count-1) {
            scrollV.contentSize = CGSizeMake(0, cellV.sk_bottom+mar);
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
