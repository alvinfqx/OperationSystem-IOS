//
//  NSObject+Network.m
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "NSObject+Network.h"

@implementation NSObject (Network)

+ (AFHTTPSessionManager *)sharedAFManager{
    static AFHTTPSessionManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval=30;
//        manager.responseSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"text/plain", nil];//,
//         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil,nil];
        //[manager.requestSerializer setValue:nil forHTTPHeaderField:nil];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
       [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        

    });
    return manager;
}





+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle{
    return [[self sharedAFManager] GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        completionHandle(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle{
    return [[self sharedAFManager] POST:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        completionHandle(nil, error);
    }];
}

@end














