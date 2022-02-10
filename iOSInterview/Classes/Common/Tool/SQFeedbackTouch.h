//
//  SQFeedbackTouch.h
//  SQPuzzleClub
//
//  Created by Somer.King on 2020/6/17.
//  Copyright © 2020 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQFeedbackTouch : NSObject

+ (instancetype)defaultFeedback;
- (void)feedbackWeekup;
- (void)feedbackLightWeekup;

@end

NS_ASSUME_NONNULL_END
