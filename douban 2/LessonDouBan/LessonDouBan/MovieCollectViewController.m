//
//  MovieCollectViewController.m
//  LessonDouBan
//
//  Created by user on 16/7/3.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieCollectViewController.h"
#import "DataBaseHandle.h"
#import "MovieDetialModel.h"
#import "MovieDetialViewController.h"
@interface MovieCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *movieList;
@property(strong,nonatomic)DataBaseHandle *manager;
@property(strong,nonatomic)NSMutableArray *dataArray;
@end

static NSString *systemCellIdentifier = @"systemCell";

@implementation MovieCollectViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(editAction:)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}

- (void)editAction:(UIBarButtonItem *)editItem{
    self.movieList.editing = !self.movieList.editing;
    if (self.movieList.editing) {
        editItem.title = @"完成";
    }else{
        editItem.title = @"编辑";
    }
}
#pragma mark--编辑--
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetialModel *model = self.dataArray[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除数据源
        [self.manager deleteMovie:model];
        [self.dataArray removeObject:model];
        // 删除UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.manager = [DataBaseHandle shareInstance];
    self.dataArray = [NSMutableArray new];
    [self.manager openDB];
    self.dataArray = [self.manager selectAllMovie];
    [self.movieList reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 414, 736) style:(UITableViewStylePlain)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.movieList.frame];
    imgView.image = [UIImage imageNamed:@"MineBackGround.jpg"];
    [self.movieList setBackgroundView:imgView];
    self.movieList.dataSource = self;
    self.movieList.delegate = self;
    [self.movieList registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCellIdentifier];
    [self.view addSubview:self.movieList];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"===%ld",self.dataArray.count);
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MovieDetialModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:   (NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetialModel *model = self.dataArray[indexPath.row];
    UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MovieDetialViewController *detailVC = [myStoryboard instantiateViewControllerWithIdentifier:@"MovieDetialViewController"];
    detailVC.ID = model.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
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
