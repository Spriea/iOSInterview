//
//  SQFeedbackTouch.m
//  SQPuzzleClub
//
//  Created by Somer.King on 2020/6/17.
//  Copyright © 2020 Somer.King. All rights reserved.
//

#import "SQFeedbackTouch.h"


@interface SQFeedbackTouch ()

@property (strong, nonatomic) UIImpactFeedbackGenerator *feedBackGenertor;
@property (strong, nonatomic) UIImpactFeedbackGenerator *tempFeedBack;

@end

@implementation SQFeedbackTouch

+ (instancetype)defaultFeedback{
    static dispatch_once_t onceToken;
    static SQFeedbackTouch *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SQFeedbackTouch alloc] init];
        if (@available(iOS 10.0, *)) {
            if (@available(iOS 13.0, *)) {
                instance.feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft];
            } else {
                instance.feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
            }
        } else {
        }
    });
    return instance;
}

- (void)feedbackWeekup{
//    if (![SQSettingManager defaultSetting].isFeedback) {
//        [self.feedBackGenertor impactOccurred];
//    }
    [self.feedBackGenertor impactOccurred];
}
- (void)feedbackLightWeekup{
    [self.tempFeedBack impactOccurred];
}

//- (UIImpactFeedbackGenerator *)tempFeedBack API_AVAILABLE(ios(10.0)){
//    if (!_tempFeedBack) {
//        if (@available(iOS 13.0, *)) {
//            _tempFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleRigid];
//        } else {
//            _tempFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
//        }
//    }
//    return _tempFeedBack;
//}

@end
