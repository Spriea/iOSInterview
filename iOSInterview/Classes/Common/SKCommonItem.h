//
//  SKCommonItem.h
//  ProjectInit
//
//  Created by Somer.King on 2021/3/11.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKCommonItem : NSObject<NSCoding>

@property (assign, nonatomic) NSInteger is_force;
@property (assign, nonatomic) NSInteger version;
@property (assign, nonatomic) NSInteger hasNoAD;
@property (strong, nonatomic) NSString *downUrl;
@property (strong, nonatomic) NSString *updateContent;
@property (assign, nonatomic) NSInteger c;

+ (void)saveComm:(SKCommonItem *)commItem;
+ (SKCommonItem *)getComm;

@end

NS_ASSUME_NONNULL_END
