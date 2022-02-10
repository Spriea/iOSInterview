//
//  SKHomeCell.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKHomeCell.h"

@interface SKHomeCell()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UIImageView *imgV;
@property (weak, nonatomic) UIButton *collBtn;

@end

@implementation SKHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupChildView];
    }
    return self;
}

- (void)setHomeItem:(SKHomeItem *)homeItem{
    _homeItem = homeItem;
    if (homeItem.file.length != 0) {
        self.titleL.text = homeItem.title;
        self.imgV.image = kImageInstance(homeItem.avatar);
        self.imgV.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
        self.collBtn.selected = homeItem.isCollection;
    }else{
        self.titleL.attributedText = [homeItem.title getAttributedStringWithLineSpace:kSCALE_X(6) kern:0];
        NSString *imgStr = [NSString stringWithFormat:@"list_chose_%zd",homeItem.type];
        self.imgV.transform = CGAffineTransformIdentity;
        self.imgV.image = kImageInstance(imgStr);
        self.collBtn.selected = homeItem.isCollection;
    }
}

- (void)collClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.homeItem.isCollection = sender.selected;
    if (sender.selected) {
        [SKHomeItem addCollectItem:self.homeItem];
    }else{
        [SKHomeItem removeCollectItem:self.homeItem];
    }
}

- (void)setupChildView{
    UIView *conteV = [[UIView alloc] init];
    conteV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:conteV];
    [conteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kSCALE_X(10));
        make.top.equalTo(self.contentView).offset(kSCALE_X(5));
        make.bottom.equalTo(self.contentView).offset(-kSCALE_X(5));
        make.right.equalTo(self.contentView).offset(-kSCALE_X(10));
    }];
    conteV.layer.shadowColor = alpColor(@"#000000", 0.15).CGColor;
    conteV.layer.shadowOffset = CGSizeZero;
    conteV.layer.shadowOpacity = 1;
    conteV.layer.cornerRadius = kSCALE_X(6);
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCALE_X(30), kSCALE_X(20), kSCALE_X(50), kSCALE_X(50))];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.alpha = 0.9;
    [self.contentView addSubview:imageV];
    self.imgV = imageV;
    
    UIButton *collectB = [UIButton buttonWithType:UIButtonTypeCustom];
    collectB.frame = CGRectMake(kScreenW-kSCALE_X(70), 0, kSCALE_X(50), kSCALE_X(50));
    collectB.contentEdgeInsets = UIEdgeInsetsMake(kSCALE_X(10), kSCALE_X(10), kSCALE_X(10), kSCALE_X(10));
    [collectB setImage:kImageInstance(@"collection_nor") forState:UIControlStateNormal];
    [collectB setImage:kImageInstance(@"collection_sel2") forState:UIControlStateSelected];
    [self.contentView addSubview:collectB];
    collectB.sk_centerY = imageV.sk_centerY;
    [collectB addTarget:self action:@selector(collClick:) forControlEvents:UIControlEventTouchUpInside];
    self.collBtn = collectB;
    UILabel *titleL = [[UILabel alloc] init];
    titleL.numberOfLines = 0;
    [titleL sk_TitleFont:kMedFontSize(18) title:@"" color:kMainColor];
    [self.contentView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kSCALE_X(30));
        make.top.equalTo(imageV.mas_bottom).offset(kSCALE_X(13));
        make.right.equalTo(self.contentView).offset(-kSCALE_X(25));
    }];
    self.titleL = titleL;
}

//- (void)setupChildView{
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCALE_X(15), kSCALE_X(10), kSCALE_X(24), kSCALE_X(24))];
//    [self.contentView addSubview:imageV];
//    self.imgV = imageV;
//
//    UILabel *titleL = [[UILabel alloc] init];
//    titleL.numberOfLines = 0;
//    [titleL sk_TitleFont:kFontWithSize(15) title:@"" color:[UIColor blackColor]];
//    [self.contentView addSubview:titleL];
//    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(kSCALE_X(48));
//        make.top.equalTo(self.contentView).offset(kSCALE_X(12.5));
//        make.right.equalTo(self.contentView).offset(-kSCALE_X(10));
//    }];
//    self.titleL = titleL;
//}

@end
