//
//  User.m
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "User.h"

@implementation User
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", _userName, _password];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
