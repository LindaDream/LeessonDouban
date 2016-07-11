//
//  TheaterViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterViewController.h"
#import "TheaterRequest.h"
#import "TheaterModel.h"
#import "TheaterTableViewCell.h"
#import "TheaterMapViewController.h"

@interface TheaterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *theaterTableView;

@property(strong,nonatomic)NSMutableArray *array;

@end

@implementation TheaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.theaterTableView registerNib:[UINib nibWithNibName:@"TheaterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TheaterTableViewCell_identify];
    
    
    self.array = [NSMutableArray array];
    [self requestTheaterData];
}


- (void)requestTheaterData {
    
    TheaterRequest *theatre = [[TheaterRequest alloc] init];
    [theatre theaterRequestWithParameter:nil success:^(NSDictionary *dic) {
        //NSLog(@"success = %@",dic);
        //NSLog(@"---------%@",[dic objectForKey:@"result"]);
        for (NSDictionary *d in dic[@"result"][@"data"]) {
            
            TheaterModel *model = [TheaterModel new];
            [model setValuesForKeysWithDictionary:d];
            
            [self.array addObject:model];

        }
        NSLog(@"%ld",self.array.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.theaterTableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TheaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TheaterTableViewCell_identify];
    cell.model = self.array[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 119;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    TheaterMapViewController *mapVC = [[TheaterMapViewController alloc] init];
    mapVC.model = self.array[indexPath.row];
    [self.navigationController pushViewController:mapVC animated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
