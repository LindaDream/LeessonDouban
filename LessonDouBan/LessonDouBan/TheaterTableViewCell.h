//
//  TheaterTableViewCell.h
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheaterModel.h"

#define TheaterTableViewCell_identify @"TheaterTableViewCell_identify"

@interface TheaterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *telLabel;


@property (strong,nonatomic)TheaterModel *model;

@end
