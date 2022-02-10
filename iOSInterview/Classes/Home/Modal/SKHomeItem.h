//
//  SKHomeItem.h
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKHomeItem : NSObject<NSCoding>
//{"id":"666","title":"如果项目开始容错处理没做,如何防止拦截潜在的崩溃？","source":"","updated":"1529762786","html_md5":"dcc0bce506b84b9b03fdc9579cd75b33"}
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *updated;
@property (strong, nonatomic) NSString *html_md5;

@property (assign, nonatomic) CGFloat cellH;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) BOOL isCollection;

//@property (strong, nonatomic) NSString *bookName;
@property (strong, nonatomic) NSString *file;
@property (strong, nonatomic) NSString *avatar;

+ (void)addCollectItem:(SKHomeItem *)item;
+ (void)removeCollectItem:(SKHomeItem *)item;
+ (BOOL)jugeIDCollect:(NSString *)ID;
+ (NSMutableArray *)getCollectArr;
@end

NS_ASSUME_NONNULL_END
