//
//  HomeList_Model.m
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/14.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import "HomeList_Model.h"
#import "BlocksKit.h"
@implementation HomeList_Model
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"event_id":@"_id"};
}

-(void)setOnline:(NSString *)online{
    _online = online;
    _buyUrls = [_online componentsSeparatedByString:@" "];
}

@end
