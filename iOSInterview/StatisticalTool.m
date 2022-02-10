//
//  StatisticalTool.h
//  SQPuzzleClub
//
//  Created by Somer.King on 2020/6/22.
//  Copyright © 2020 Somer.King. All rights reserved.
//

#import "StatisticalTool.h"
#import <UMCommon/UMConfigure.h>
#import <UMCommon/MobClick.h>

@interface AnalysisConfig ()
@property (nonatomic) BOOL isProduction;
@end

@implementation AnalysisConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isProduction = YES;
#if DEBUG
        _isProduction = NO;
#endif
    }
    return self;
}
@end

@implementation StatisticalTool

+ (void)registerWithConfig:(AnalysisConfig *)config{
    [UMConfigure initWithAppkey:config.umengKey channel:config.channel];
}

+ (void)analysisConfigEvent:(NSString *)eventID {
    [MobClick event:eventID];
}

+ (void)analysisConfigEvent:(NSString *)eventID label:(NSString *)label{
    if (!label.length) {
        [self analysisConfigEvent:eventID];
        return;
    }
    [MobClick event:eventID label:label];
}

+ (void)analysisConfigEvent:(NSString *)eventID attributes:(NSDictionary *)attributes{
    [MobClick event:eventID attributes:attributes];
}

@end
