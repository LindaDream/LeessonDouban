//
//  MovieDetialViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MovieDetialViewController.h"
#import "MovieDetailRequest.h"
#import "MovieDetialModel.h"
#import "DataBaseHandle.h"
#import "LoginViewController.h"
@interface MovieDetialViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

@property (weak, nonatomic) IBOutlet UILabel *scoreAndWishLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationsLabel;

@property (weak, nonatomic) IBOutlet UILabel *genresLabel;

@property (weak, nonatomic) IBOutlet UILabel *countriesLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property(assign,nonatomic)BOOL loginState;
@property(strong,nonatomic)DataBaseHandle *manager;
@end

@implementation MovieDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [DataBaseHandle shareInstance];
    self.model = [[MovieDetialModel alloc] init];
    [self requestMovieDetailDataWith:self.ID];
    NSLog(@"ID = %@",self.ID);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction)];
}

// 电影详情
- (void)requestMovieDetailDataWith:(NSString *)ID {
    
    MovieDetailRequest *request =  [[MovieDetailRequest alloc] init];
    [request movieDetailRequestWithParameter:@{@"id":ID} success:^(NSDictionary *dic) {
        NSLog(@"---%@",request);
        //NSLog(@"movie detail success = %@",dic);
        
        [self.model setValuesForKeysWithDictionary:dic];
        //NSLog(@"%@",self.model);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUp];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"movie detail error = %@",error);
    }];
    
}

- (void)setUp{
    self.title = self.model.title;
    self.scoreAndWishLabel.text = [NSString stringWithFormat:@"评分：%@(%@)",[self.model.rating objectForKey:@"average"],self.model.comments_count];
    self.pubdateLabel.text = self.model.pubdate;
    self.durationsLabel.text = [self getStrFromArray:self.model.durations];
    self.genresLabel.text = [self getStrFromArray:self.model.genres];
    self.countriesLabel.text = [self getStrFromArray:self.model.countries];
    self.summaryLabel.text = self.model.summary;
    [self.movieImageView setImageWithURL:[NSURL URLWithString:[self.model.images objectForKey:@"large"] ]];
    
}

- (NSString *)getStrFromArray:(NSArray *)arr{

    NSMutableString *mStr = [NSMutableString string];
    for (NSString *str in arr) {
        [mStr appendString:str];
    }
    return mStr;
}
#pragma mark--收藏--
- (void)rightAction{
    self.loginState = [[NSUserDefaults standardUserDefaults] boolForKey:@"loginState"];
    if (self.loginState == 1) {
        MovieDetialModel *newModel = [self.manager selectMovieWithId:self.model.ID];
        NSLog(@"+++--%@",newModel.ID);
        [self.manager openDB];
        if (newModel) {
            [self.manager deleteMovie:newModel];
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消收藏成功!" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertView addAction:okAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }else{
            [self.manager openDB];
            [self.manager insertNewMovie:self.model];
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功!" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertView addAction:okAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录或注册!" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            LoginViewController *loginVC = [myStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:loginVC animated:YES completion:nil];
        }];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }
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
