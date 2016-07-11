//
//  MovieTableViewCell.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

#define MovieTableViewCell_Identify @"MovieTableViewCell_Identify"

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *starsLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;

@property (strong,nonatomic) MovieModel *movie;

@end
