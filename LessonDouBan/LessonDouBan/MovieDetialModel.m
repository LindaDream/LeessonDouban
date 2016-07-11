//
//  MovieDetialModel.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieDetialModel.h"



@implementation MovieDetialModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    
}

- (NSString *)description{
    NSLog(@"%@",self.rating);
    return [NSString stringWithFormat:@"%@ %@",self.title,self.ID];
    
}
-(id)copyWithZone:(NSZone *)zone{
    id obj = [[[self class] allocWithZone:zone] init];
    return obj;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_summary forKey:@"summary"];
    [aCoder encodeObject:_genres forKey:@"genres"];
    [aCoder encodeObject:_countries forKey:@"countries"];
    [aCoder encodeObject:_comments_count forKey:@"comments_count"];
    [aCoder encodeObject:_durations forKey:@"durations"];
    [aCoder encodeObject:_rating forKey:@"rating"];
    [aCoder encodeObject:_images forKey:@"images"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_pubdate forKey:@"pubdate"];
    [aCoder encodeObject:_ID forKey:@"ID"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        self.genres = [aDecoder decodeObjectForKey:@"genres"];
        self.countries = [aDecoder decodeObjectForKey:@"countries"];
        self.comments_count = [aDecoder decodeObjectForKey:@"comments_count"];
        self.durations = [aDecoder decodeObjectForKey:@"durations"];
        self.rating = [aDecoder decodeObjectForKey:@"rating"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.pubdate = [aDecoder decodeObjectForKey:@"pubdate"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
    }
    return self;
}
@end
