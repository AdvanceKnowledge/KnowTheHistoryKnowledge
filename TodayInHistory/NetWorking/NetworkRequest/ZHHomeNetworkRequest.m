//
//  HomeNetworkRequest.m
//  MiddleSchool
//
//  Created by 王延磊 on 2017/12/19.
//  Copyright © 2017年 王延磊. All rights reserved.
//

#import "ZHHomeNetworkRequest.h"
#import "Detail_Model.h"
#import "MJExtension.h"
static ZHHomeNetworkRequest *manager  = nil;

// 热门活动 URL

@implementation ZHHomeNetworkRequest

#pragma mark-
#pragma mark-获取热门活动列表
+ (void)home_RequestWithParas:(NSDictionary *)para
                               WithBlock:(void (^)(NSDictionary *posts,NSError *error))block{
    
    NSString *url = @"http://api.juheapi.com/japi/toh";
    
    manager = [ZHHomeNetworkRequest sharedManager];
    [manager requestWithMethod:GET
                      WithPath:[NSString stringWithFormat:@"%@",url]
                    WithParams:para
              WithSuccessBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,nil);
                  }
              } WithFailurBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,error);
                  }
              }];
}


+ (void)detail_RequestWithParas:(NSDictionary *)para
                        WithBlock:(void (^)(NSDictionary *posts,NSError *error))block{

    NSString *url = @"http://api.juheapi.com/japi/tohdet";
    
    manager = [ZHHomeNetworkRequest sharedManager];
    [manager requestWithMethod:POST
                      WithPath:[NSString stringWithFormat:@"%@",url]
                    WithParams:para
              WithSuccessBlock:^(NSDictionary *dic, NSError *error) {
                  
                  
                  
                  if (block) {
                      block(dic,nil);
                  }
              } WithFailurBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,error);
                  }
              }];
}

+ (void)changePassWithParas:(NSDictionary *)para
                     WithBlock:(void (^)(NSDictionary *posts,NSError *error))block{
    
    NSString *url = [NSString stringWithFormat:@"http://132.232.131.121/node1/update.php?user_id=%@&status=3&user_pwd=%@",para[@"user_id"],para[@"pass"]];
    
    manager = [ZHHomeNetworkRequest sharedManager];
    [manager requestWithMethod:POST
                      WithPath:[NSString stringWithFormat:@"%@",url]
                    WithParams:para
              WithSuccessBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,nil);
                  }
              } WithFailurBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,error);
                  }
              }];
}


+ (void)getMessage_RequestWithParas:(NSDictionary *)para
                  WithBlock:(void (^)(NSDictionary *posts,NSError *error))block{
    
    NSString *url = @"http://132.232.131.121/node1/message.php";
    
    manager = [ZHHomeNetworkRequest sharedManager];
    [manager requestWithMethod:POST
                      WithPath:[NSString stringWithFormat:@"%@",url]
                    WithParams:para
              WithSuccessBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,nil);
                  }
              } WithFailurBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,error);
                  }
              }];
}


+ (void)getBookCatalog_RequestWithParas:(NSDictionary *)para
                          WithBlock:(void (^)(NSDictionary *posts,NSError *error))block{
    
    NSString *url = @"http://apis.juhe.cn/goodbook/catalog?key=8ba94619cd3794fe617851e7119aa314&dtype=json";
    
    manager = [ZHHomeNetworkRequest sharedManager];
    [manager requestWithMethod:POST
                      WithPath:[NSString stringWithFormat:@"%@",url]
                    WithParams:para
              WithSuccessBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,nil);
                  }
              } WithFailurBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,error);
                  }
              }];
}


+ (void)getBookList_RequestWithParas:(NSDictionary *)para
                              WithBlock:(void (^)(NSDictionary *posts,NSError *error))block{
    NSString *catalog_id = para[@"catalog_id"];
    int pn = para[@"pn"];
    
    NSString *url = [NSString stringWithFormat:@"http://apis.juhe.cn/goodbook/query?key=8ba94619cd3794fe617851e7119aa314&catalog_id=%@&pn=%d&rn=30",catalog_id,pn];
    
    manager = [ZHHomeNetworkRequest sharedManager];
    [manager requestWithMethod:POST
                      WithPath:[NSString stringWithFormat:@"%@",url]
                    WithParams:para
              WithSuccessBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,nil);
                  }
              } WithFailurBlock:^(NSDictionary *dic, NSError *error) {
                  if (block) {
                      block(dic,error);
                  }
              }];
}




@end
