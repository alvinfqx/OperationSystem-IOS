//
//  sysysy.h
//  firstObject
//
//  Created by Eli on 2017/2/15.
//  Copyright © 2017年 Eli. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^CompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);
@interface HttpsHelper : NSObject<NSURLSessionDelegate>

/**
 *  get请求
 */
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 * post请求
 */
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end

