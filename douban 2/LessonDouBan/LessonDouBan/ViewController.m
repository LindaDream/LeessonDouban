//
//  ViewController.m
//  LessonDouBan
//
//  Created by yu on 16/6/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ViewController.h"
#import "ActivityRequest.h"
#import "MovieRequest.h"
#import "TheaterRequest.h"
#import "ActivityModel.h"
#import "ActivityDetailRequest.h"
#import "MovieDetailRequest.h"
#import "MovieModel.h"
@interface ViewController ()
// 所有活动
@property (nonatomic,strong) NSMutableArray *activities;
// 所有电影
@property (nonatomic,strong) NSMutableArray *movies;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activities = [NSMutableArray array];
    self.movies = [NSMutableArray array];
//    [self requestActivityData];
//    [self requestActivityDetailDataWith:@"26865955"];
    [self requestMovieData];
//    [self requestMovieDetailDataWith:@"25662337"];
//    [self requestTheaterData];
    
}
// 活动
- (void)requestActivityData {
    __weak typeof(self) weakSelf = self;
    ActivityRequest *activity = [[ActivityRequest alloc] init];
    [activity activityRequestWithParameter:nil success:^(NSDictionary *dic) {
//        NSLog(@"success = %@",dic);
        NSArray *events = [dic objectForKey:@"events"];
//        NSLog(@"events = %@",events);
        for (NSDictionary *tempDic in events) {
            ActivityModel *model = [[ActivityModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.activities addObject:model];
            
        }
        NSLog(@"activities = %@",weakSelf.activities);
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}
// 活动详情
- (void)requestActivityDetailDataWith:(NSString *)ID {

    ActivityDetailRequest *request =  [[ActivityDetailRequest alloc] init];
    [request activityDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        NSLog(@"activity detail success = %@",dic);
    } failure:^(NSError *error) {
        NSLog(@"activity detail error = %@",error);
    }];
    
}
// 电影
- (void)requestMovieData {
    __weak typeof(self) weakSelf= self; // block里不能直接用self
    MovieRequest *movie = [[MovieRequest alloc] init];
    [movie movieRequestWithParameter:nil success:^(NSDictionary *dic) {
        NSLog(@"success = %@",dic);
        NSString *movieTitle = [dic objectForKey:@"title"];
        NSArray *tempMovies = [dic objectForKey:@"entries"];
        for (NSDictionary *tempDic in tempMovies) {
            MovieModel *model = [[MovieModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.movies addObject:model];
        }
        NSLog(@"weakSelf movies = %@",weakSelf.movies);
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}
// 电影详情
- (void)requestMovieDetailDataWith:(NSString *)ID {
    
    MovieDetailRequest *request =  [[MovieDetailRequest alloc] init];
    [request movieDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        NSLog(@"movie detail success = %@",dic);
    } failure:^(NSError *error) {
        NSLog(@"movie detail error = %@",error);
    }];
    
}

// 影院
- (void)requestTheaterData {

    TheaterRequest *theatre = [[TheaterRequest alloc] init];
    [theatre theaterRequestWithParameter:nil success:^(NSDictionary *dic) {
        NSLog(@"success = %@",dic);
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
