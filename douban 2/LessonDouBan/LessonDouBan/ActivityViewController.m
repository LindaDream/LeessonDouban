//
//  ActivityViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "ViewController.h"
#import "ActivityRequest.h"
#import "ActivityDetailViewController.h"

@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *activityTableView;

@property (strong,nonatomic) NSMutableArray *array;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActivityTableViewCell_Identify];
    
    self.array = [NSMutableArray array];
    
    [self requestActivityData];
    
}

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
            [weakSelf.array addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityTableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityTableViewCell_Identify];
    cell.model = self.array[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 224;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self performSegueWithIdentifier:@"activityDetail" sender:self.array[indexPath.row]];
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"activityDetail"]) {
        ActivityDetailViewController *activityDVC = segue.destinationViewController;
        activityDVC.model = sender;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
