//
//  SKCateBasicItem.h
//  iOSInterview
//
//  Created by Somer.King on 2021/4/11.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKHomeItem;
NS_ASSUME_NONNULL_BEGIN
/**
 "book":"计算机网络",
 "category":"basic",
 "bookid":"101",
 "avatar":"network",
 "path":"interview-book/basic/network/",
 "summary":Array[6]
 */
@interface SKCateBasicItem : NSObject

@property (strong, nonatomic) NSString *book;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSArray <SKHomeItem *>*summary;

@end

NS_ASSUME_NONNULL_END
