//
//  TheatreModel.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "BaseModel.h"

@interface TheaterModel : BaseModel
@property (nonatomic, copy) NSString *ID;           // 影院编号
@property (nonatomic, copy) NSString *cityName;     // 影院所在城市名
@property (nonatomic, copy) NSString *cinemaName;   // 影院名
@property (nonatomic, copy) NSString *address;      // 影院地址
@property (nonatomic, copy) NSString *telephone;    // 电话号码
@property (nonatomic, copy) NSString *latitude;     // 纬度
@property (nonatomic, copy) NSString *longitude;    // 经度
@property (nonatomic, copy) NSString *trafficRoutes;// 交通路线
@end
