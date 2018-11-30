//
//  ZHHTTPManager.m
//  MiddleSchool
//
//  Created by 王延磊 on 2017/12/19.
//  Copyright © 2017年 王延磊. All rights reserved.
//

#import "ZHHTTPManager.h"
#import "CheckNet.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#define kTimeOutInterval 20
// 对象是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#define NetworkReconnection  @"NetworkReconnection"//断网重新连接以后发送通知，重新网络请求
@interface ZHHTTPManager()
@property (nonatomic,strong,nonnull)CheckNet *checkNET;//检测网络是否可用。YES可用NO无连接
@property (nonatomic,assign)BOOL everbreak;
@end
@implementation ZHHTTPManager
+ (instancetype)sharedManager {
    
    static ZHHTTPManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        [ZHHTTPManager alloc].everbreak = NO;
        manager = [[ZHHTTPManager alloc] initWithBaseURL:nil];
    });
    [manager checkNetworking];
    return manager;
}


-(instancetype)initWithBaseURL:(NSURL *)url{
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer.timeoutInterval = kTimeOutInterval;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
        self.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    switch (method) {
            
        case GET:{
            [self GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]initWithCapacity:3];
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSData *data = (NSData *)responseObject;
                    NSError *err;
                    dic10 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
                }else{
                    dic10 = (NSMutableDictionary *)responseObject;
                }
                //                NSDictionary *dic11 = dic10[@"message"];
                success(dic10,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSDictionary *dic = (NSDictionary *)error.userInfo;
                NSData *data2 = dic[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *message2;
                id message3;
                if (NotNilAndNull(data2)) {
                    message3 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
                    if ([message3 isKindOfClass:[NSDictionary class]]) {
                        message2 = (NSDictionary *)message3;
                    }else if([message3 isKindOfClass:[NSArray class]]){
                        
                        NSArray *date = (NSArray *)message3;
                        if (date.count > 0) {
                            message2 = (NSDictionary *)date[0];
                        }
                    }
                }else{
                    message2 = @{@"message":error.localizedDescription};
                }
                failure(message2,error);
                
            }];
            break;
        }
        case POST:{
            //
            
            
            AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:
                                        AFSSLPinningModeNone];//AFSSLPinningModeNone, 是默认的认证方式，只会在系统的信任的证书列表中对服务端返回的证书进行验证
            self.securityPolicy = policy;
            
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                //                NSLog(@"JSON: %@", responseObject);
                NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]initWithCapacity:3];
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSData *data = (NSData *)responseObject;
                    NSError *err;
                    dic10 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
                }else{
                    dic10 = (NSMutableDictionary *)responseObject;
                }
                //                success(dic10,nil);
//                NSDictionary *dic11 = dic10[@"message"];
                
                success(dic10,nil);
                
                
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                
                NSDictionary *dic = (NSDictionary *)error.userInfo;
                NSData *data = dic[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *message2;
                id message3;
                if (NotNilAndNull(data)) {
                    message3 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    if ([message3 isKindOfClass:[NSDictionary class]]) {
                        
                        message2 = (NSDictionary *)message3;
                    }else if([message3 isKindOfClass:[NSArray class]]){
                        
                        NSArray *date = (NSArray *)message3;
                        if (date.count > 0) {
                            message2 = (NSDictionary *)date[0];
                        }
                    }
                }else{
                    
                    message2 = @{@"message":error.localizedDescription};
                }
                failure(message2,error);
            }];
            
            break;
        }
        case PUT:{
            
            
            
            [self PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //                NSDictionary *dict = (NSDictionary *)responseObject;
                //
                //                NSDictionary *dic = dict[@"message"];
                
                //                success(dic,nil);
                NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]initWithCapacity:3];
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSData *data = (NSData *)responseObject;
                    NSError *err;
                    dic10 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
                }else{
                    dic10 = (NSMutableDictionary *)responseObject;
                }
                
//                NSDictionary *dic11 = dic10[@"message"];
                
                success(dic10,nil);
                
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (task != nil){
                    NSDictionary *dic = (NSDictionary *)error.userInfo;
                    NSData *data = dic[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *message2;
                    id message3;
                    if (NotNilAndNull(data)) {
                        message3 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        
                        if ([message3 isKindOfClass:[NSDictionary class]]) {
                            
                            message2 = (NSDictionary *)message3;
                        }else if([message3 isKindOfClass:[NSArray class]]){
                            
                            NSArray *date = (NSArray *)message3;
                            if (date.count > 0) {
                                message2 = (NSDictionary *)date[0];
                            }
                            
                        }
                    }else{
                        
                        message2 = @{@"message":error.localizedDescription};
                    }
                    
                    failure(message2,error);
                }
            }];
            break;
        }
        case DELETE:{
            
            [self DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *dict = (NSDictionary *)responseObject;
                
                NSDictionary *dic = dict[@"message"];
                
                success(dic,nil);
                NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]initWithCapacity:3];
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSData *data = (NSData *)responseObject;
                    NSError *err;
                    dic10 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
                }else{
                    dic10 = (NSMutableDictionary *)responseObject;
                }
                
//                NSDictionary *dic11 = dic10[@"message"];
                
                success(dic10,nil);
                
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (task != nil){
                    NSDictionary *dic = (NSDictionary *)error.userInfo;
                    NSData *data = dic[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *message2;
                    id message3;
                    if (NotNilAndNull(data)) {
                        message3 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        
                        if ([message3 isKindOfClass:[NSDictionary class]]) {
                            
                            message2 = (NSDictionary *)message3;
                        }else if([message3 isKindOfClass:[NSArray class]]){
                            
                            NSArray *date = (NSArray *)message3;
                            if (date.count > 0) {
                                message2 = (NSDictionary *)date[0];
                            }
                            
                        }
                    }else{
                        
                        message2 = @{@"message":error.localizedDescription};
                    }
                    
                    failure(message2,error);
                }
            }];
            
        }
            
            
        default:
            break;
    }
    
    
    
}

-(void)checkNetworking{
    __block typeof(self) this = self;
    self.checkNET = [CheckNet shareInstance];
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知
                this.checkNET.checkNET = YES;
                this.checkNET.type = 1;
                
                if (self.everbreak) {
                    // 断网重连以后发送网络请求通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkReconnection object:nil];
                }
                this.everbreak = NO;
                
                break;
            case AFNetworkReachabilityStatusNotReachable://无连接
                this.checkNET.checkNET = NO;
                this.checkNET.type = 2;
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:@"手机未联网"];
                this.everbreak = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://3G
                this.checkNET.checkNET = YES;
                this.checkNET.type = 3;
                if (this.everbreak) {
                    // 断网重连以后发送网络请求通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkReconnection object:nil];
                }
                this.everbreak = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi
                self.checkNET.checkNET = YES;
                if (this.everbreak) {
                    // 断网重连以后发送网络请求通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkReconnection object:nil];
                }
                this.everbreak = NO;
                this.checkNET.type = 4;
                
                break;
                
            default:
                break;
        }
        
    }];
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkReconnection object:nil];
    
    
}
@end
