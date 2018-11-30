//
//  CheckNet.h
//  GPD
//
//  Created by 王延磊 on 16/5/5.
//  Copyright © 2016年 王延磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNet : NSObject
@property (nonatomic,assign)BOOL checkNET;//判断手机是否联网，以及网络类型
@property (nonatomic,assign)int type;//网络类型 1 未知  2 无连接  3 流量 4 WiFi  用于视频播放，或者视频通话提醒用户注意流量使用情况
+(CheckNet *) shareInstance;
@end
