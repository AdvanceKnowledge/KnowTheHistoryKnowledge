//
//  CheckNet.m
//  GPD
//
//  Created by 王延磊 on 16/5/5.
//  Copyright © 2016年 王延磊. All rights reserved.
//

#import "CheckNet.h"
static CheckNet *instance = nil;
@implementation CheckNet
+(CheckNet *) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[CheckNet alloc] init] ;
    }) ;
    
    return instance ;
}
@end
