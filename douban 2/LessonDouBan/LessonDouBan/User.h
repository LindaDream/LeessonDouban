//
//  User.h
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *userId;               //用户id
@property (nonatomic, copy) NSString *userName;             //用户昵称
@property (nonatomic, copy) NSString *password;             //用户密码
@property (nonatomic, copy) NSString *avatar;


@property (nonatomic, assign, getter = isLogin) BOOL login;
@end
