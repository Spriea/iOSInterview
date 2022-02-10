//
//  SKHTTPError.h
//  EduCare for Parents
//
//  Created by Somer.King on 2018/1/21.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

/**
 * 宏定义实现单例模型
 */

#if !__has_feature(objc_arc)

    // .h文件
    #define SKInstanceH(name) + (instancetype)shared##name;
    // .m文件、
    #define SKInstanceM(name) \
    static id _instance;\
    \
    + (instancetype)allocWithZone:(struct _NSZone *)zone\
    {\
    static dispatch_once_t once;\
    dispatch_once(&once, ^{\
    _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
    }\
    \
    + (instancetype)shared##name\
    {\
    static dispatch_once_t once;\
    dispatch_once(&once, ^{\
    _instance = [[self alloc] init];\
    });\
    \
    return _instance;\
    }\
    - (id)copyWithZone:(NSZone *)zone\
    {\
    return _instance;\
    } \
    - (oneway void)release{ } \
    - (instancetype)retain{ return self; } \
    - (NSUInteger)retainCount{ return 1; } \
    - (instancetype)autorelease{ return self; }

#else

    // .h文件
    #define SKInstanceH(name) + (instancetype)shared##name;
    // .m文件、
    #define SKInstanceM(name) \
    static id _instance;\
    \
    + (instancetype)allocWithZone:(struct _NSZone *)zone\
    {\
    static dispatch_once_t once;\
    dispatch_once(&once, ^{\
    _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
    }\
    \
    + (instancetype)shared##name\
    {\
    static dispatch_once_t once;\
    dispatch_once(&once, ^{\
    _instance = [[self alloc] init];\
    });\
    \
    return _instance;\
    }\
    - (id)copyWithZone:(NSZone *)zone\
    {\
    return _instance;\
    }

#endif
