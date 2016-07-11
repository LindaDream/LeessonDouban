//
//  TheatreModel.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterModel.h"

@implementation TheaterModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    
}


- (NSString *)description{

    return self.telephone;
    
}


@end
