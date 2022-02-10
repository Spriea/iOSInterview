//
//  NSBundle+RDLanguage.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/2/23.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "NSBundle+RDLanguage.h"
#import <objc/runtime.h>

static const NSString *RDBundleKey = @"RDLanguageKey";

@interface BundleEx : NSBundle

@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &RDBundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}
@end

@implementation NSBundle (RDLanguage)

+ (void)setLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
    id value = language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil;
    objc_setAssociatedObject([NSBundle mainBundle], &RDBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
