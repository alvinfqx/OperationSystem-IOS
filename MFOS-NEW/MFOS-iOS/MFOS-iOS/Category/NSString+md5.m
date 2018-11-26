//
//  NSString+md5.m
//  酷跑
//
//  Created by tarena36 on 15/12/4.
//  Copyright © 2015年 tarena36. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (md5)

-(NSString*)md5Str
{
    const char* myPassword=[self UTF8String];
    unsigned char md5c[16];
    CC_MD5(myPassword, (CC_LONG)strlen(myPassword), md5c);
    NSMutableString *md5Str=[NSMutableString string];
//    NSLog(@"%c----------1",md5c);
    for (int i=0; i<16; i++) {
        [md5Str appendFormat:@"%02x",md5c[i]];
    }
    return [md5Str copy];
}

-(NSString*)md5StrXor
{
    const char* myPassword=[self UTF8String];
    unsigned char md5c[16];
    CC_MD5(myPassword, (CC_LONG)strlen(myPassword), md5c);
    NSMutableString *md5Str=[NSMutableString string];
    [md5Str appendFormat:@"%02x",md5c[0]];
//    NSLog(@"%c----------2",md5c);
    for (int i=1; i<16; i++) {
        [md5Str appendFormat:@"%02x",md5c[i]^md5c[0]];
    }
    //NSLog(@"%@----------",md5Str);
    return [md5Str copy];
}

/*
 全局获取本地的Token值和username值
 使用+的原因：不需要声明在调用
 传一个bool参数来区别获取的是token还是username
 */
+(NSString*)tokenStringAndusername:(BOOL)isToken{
    //获取本地存储的值
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(isToken){
        NSString* tokenStr = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"Token"]];
        return [tokenStr copy];
    }
    else{
        NSString* usernameStr = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"username"]];
        return [usernameStr copy];
    }
}



@end




