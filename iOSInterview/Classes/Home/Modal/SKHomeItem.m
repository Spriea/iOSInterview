//
//  SKHomeItem.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKHomeItem.h"

static NSMutableArray *sk_collectArr;
@implementation SKHomeItem

MJCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

- (NSString *)ID{
    if (_ID.length == 0) {
        _ID = _file;
    }
    return _ID;
}

+ (void)addCollectItem:(SKHomeItem *)item{
    [sk_collectArr insertObject:item atIndex:0];
    [self saveCollectArr:sk_collectArr];
    if (item.file.length == 0) {
        [StatisticalTool analysisConfigEvent:@"collect_title_" label:[NSString stringWithFormat:@"%@_%@",[SKCustomFunction getListArr][item.type],item.title]];
    }else{
        [StatisticalTool analysisConfigEvent:@"collect_title_" label:[NSString stringWithFormat:@"%@_%@",item.avatar,item.file]];
    }
}
+ (void)removeCollectItem:(SKHomeItem *)item{
    for (int i = 0; i < sk_collectArr.count; i ++) {
        SKHomeItem *temp = sk_collectArr[i];
        if ([item.ID isEqualToString:temp.ID]) {
            [sk_collectArr removeObject:temp];
            [self saveCollectArr:sk_collectArr];
            break;
        }
    }
}

+ (void)saveCollectArr:(NSMutableArray *)arr{
    [NSKeyedArchiver archiveRootObject:arr toFile:[NSString saveStringWithOnly:@"collect_item"]];
}

+ (NSMutableArray *)getCollectArr{
    if (!sk_collectArr) {
        NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString saveStringWithOnly:@"collect_item"]];
        if (temp == nil) {
            temp = [NSMutableArray array];
        }
        sk_collectArr = temp;
    }
    return sk_collectArr;
}

+ (BOOL)jugeIDCollect:(NSString *)ID{
    if (sk_collectArr == nil) {
        [SKHomeItem getCollectArr];
    }
    for (int i = 0; i < sk_collectArr.count; i ++) {
        SKHomeItem *temp = sk_collectArr[i];
        if ([ID isEqualToString:temp.ID]) {
            return YES;
            break;
        }
    }
    return NO;
}

@end
