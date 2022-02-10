//
//  SKTableManager.m
//  DaoJiaLe
//
//  Created by Somer.King on 16/12/15.
//  Copyright © 2016年 Somer. All rights reserved.
//

#import "SKTableManager.h"

@implementation SKTableManager

+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

+ (void)setInitTableView:(UITableView *)tableView target:(id)target{
    
}

@end
