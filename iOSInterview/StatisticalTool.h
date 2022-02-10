//
//  StatisticalTool.h
//  SQPuzzleClub
//
//  Created by Somer.King on 2020/6/22.
//  Copyright © 2020 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalysisConfig : NSObject

@property (nonatomic, copy) NSString *umengKey;

@property (nonatomic, copy) NSString *channel;
@end

@interface StatisticalTool : NSObject

//初始化
+ (void)registerWithConfig:(AnalysisConfig *)config;

+ (void)analysisConfigEvent:(NSString *)eventID;

+ (void)analysisConfigEvent:(NSString *)eventID label:(NSString *)label;

+ (void)analysisConfigEvent:(NSString *)eventID attributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
