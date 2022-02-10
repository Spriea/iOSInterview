//
//  Common.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/19.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

// 屏幕适配
#define kSCALE_X(x) ((kScreenW/375.f)*x)
//#define kSCALE360_X(x) ((kScreenW/360.f)*x)
//#define kSCALE_X(x) [SKCustomFunction getSacleSize:x]

#define kFeedbackWeekup [[SQFeedbackTouch defaultFeedback] feedbackWeekup];

// 屏幕适配
//#define kSCALE_IPHONE_X(x) kSCALE_X(x)

//#define kSCALE_WithX(x) [SKCustomFunction getSacleWith:x]

// 弱化控制器指针
#define kWEAK_SELF(X) __weak typeof(self) X = self;

// 当前屏幕尺寸
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

// 快捷颜色设置
#define Color(hexString) [UIColor colorWithHexString:hexString alpha:1.0]
#define alpColor(hexString, alp) [UIColor colorWithHexString:hexString alpha:alp]
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.00f green:g/255.00f blue:b/255.00f alpha:a]

// 快速生成图片
#define kImageInstance(nameString) [UIImage imageNamed:nameString]

// 快捷获取系统控件高度
#define kTabH self.tabBarController.tabBar.frame.size.height
#define kNavH ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)
#define kStatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarH self.navigationController.navigationBar.frame.size.height

// 根据不同屏幕设置等比例缩放字体
#define FONT_SIZE(size) kSCALE_X(size)
#define kFontWithSize(size) [UIFont systemFontOfSize:kSCALE_X(size)]
#define kMedFontSize(size) [UIFont systemFontOfSize:kSCALE_X(size) weight:UIFontWeightMedium]
#define kSemBFontSize(size) [UIFont systemFontOfSize:kSCALE_X(size) weight:UIFontWeightSemibold]
#define kBlodFontSize(size) [UIFont systemFontOfSize:kSCALE_X(size) weight:UIFontWeightBold]
#define kAlertMsg(msg) [SKCustomFunction alertSheetWithTitle:@"" message:msg confTitle:@"确认" confirmHandler:^(UIAlertAction *action) {} cancleHandler:nil];

/**不选中cell*/
#define kDeSelectedCell [tableView deselectRowAtIndexPath:indexPath animated:NO];

/**判断系统版本大于某个版本*/
#define IOS_Later(version) [[UIDevice currentDevice].systemVersion doubleValue] >= (version) ? YES : NO

/**判断是iPhone还是iPad（纯iPhone开发不用使用）*/
#define kIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

/**判断留海*/
#define kSafeTop    [SKCustomFunction getTopSafe]
#define kSafeBottom [SKCustomFunction getBottomSafe]

// string
#define NIL2EMPTY(t) _nilToEmpty(t)
static inline NSString* _nilToEmpty(NSString *text){
    if(nil == text || [text class]==[NSNull class] || [@"<NULL>" isEqualToString:text]){
        text = @"";
    }
    return text;
}

#define kHomeRefresh [[NSNotificationCenter defaultCenter] postNotificationName:noti_Home_Refresh object:nil];
