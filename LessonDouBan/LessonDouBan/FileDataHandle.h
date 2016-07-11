//
//  FileDataHandle.h
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FileDataHandle : NSObject

+ (instancetype)shareInstance;

// 保存值
- (void)setLoginState:(BOOL)isLogin;
- (void)setUserId:(NSString *)userId;
- (void)setUsername:(NSString *)userName;
- (void)setPassword:(NSString *)password;
- (void)setAvatar:(NSString *)avatar;
// 取值
- (BOOL)loginState;
- (NSString *)userId;
- (NSString *)userName;
- (NSString *)password;
- (NSString *)avatar;

// 更新数据
- (void)synchronize;

// 当前登录的用户信息
- (User *)user;

#pragma mark - 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath;

#pragma mark 数据库路径
// 数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName;

#pragma mark - 归档、反归档
// 将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;

// 反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key;

#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
- (NSString *)imageFilePathWithURL:(NSString *)imageURL;
#pragma mark 保存图片缓存
- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path;
#pragma mark 清除缓存
- (void)cleanDownloadImages;

@end
