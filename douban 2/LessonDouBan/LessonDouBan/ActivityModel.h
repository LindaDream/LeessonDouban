//
//  ActivityModel.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "BaseModel.h"
#import "OwnerModel.h"
#import "FileDataHandle.h"
#define kAapt_url @"adapt_url"
#define kAddress @"address"
#define kAlbum @"album"
#define kAlt @"alt"
#define kBegin_time @"beigin_time"
#define kCan_invite @"can_invite"
#define kCategory @"category"
#define kCategory_name @"category_name"
#define kContent @"content"
#define kEnd_time @"end_time"
#define kGeo @"geo"
#define kHas_ticket @"has_ticket"
#define kID @"id"
#define kImage @"image"
#define kImage_hlarge @"image_hlarge"
#define kImage_lmobile @"image_lmobile"
#define kLoc_id @"loc_id"
#define kLoc_name @"loc_name"
#define kOwner @"woner"
#define kParticipant_count @"participant_count"
#define kPhotos @"photos"
#define kSubCategory_name @"subcategory_name"
#define kTitle @"title"
#define kWisher_count @"wisher_count"
@interface ActivityModel : BaseModel<NSCopying,NSCoding>
@property (nonatomic, copy) NSString *subcategory_name;// 活动的分类
@property (nonatomic, copy) NSString *image;           // 显示的图片
@property (nonatomic, copy) NSString *adapt_url;       // 活动信息(网页版)
@property (nonatomic, copy) NSString *loc_name;        // 活动所在地
@property (nonatomic, strong) OwnerModel *user;       // 活动发布者
@property (nonatomic, copy) NSString *alt;             // 购票网址
@property (nonatomic, copy) NSString *ID;              // 活动ID
@property (nonatomic, copy) NSString *category;        // 类别
@property (nonatomic, copy) NSString *title;           // 标题
@property (nonatomic, assign) NSInteger wisher_count;    // 评论数
@property (nonatomic, assign) BOOL *has_ticket;        // 是否有票
@property (nonatomic, copy) NSString *content;         // 活动内容
@property (nonatomic, copy) NSString *can_invite;      // 是否邀请
@property (nonatomic, copy) NSString *album;           // 唱片集
@property (nonatomic, assign) NSInteger participant_count;//参与人数
@property (nonatomic, copy) NSString *tags;            // 标签
@property (nonatomic, copy) NSString *image_hlarge;    //
@property (nonatomic, strong) NSArray *photos;         // 所有剧照信息
@property (nonatomic, copy) NSString *begin_time;      // 活动开始时间
@property (nonatomic, copy) NSString *price_range;     //
@property (nonatomic, copy) NSString *geo;             //
@property (nonatomic, copy) NSString *image_lmobile;   //
@property (nonatomic, copy) NSString *category_name;   //
@property (nonatomic, copy) NSString *loc_id;          //
@property (nonatomic, copy) NSString *end_time;        // 活动结束时间
@property (nonatomic, copy) NSString *address;         // 活动地址
@end
