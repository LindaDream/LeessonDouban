//
//  DataBaseHandle.h
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"
#import "MovieDetialModel.h"

@interface DataBaseHandle : NSObject

+ (DataBaseHandle *)shareInstance;
// 打开数据库
- (void)openDB;
// 关闭数据库
- (void)closeDB;

// Activity
// 添加新活动
- (void)insertNewActivity:(ActivityModel *)activity;
// 删除某个活动
- (void)deleteActivity:(ActivityModel *)activity;
// 获取某个活动对象
- (ActivityModel *)selectActivityWithID:(NSString *)ID;
// 获取所有活动
- (NSMutableArray *)selectAllActivity;
// 判断活动是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID;

// Movie
// 添加新电影
- (void)insertNewMovie:(MovieDetialModel *)movie;
// 删除某个电影
- (void)deleteMovie:(MovieDetialModel *)movie;
// 获取某个电影对象
- (MovieDetialModel *)selectMovieWithId:(NSString *)ID;
// 获取所有电影
- (NSMutableArray *)selectAllMovie;
// 判断电影是否被收藏
- (BOOL)isFavoriteMovieWithID:(NSString *)ID;

@end
