//
//  MovieViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieModel.h"
#import "MovieTableViewCell.h"
#import "MovieRequest.h"
#import "MovieDetialViewController.h"

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@property (strong, nonatomic)NSMutableArray *movieArray;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieArray = [NSMutableArray array];
    
    [self.movieTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MovieTableViewCell_Identify];
    [self requestMovieData];
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
            [weakSelf.movieArray addObject:model];
        }
        NSLog(@"-weakSelf movies = %@",weakSelf.movieArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.movieTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.movieArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieTableViewCell_Identify];
    cell.movie = self.movieArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 159;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"MovieDetial" sender:self.movieArray[indexPath.row]];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"MovieDetial"]) {
        MovieDetialViewController *MDVC = [segue destinationViewController];
        //MDVC.hidesBottomBarWhenPushed = YES;
        MovieModel *model = sender;
        MDVC.ID = model.ID;
    }
    
    
}


@end
