//
//  ActivityCollectViewController.m
//  LessonDouBan
//
//  Created by user on 16/7/2.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityCollectViewController.h"
#import "DataBaseHandle.h"
#import "ActivityDetailViewController.h"
@interface ActivityCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *activityList;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)DataBaseHandle *manager;
@end

static NSString *systemIdentifier = @"systemCell";

@implementation ActivityCollectViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(editAction:)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}
- (void)editAction:(UIBarButtonItem *)editItem{
    self.activityList.editing = !self.activityList.editing;
    if (self.activityList.editing) {
        editItem.title = @"完成";
    }else{
        editItem.title = @"编辑";
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.manager = [DataBaseHandle shareInstance];
    self.dataArray = [NSMutableArray new];
    [self.manager openDB];
    self.dataArray = [self.manager selectAllActivity];
    [self.activityList reloadData];
}
#pragma mark--编辑列表--
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ActivityModel *model = self.dataArray[indexPath.row];
        // 删除数据源
        [self.manager deleteActivity:model];
        [self.dataArray removeObject:model];
        // 删除UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        [self.activityList reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 414, 736) style:(UITableViewStylePlain)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4141, 736)];
    imgView.image = [UIImage imageNamed:@"MineBackGround.jpg"];
    self.activityList.backgroundView = imgView;
    [self.activityList registerClass:[UITableViewCell class] forCellReuseIdentifier:systemIdentifier];
    self.activityList.dataSource = self;
    self.activityList.delegate = self;
    [self.view addSubview:self.activityList];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = ((ActivityModel *)self.dataArray[indexPath.row]).title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ActivityDetailViewController *detailVC = [myStoryboard instantiateViewControllerWithIdentifier:@"ActivityDetailViewController"];
    detailVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
