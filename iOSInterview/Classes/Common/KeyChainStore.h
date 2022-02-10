//
//  KeyChainStore.h
//  getUUID
//
//  Created by ckl@pmm on 16/9/18.
//  Copyright © 2016年 CKLPronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;



@end
