//
//  SKTypeChoseV.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/7.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKTypeChoseV.h"
#import "SQTitleBtn.h"

@implementation SKTypeChoseV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI:frame];
    }
    return self;
}

- (void)choseViewType:(UIButton *)sender{
    kFeedbackWeekup
//    sender.layer.borderColor = Color(@"#7A90FF").CGColor;
//    sender.layer.borderWidth = 1;
    if (self.choseResult) {
        self.choseResult(sender.tag);
    }
}

- (void)setupUI:(CGRect)frame{
    self.backgroundColor = kMainColor;
    
    UILabel *titleL = [[UILabel alloc] init];
    [titleL sk_TitleFont:kSemBFontSize(18) title:@"请选择面试题" color:nil];
    [self addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kStatusH+kSCALE_X(60)+kSafeBottom);
        make.centerX.equalTo(self);
    }];
    
    CGFloat w = kSCALE_X(90);
    CGFloat mar = (kScreenW-kSCALE_X(90)*3)/4;
    CGFloat y = kStatusH+kSCALE_X(140)+kSafeBottom;
    NSArray *arr = [SKCustomFunction getListArr];
    for (int i = 0; i < arr.count; i ++) {
        SQTitleBtn *cellV = [SQTitleBtn buttonWithType:UIButtonTypeCustom];
        int row = i / 3;
        int col = i % 3;
        cellV.frame = CGRectMake(mar+(mar+kSCALE_X(90))*col,y+(mar+kSCALE_X(90))*row,w,w);
        [self addSubview:cellV];
        cellV.imgSize = CGSizeMake(kSCALE_X(40), kSCALE_X(40));
        cellV.imgY = kSCALE_X(15);
        cellV.titleTopMar = kSCALE_X(8);
        cellV.layer.cornerRadius = kSCALE_X(10);
        cellV.backgroundColor = [UIColor whiteColor];
        cellV.tag = i;
        NSString *imgStr = [NSString stringWithFormat:@"list_chose_%d",i];
        [cellV setImage:kImageInstance(imgStr) forState:UIControlStateNormal];

        [cellV sk_TitleFont:kFontWithSize(14) title:arr[i] color:k3Color];
        [cellV addTarget:self action:@selector(choseViewType:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
