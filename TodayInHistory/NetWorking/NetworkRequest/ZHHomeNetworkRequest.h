//
//  HomeNetworkRequest.h
//  MiddleSchool
//
//  Created by 王延磊 on 2017/12/19.
//  Copyright © 2017年 王延磊. All rights reserved.
//

#import "ZHHTTPManager.h"

@interface ZHHomeNetworkRequest : ZHHTTPManager

/**
 首页
 
 @param para 参数
 @param block 回调
 */
+ (void)home_RequestWithParas:(NSDictionary *)para WithBlock:(void (^)(NSDictionary *posts,NSError *error))block;


/**
详情
 
 @param para 参数
 @param block 回调
 */
+ (void)detail_RequestWithParas:(NSDictionary *)para
                     WithBlock:(void (^)(NSDictionary *posts,NSError *error))block;


/**
 修改密码
 
 @param para 参数
 @param block 回调
 */
+ (void)changePassWithParas:(NSDictionary *)para
                  WithBlock:(void (^)(NSDictionary *posts,NSError *error))block;



/**
 获取消息
 
 @param para 参数
 @param block 回调
 */
+ (void)getMessage_RequestWithParas:(NSDictionary *)para
                          WithBlock:(void (^)(NSDictionary *posts,NSError *error))block;



/**
 获取图书分类
 
 @param para 参数
 @param block 回调
 */
+ (void)getBookCatalog_RequestWithParas:(NSDictionary *)para
                              WithBlock:(void (^)(NSDictionary *posts,NSError *error))block;

/**
 获取图书分类列表
 
 @param para 参数
 @param block 回调
 */
+ (void)getBookList_RequestWithParas:(NSDictionary *)para
                           WithBlock:(void (^)(NSDictionary *posts,NSError *error))block;


@end
