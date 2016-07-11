//
//  ActivityModel.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

-(id)copyWithZone:(NSZone *)zone{
    id obj = [[[self class] allocWithZone:zone] init];
    return obj;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_adapt_url forKey:kAapt_url];
    [aCoder encodeObject:_address forKey:kAddress];
    [aCoder encodeObject:_album forKey:kAlbum];
    [aCoder encodeObject:_alt forKey:kAlt];
    [aCoder encodeObject:_begin_time forKey:kBegin_time];
    [aCoder encodeObject:_can_invite forKey:kCan_invite];
    [aCoder encodeObject:_category forKey:kCategory];
    [aCoder encodeObject:_category_name forKey:kCategory_name];
    [aCoder encodeObject:_content forKey:kContent];
    [aCoder encodeObject:_end_time forKey:kEnd_time];
    [aCoder encodeObject:_geo forKey:kGeo];
    [aCoder encodeBool:_has_ticket forKey:kHas_ticket];
    [aCoder encodeObject:_ID forKey:kID];
    [aCoder encodeObject:_image forKey:kImage];
    [aCoder encodeObject:_image_hlarge forKey:kImage_hlarge];
    [aCoder encodeObject:_image_lmobile forKey:kImage_lmobile];
    [aCoder encodeObject:_loc_id forKey:kLoc_id];
    [aCoder encodeObject:_loc_name forKey:kLoc_name];
    [aCoder encodeInteger:_participant_count forKey:kParticipant_count];
    [aCoder encodeObject:_photos forKey:kPhotos];
    [aCoder encodeObject:_subcategory_name forKey:kSubCategory_name];
    [aCoder encodeObject:_title forKey:kTitle];
    [aCoder encodeInteger:_wisher_count forKey:kWisher_count];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.adapt_url = [aDecoder decodeObjectForKey:kAapt_url];
        self.address = [aDecoder decodeObjectForKey:kAddress];
        self.album = [aDecoder decodeObjectForKey:kAlbum];
        self.alt = [aDecoder decodeObjectForKey:kAlt];
        self.begin_time = [aDecoder decodeObjectForKey:kBegin_time];
        self.can_invite = [aDecoder decodeObjectForKey:kCan_invite];
        self.category = [aDecoder decodeObjectForKey:kCategory];
        self.category_name = [aDecoder decodeObjectForKey:kCategory_name];
        self.content = [aDecoder decodeObjectForKey:kContent];
        self.end_time = [aDecoder decodeObjectForKey:kEnd_time];
        self.geo  = [aDecoder decodeObjectForKey:kGeo];
        self.has_ticket = [aDecoder decodeBoolForKey:kHas_ticket];
        self.ID = [aDecoder decodeObjectForKey:kID];
        self.image = [aDecoder decodeObjectForKey:kImage];
        self.image_hlarge = [aDecoder decodeObjectForKey:kImage_hlarge];
        self.image_lmobile = [aDecoder decodeObjectForKey:kImage_lmobile];
        self.loc_id = [aDecoder decodeObjectForKey:kLoc_id];
        self.loc_name = [aDecoder decodeObjectForKey:kLoc_name];
        self.participant_count = [aDecoder decodeIntegerForKey:kParticipant_count];
        self.photos = [aDecoder decodeObjectForKey:kPhotos];
        self.subcategory_name = [aDecoder decodeObjectForKey:kSubCategory_name];
        self.photos = [aDecoder decodeObjectForKey:kPhotos];
        self.subcategory_name = [aDecoder decodeObjectForKey:kSubCategory_name];
        self.title = [aDecoder decodeObjectForKey:kTitle];
        self.wisher_count = [aDecoder decodeIntegerForKey:kWisher_count];
    }
    return self;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"ID = %@,owner = %@", self.ID,self.user];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else if ([key isEqualToString:@"owner"]) {
        OwnerModel *model = [[OwnerModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        _user = model;
    }
    
}



@end
