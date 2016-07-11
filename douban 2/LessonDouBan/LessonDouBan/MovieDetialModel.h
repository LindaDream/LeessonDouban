//
//  MovieDetialModel.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "BaseModel.h"

@interface MovieDetialModel : BaseModel<NSCopying,NSCoding>

@property (nonatomic, copy) NSString *summary;          // 电影简介
@property (nonatomic, strong) NSArray *genres;          // 分类
@property (nonatomic, strong) NSArray *countries;       // 国家
@property (nonatomic, strong) NSArray *durations;       // 时长
@property (nonatomic, copy) NSString *comments_count;   // 评论人数
@property (nonatomic, strong) NSDictionary *rating;
@property (nonatomic, copy) NSDictionary *images;   // 所有图片
@property (nonatomic, copy) NSString *title;          // 电影名称
@property (nonatomic, copy) NSString *pubdate;        // 上映日期
@property (nonatomic, copy) NSString *ID;             // 电影编号

@end
