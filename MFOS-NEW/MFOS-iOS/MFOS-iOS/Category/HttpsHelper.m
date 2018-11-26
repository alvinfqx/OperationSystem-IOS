//
//  sysysy.m
//  firstObject
//
//  Created by Eli on 2017/2/15.
//  Copyright © 2017年 Eli. All rights reserved.
//

#import "HttpsHelper.h"

static HttpsHelper *helper = nil;

@implementation HttpsHelper


//实例化对象
+ (instancetype)shareHelper
{
    @synchronized(self) {
        if (!helper) {
            helper = [[HttpsHelper alloc] init];
        }
        return helper;
    }
}

//get请求
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self shareHelper];
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:url];
    if ([parameters allKeys]) {
        [mutableUrl appendString:@"?"];
        for (id key in parameters) {
//            if ([(NSString*)key isEqualToString:@"Token"]) {
//                NSLog(@"%@---------paramsToken",[parameters objectForKey:key]);
//            }
            NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
//            if ([(NSString*)key isEqualToString:@"Token"]) {
//                NSLog(@"%@---------paramsToken",value);
//            }

        }
    }
    NSString *urlEnCode = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@------urlEnCode",urlEnCode);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEnCode]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:helper delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failureBlock(error);
            } else {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                successBlock(dic);
            }
        });
    }];
    [dataTask resume];
}

//post请求
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self shareHelper];
    NSURL *nsurl=[NSURL URLWithString:url];
//    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //设置请求方式
    request.HTTPMethod = @"POST";
    NSString *postStr = [HttpsHelper parseParams:parameters];
    NSLog(@"%@----------",postStr);
    //设置请求体
    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:helper delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failureBlock(error);
            } else {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                successBlock(dic);
            }
        });
    }];
    [dataTask resume];
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params
{
    NSLog(@"%@--------params",[params objectForKey:@"Token"]);
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    NSMutableArray *array = [NSMutableArray new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
        [result appendString:keyValueFormat];
        [array addObject:keyValueFormat];
    }
    //NSLog(@"%@--------params",[params objectForKey:@"Token"]);
    return result;
}

#pragma mark - NSURLSessionDelegate 代理方法

//主要就是处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = protectionSpace.serverTrust;
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

@end


