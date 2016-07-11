//
//  MovieModel.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "BaseModel.h"

@interface MovieModel : BaseModel
@property (nonatomic, copy) NSString *rating;         // 电影评分
@property (nonatomic, copy) NSString *pubdate;        // 上映日期
@property (nonatomic, copy) NSString *title;          // 电影名称
@property (nonatomic, copy) NSString *wish;           // 评论数
@property (nonatomic, copy) NSString *original_title; // 原始标题
@property (nonatomic, copy) NSString *orignal_title;  //
@property (nonatomic, copy) NSString *collection;     // 收藏数
@property (nonatomic, copy) NSString *stars;          // 星级
@property (nonatomic, copy) NSDictionary *images;   // 所有图片
@property (nonatomic, copy) NSString *large;          // 大图片
@property (nonatomic, copy) NSString *small;          // 小图片
@property (nonatomic, copy) NSString *medium;         // 中等图片
@property (nonatomic, copy) NSString *ID;             // 电影编号 
@end
