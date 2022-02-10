//
//  SKTableManager.h
//  DaoJiaLe
//
//  Created by Somer.King on 16/12/15.
//  Copyright © 2016年 Somer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTableManager : NSObject

// 隐藏多余的tableView cell
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

// 初始化tableView最基本设置
+ (void)setInitTableView:(UITableView *)tableView target:(id)target;

@end
