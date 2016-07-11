//
//  MovieDetialViewController.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieDetialModel.h"
@interface MovieDetialViewController : UIViewController

@property (strong,nonatomic)NSString *ID;
@property(strong,nonatomic)MovieDetialModel *model;

@end
