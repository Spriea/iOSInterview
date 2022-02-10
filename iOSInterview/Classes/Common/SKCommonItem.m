//
//  SKCommonItem.m
//  ProjectInit
//
//  Created by Somer.King on 2021/3/11.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKCommonItem.h"

static SKCommonItem *comm;
@implementation SKCommonItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"is_force":@"f",
        @"version":@"v",
        @"hasNoAD":@"a",
        @"downUrl":@"d",
        @"updateContent":@"u"
    };
}

MJCodingImplementation

+ (void)saveComm:(SKCommonItem *)commItem{
    comm = commItem;
    [NSKeyedArchiver archiveRootObject:commItem toFile:[NSString saveStringWithOnly:@"commonItem"]];
}

+ (SKCommonItem *)getComm{
    if (comm == nil) {
        SKCommonItem *temp = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString saveStringWithOnly:@"commonItem"]];
        comm = temp;
    }
    return comm;
}
@end
