//
//  ZHHTTPManager.h
//  MiddleSchool
//
//  Created by 王延磊 on 2017/12/19.
//  Copyright © 2017年 王延磊. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>



@interface ZHHTTPManager : AFHTTPSessionManager


//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic, NSError *error);

//请求失败回调block
typedef void (^requestFailureBlock)(NSDictionary *dic,NSError *error);


+ (instancetype)sharedManager;


/**
 网络请求

 @param method 请求方式
 @param path 请求路径
 @param params 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 */
- (void)requestWithMethod:(HTTPMethod)method
WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure;
@end
