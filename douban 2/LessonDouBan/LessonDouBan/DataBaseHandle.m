//
//  DataBaseHandle.m
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
#import "ActivityModel.h"
#import "MovieModel.h"
#import "FileDataHandle.h"

// 归档
#define kActivityArchiverKey @"activity"
#define KMovieArchiverKey @"movie"

#define KDatabaseName @"Douban.sqlite"

@implementation DataBaseHandle

static DataBaseHandle *handle = nil;

+ (DataBaseHandle *)shareInstance{

    if (nil == handle) {
        handle = [[self alloc] init];
        [handle openDB];
    }
    return handle;
}

static sqlite3 *db = nil;
// 打开数据库
- (void)openDB{

    if (db != nil) {
        return;
    }
    
    NSString *dbPath = [[FileDataHandle shareInstance] databaseFilePath:KDatabaseName];
    int result = sqlite3_open([dbPath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        NSString *createSql = @"CREATE TABLE IF NOT EXISTS ActivityList (userName TEXT,ID TEXT , title TEXT, imageUrl TEXT, data BLOB)";
        NSString *creatMovie = @"CREATE TABLE IF NOT EXISTS MovieList (userName TEXT,ID TEXT, title TEXT, imageUrl TEXT, data BLOB)";
        sqlite3_exec(db, [creatMovie UTF8String], NULL, NULL, NULL);
        sqlite3_exec(db, [createSql UTF8String], NULL, NULL, NULL);
        //sqlite3_exec(db, [creatMovie UTF8String], NULL, NULL, NULL);
    }
    
}
// 关闭数据库
- (void)closeDB{

    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        db = nil;
    }
    
}

// Activity
// 添加新活动
- (void)insertNewActivity:(ActivityModel *)activity{
    NSLog(@"========%@",activity);
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"insert into ActivityList (userName,ID,title,imageUrl,data) values (?,?,?,?,?)";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [activity.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [activity.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [activity.image UTF8String], -1, NULL);
        
        NSString *archiverKey = [NSString stringWithFormat:@"%@%@",kActivityArchiverKey,activity.ID];
        NSData *data = [[FileDataHandle shareInstance] dataOfArchiverObject:activity forKey:archiverKey];
        sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
// 删除某个活动
- (void)deleteActivity:(ActivityModel *)activity{

    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from ActivityList where ID = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [activity.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
// 获取某个活动对象
- (ActivityModel *)selectActivityWithID:(NSString *)ID{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from ActivityList where ID = ? and userName = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    ActivityModel * activity = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kActivityArchiverKey,ID];
            activity = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return activity;

}
// 获取所有活动
- (NSMutableArray *)selectAllActivity{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from ActivityList where userName = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    NSMutableArray * activityArray = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kActivityArchiverKey,ID];
            
            ActivityModel * act = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
            [activityArray addObject:act];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return activityArray;
}
// 判断活动是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID{
    
    ActivityModel * act = [self selectActivityWithID:ID];
    if (act == nil) {
        return NO;
    }
    
    return YES;
}

// Movie
// 添加新电影
- (void)insertNewMovie:(MovieDetialModel *)movie{

    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"insert into MovieList (userName,ID,title,imageUrl,data) values (?,?,?,?,?)";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [movie.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [movie.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [[movie.images objectForKey:@"medium"] UTF8String], -1, NULL);
        
        NSString * archiverKey = [NSString stringWithFormat:@"%@%@",KMovieArchiverKey,movie.ID];
        
        NSData * data = [[FileDataHandle shareInstance] dataOfArchiverObject:movie forKey:archiverKey];
        
        sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);

    
}
// 删除某个电影
- (void)deleteMovie:(MovieDetialModel *)movie{

    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from MovieList where ID = ? and userName = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [movie.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
// 获取某个电影对象
- (MovieDetialModel *)selectMovieWithId:(NSString *)ID{

    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from MovieList where ID = ? and userName = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    MovieDetialModel * movie = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",KMovieArchiverKey,ID];
            movie = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return movie;

}
// 获取所有电影
- (NSMutableArray *)selectAllMovie
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from MovieList where userName= ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    
    NSMutableArray * movieArray = [NSMutableArray arrayWithCapacity:40];
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] UTF8String], -1, NULL);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",@"movie",ID];
            
            MovieDetialModel * m = [[FileDataHandle shareInstance] unarchiverObject:data forKey:archiverKey];
            [movieArray addObject:m];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return movieArray;
    
}
// 判断电影是否被收藏
- (BOOL)isFavoriteMovieWithID:(NSString *)ID{

    MovieDetialModel *model = [self selectMovieWithId:ID];
    if (model == nil) {
        return NO;
    }
    return YES;
}

@end
