//
//  SKAddPersonView.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/7/12.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKAddPersonView : UIView

@property (nonatomic, copy) void (^agreeProtoclBlock)(void);

@property (strong, nonatomic) NSString *contStr;

@end
