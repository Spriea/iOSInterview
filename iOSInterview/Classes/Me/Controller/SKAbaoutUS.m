//
//  SKAbaoutUS.m
//  ProjectInit
//
//  Created by Somer.King on 2021/3/11.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKAbaoutUS.h"
#import "EKWKWebview.h"

@interface SKAbaoutUS ()

@end

@implementation SKAbaoutUS

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"面试题大全";
    self.sk_view.backgroundColor = kBackColor;
    UIView *setView = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(14), kSCALE_X(20), kScreenW-kSCALE_X(14)*2, kSCALE_X(60)*3)];
    setView.backgroundColor = [UIColor whiteColor];
    setView.layer.cornerRadius = kSCALE_X(10);
    setView.clipsToBounds = YES;
    [self.sk_view addSubview:setView];
    
    NSArray *titleArr = @[@"联系我们",@"用户协议",@"隐私政策"];
    
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *cellV = [UIButton buttonWithType:UIButtonTypeCustom];
        cellV.frame = CGRectMake(0, 0+kSCALE_X(60)*i, setView.sk_width, kSCALE_X(60));
        [setView addSubview:cellV];
        [cellV addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        cellV.tag = i;
        SKImgView *rightImg = [[SKImgView alloc] init];
        rightImg.image = kImageInstance(@"right_row");
        [setView addSubview:rightImg];
        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cellV).offset(-kSCALE_X(27));
            make.width.mas_equalTo(kSCALE_X(8));
            make.height.mas_equalTo(kSCALE_X(14));
            make.centerY.equalTo(cellV);
        }];
        
        UILabel *contL = [[UILabel alloc] init];
        contL.numberOfLines = 0;
        [contL sk_TitleFont:kFontWithSize(16) title:titleArr[i] color:k3Color];
        [setView addSubview:contL];
        [contL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cellV).offset(kSCALE_X(30));
            make.centerY.equalTo(cellV);
        }];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(kSCALE_X(27), kSCALE_X(61)+kSCALE_X(60)*i, cellV.sk_width-kSCALE_X(27)*2, 0.5)];
        lineV.backgroundColor = Color(@"#E2E2E2");
        [setView addSubview:lineV];
    }
}

- (void)clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
            [self pushChildrenViewController:@"SKContactVC"];
        }break;
        case 1:{
            EKWKWebview *webV = [[EKWKWebview alloc] init];
            webV.webHtmlUrl = [@"https://www.yuque.com/docs/share/0c6f886d-ee64-4bf3-8dd4-7e933bb06508?%23 %E3%80%8A%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE%E3%80%8B" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self.navigationController pushViewController:webV animated:YES];
        }break;
        case 2:{
            EKWKWebview *webV = [[EKWKWebview alloc] init];
            NSString *urlS = [@"https://www.yuque.com/docs/share/d8bad8fe-5193-41e9-9a77-6e579c710026?%23 %E3%80%8A%E9%9D%A2%E8%AF%95%E9%A2%98%E5%A4%A7%E5%85%A8%E9%9A%90%E7%A7%81%E6%94%BF%E7%AD%96%E3%80%8B" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            webV.webHtmlUrl = urlS;
            SKLog(@"%@",urlS);
            [self.navigationController pushViewController:webV animated:YES];
        }break;
        default:
            break;
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
