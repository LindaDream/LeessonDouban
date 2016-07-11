//
//  TheaterTableViewCell.m
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterTableViewCell.h"



@implementation TheaterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(TheaterModel *)model{

    _model = model;
    self.titleLabel.text = model.cinemaName;
    self.addressLabel.text = model.address;
    self.telLabel.text = model.telephone;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
