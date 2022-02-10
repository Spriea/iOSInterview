//
//  SKTypeChoseV.h
//  iOSInterview
//
//  Created by Somer.King on 2021/4/7.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKTypeChoseV : UIView

@property (copy, nonatomic) void(^choseResult)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
