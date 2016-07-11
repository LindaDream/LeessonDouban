//
//  ActivityDetailViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityModel.h"
#import <UMSocialSnsService.h>
#import <UMSocial.h>
#import "AppDelegate.h"
#import "DataBaseHandle.h"
#import "LoginViewController.h"
#define kLabelWidth ([UIScreen mainScreen].bounds.size.width - 32)


@interface ActivityDetailViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;

@property (weak, nonatomic) IBOutlet UILabel *activityIntroduce;

@property(strong,nonatomic)DataBaseHandle *manager;

@property(strong,nonatomic)UIButton *collectionButton;
@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    
    self.titleLabel.text = self.model.title;
    self.dateLabel.text = [NSString stringWithFormat:@"%@--%@",self.model.begin_time,self.model.end_time];
    self.userLabel.text = self.model.category_name;
    self.categoryLabel.text = self.model.category_name;
    self.addressLabel.text = self.model.address;
    [self.activityImageView setImageWithURL:[NSURL URLWithString:self.model.image]];
    self.activityIntroduce.text = self.model.content;
    
    CGRect rect = _activityIntroduce.frame;
    rect.size.height = [self.class textHeight:self.model];
    _activityIntroduce.frame = rect;
    //NSLog(@"++++%lf",self.activityIntroduce.frame.size.height);
    
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] init];
    self.collectionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.collectionButton.frame = CGRectMake(0, 0, 60, 60);
    [self.collectionButton setTitle:@"收藏" forState:(UIControlStateNormal)];
    [self.collectionButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.collectionButton addTarget:self action:@selector(collectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    rightButton.customView = self.collectionButton;
    self.navigationItem.rightBarButtonItems = @[shareBtn,rightButton];
    self.manager = [DataBaseHandle shareInstance];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (CGFloat)textHeight:(ActivityModel *)model{

    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(kLabelWidth, 2000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    //NSLog(@"%lf",rect.size.height);
    return rect.size.height;
}

// 分享
- (void)shareAction{
    
    //分享gif图片
    NSString *shareText = self.model.title;
    UIImage *img = self.activityImageView.image;
    
    //分享png、jpg图片
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"577620d767e58e9f20002d59" shareText:shareText shareImage:img shareToSnsNames:@[UMShareToSina] delegate:self];
    
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else{
        NSLog(@"%d",response.responseCode);
    }
}
// 收藏
- (void)collectAction:(UIButton *)collectionButton{
    BOOL loginState = [[NSUserDefaults standardUserDefaults] boolForKey:@"loginState"];
    if (loginState == 1) {
        ActivityModel *newModel = [self.manager selectActivityWithID:self.model.ID];
        if (self.model) {
            [self.manager openDB];
            if (newModel) {
                [self.manager deleteActivity:newModel];
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消收藏成功!" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                [alertView addAction:okAction];
                [self presentViewController:alertView animated:YES completion:nil];
                //collectionButton.selected = NO;
                //newModel = nil;
            }else{
                [self.manager insertNewActivity:self.model];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:(UIAlertControllerStyleAlert)];
                // 创建按钮
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                //collectionButton.selected = YES;
                //newModel = nil;
            }
            [self.manager closeDB];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"亲,你的数据尚未加载完成,请稍后收藏" preferredStyle:(UIAlertControllerStyleAlert)];
            // 创建按钮
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录或注册!" preferredStyle:(UIAlertControllerStyleAlert)];
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                // 获取登录界面
                LoginViewController *loginVC = [mainSB instantiateViewControllerWithIdentifier:@"LoginViewController"];
                [self presentViewController:loginVC animated:YES completion:nil];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
