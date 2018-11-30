//
//  Detail_Model.h
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/14.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail_Model : NSObject
/** 事件ID */
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *lunar;
@property (nonatomic, strong) NSString *month;

@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *year;

@end


@interface DetailPic_Model : NSObject

@property (nonatomic, strong) NSString *pic_title;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *url;

@end
