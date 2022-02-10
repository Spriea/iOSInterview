//
//  SKHomeCell.h
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import "SKBaseTableViewCell.h"
#import "SKHomeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKHomeCell : SKBaseTableViewCell

@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) SKHomeItem *homeItem;

@end

NS_ASSUME_NONNULL_END
