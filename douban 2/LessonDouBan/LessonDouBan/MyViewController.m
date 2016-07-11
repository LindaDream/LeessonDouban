//
//  MyViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "MyHeaderTableViewCell.h"
#import "MyTableViewCell.h"
#import "FileDataHandle.h"
#import "UIImageView+WebCache.h"
#import "ActivityCollectViewController.h"
#import "MovieCollectViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)NSArray *titles;
@property(assign,nonatomic)BOOL loginState;

@end

@implementation MyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.myTableView reloadData];
    self.loginState = [[NSUserDefaults standardUserDefaults] boolForKey:@"loginState"];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if (self.loginState == 0) {
        [btn setTitle:@"登录" forState:(UIControlStateNormal)];
    }else{
        [btn setTitle:@"注销" forState:(UIControlStateNormal)];
    }
    //[btn setTitle:flag ? @"注销":@"登录" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(rightBarButtonItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 414, 736)];
    backgroundImg.image = [UIImage imageNamed:@"MineBackGround.jpg"];
    backgroundImg.userInteractionEnabled = YES;
    [self.myTableView setBackgroundView:backgroundImg];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyHeaderTableViewCell_Identify];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyTableViewCell_1];
    
    self.titles = @[@"我的活动",@"我的电影",@"清除缓存"];
}

- (void)rightBarButtonItemClicked:(UIButton *)btn{

    // 跳转到登录界面
    
    // 获取当前storyboard
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if ([btn.titleLabel.text isEqualToString:@"登录"]) {
        // 获取登录界面
        LoginViewController *loginVC = [mainSB instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        [btn setTitle:@"登录" forState:(UIControlStateNormal)];
        BOOL flag = NO;
        [[NSUserDefaults standardUserDefaults] setBool:flag forKey:@"loginState"];
        [self.myTableView reloadData];
    }
}


// 显示缓存
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
        NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
        
    }
    
    //单位MB
    
    return cacheFolderSize/1024/1024;
    
}

// 清除缓存 自己写
- (void)removeCache{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清楚缓存?" preferredStyle:(UIAlertControllerStyleAlert)];
    __block MyViewController *mySelf = self;
    // 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [mySelf clearCache];
        [mySelf.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:3 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertView addAction:okAction];
    [alertView addAction:cancelAction];
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)clearCache{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = NSHomeDirectory();
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
         [[SDImageCache sharedImageCache] cleanDisk];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.loginState = [[NSUserDefaults standardUserDefaults] boolForKey:@"loginState"];
    if(indexPath.row == 3){
        [self removeCache];
        //[self.myTableView reloadData];
    }else if(indexPath.row == 1){
        if (self.loginState == 1) {
            ActivityCollectViewController *activityVC = [ActivityCollectViewController new];
            [self.navigationController pushViewController:activityVC animated:YES];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先进行登录!" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                LoginViewController *loginVC = [myStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self presentViewController:loginVC animated:YES completion:nil];
            }];
            [alertView addAction:okAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }
    }else if(indexPath.row == 2){
        if (self.loginState == 1) {
            MovieCollectViewController *movieVC = [MovieCollectViewController new];
            [self.navigationController pushViewController:movieVC animated:YES];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先进行登录!" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                LoginViewController *loginVC = [myStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self presentViewController:loginVC animated:YES completion:nil];
            }];
            [alertView addAction:okAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }

    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        MyHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyHeaderTableViewCell_Identify];
        self.loginState = [[NSUserDefaults standardUserDefaults] boolForKey:@"loginState"];
        if (self.loginState == 1) {
            NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
            cell.userNameLabel.text = userName;
            NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
            NSLog(@"%@",string);
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://162.211.125.85%@",string]];
            NSLog(@"%@",url);
            [cell.avatarImageView setImageWithURL:url];
        }else{
            cell.userNameLabel.text = @"您好，请登录!";
            cell.avatarImageView.image = [UIImage imageNamed:@"head_img"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    return cell;
    }else{
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCell_1];
        cell.contentLabel.text = self.titles[indexPath.row - 1];
        if (indexPath.row == 3) {
            cell.subLabel.text = [NSString stringWithFormat:@"%.1fM",[self getFilePath]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 184;
    }
    return 40;
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
