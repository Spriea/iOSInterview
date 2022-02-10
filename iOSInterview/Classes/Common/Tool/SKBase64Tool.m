//
//  SKBase64Tool.m
//  iOSInterview
//
//  Created by Somer.King on 2021/4/8.
//  Copyright © 2021 Somer.King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKBase64Tool.h"
 
@implementation SKBase64Tool
 
+ (NSString *)base64Encode:(NSString *)data{
    if (!data) {
        return nil;
    }
    NSData *sData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [sData base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}
 
+ (NSString *)base64Dencode:(NSString *)data{
    if (!data) {
        return nil;
    }
    NSData *sData = [[NSData alloc] initWithBase64EncodedString:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *dataString = [[NSString alloc] initWithData:sData encoding:NSUTF8StringEncoding];
    return dataString;
}
 
@end


