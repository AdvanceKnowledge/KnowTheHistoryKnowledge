//
//  HomeList_Model.h
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/14.
//  Copyright © 2018 追@寻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeList_Model : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *day;

@property (nonatomic, strong) NSString *des;

@property (nonatomic, strong) NSString *event_id;

@property (nonatomic, strong) NSString *lunar;

@property (nonatomic, strong) NSString *month;

@property (nonatomic, strong) NSString *pic;

@property (nonatomic, strong) NSString *year;



@property (nonatomic, strong) NSString *catalog;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *sub1;
@property (nonatomic, strong) NSString *sub2;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *reading;
@property (nonatomic, strong) NSString *online;
@property (nonatomic, strong) NSString *bytime;


@property (nonatomic, strong) NSArray *buyUrls;


@end
