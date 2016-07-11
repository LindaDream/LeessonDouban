//
//  FileDataHandle.m
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "FileDataHandle.h"
#import "UIImageView+WebCache.h"
#import "user.h"

// 用户信息
#define kUserId       @"userId"
#define kUserName     @"username"
#define kPassword     @"password"
#define kLoginState   @"isLogin"
#define kAvatar       @"avatar"

// 归档
#define kActivityArchiverKey  @"activity"
#define kMovieArchiverKey     @"movie"

@implementation FileDataHandle

static FileDataHandle *handle;
+ (instancetype)shareInstance{

    if (nil == handle) {
        handle = [[self alloc] init];
    }
    return handle;
}

// 保存值
- (void)setLoginState:(BOOL)isLogin{

    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kLoginState];
    
}
- (void)setUserId:(NSString *)userId{

    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kUserId];
    
}
- (void)setUsername:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
}
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
}
- (void)setAvatar:(NSString *)avatar{
    [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:kAvatar];
}

// 取值
- (BOOL)loginState{

    return [[NSUserDefaults standardUserDefaults] boolForKey:kLoginState];
    
}
- (NSString *)userId{

    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserId];
    
}
- (NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
}
- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
}
- (NSString *)avatar{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAvatar];
}


// 更新数据
- (void)synchronize{

    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

// 当前登录的用户信息
- (User *)user{

    User *user = [[User alloc] init];
    user.userId = [self userId];
    user.userName = [self userName];
    user.password = [self password ];
    user.avatar = [self avatar];
    user.login = [self loginState];
    return user;
}

#pragma mark - 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath{

    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
}

#pragma mark 数据库路径
// 数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName{

    return [[self cachesPath] stringByAppendingPathComponent:databaseName];
    
}

#pragma mark - 归档、反归档
//将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key
{
    NSMutableData * data = [NSMutableData data];
    
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    
    return data;
}


// 反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key{

    NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id object = [unarchive decodeObjectForKey:key];
    [unarchive finishDecoding];
    return object;
    
}

#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
- (NSString *)imageFilePathWithURL:(NSString *)imageURL{

    NSString *imageName = [imageURL stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return [[self downloadImageManagerFilePath] stringByAppendingPathComponent:imageName];
    
}



#pragma mark 保存图片缓存
//- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path{
//
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    [data writeToFile:path atomically:YES];
//    CGFloat size = [self folderSizeAtPath:[self downloadImageManagerFilePath]];
//    // 获得SDWebImage下载图片时的缓存，并得到大小
//    size = size + [[SDImageCache sharedImageCache] getSize] / (1024*1024);
//    [self setFilesSize:size];
//    
//}

#pragma mark 存储下载图片的文件夹路径
- (NSString *)downloadImageManagerFilePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"DownloadImages"];
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
        //如果沙盒中没有存储图像的文件夹，创建文件夹
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imageManagerPath;
}


#pragma mark 清除缓存
- (void)cleanDownloadImages{
    // 清除头像图片
    [[SDImageCache sharedImageCache] cleanDisk];
    
    NSString *imageManagerPath = [self downloadImageManagerFilePath];
    // 清除活动列表和电影列表对应的图片
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageManagerPath error:nil];
    

}

@end
