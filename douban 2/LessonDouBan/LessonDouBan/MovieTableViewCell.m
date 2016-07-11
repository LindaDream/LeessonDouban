//
//  MovieTableViewCell.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieTableViewCell.h"



@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMovie:(MovieModel *)movie{

    _movie = movie;
    self.titleLabel.text = movie.title;
    self.starsLabel.text = movie.stars;
    self.pubdateLabel.text = movie.pubdate;
    
    [self.movieImageView setImageWithURL:[NSURL URLWithString:[movie.images objectForKey:@"small"]]];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
