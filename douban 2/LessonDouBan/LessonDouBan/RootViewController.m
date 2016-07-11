//
//  RootViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "RootViewController.h"
#import "DouBanTabBar.h"
#import "ActivityViewController.h"
#import "MovieViewController.h"
#import "TheaterViewController.h"
#import "MyViewController.h"

@interface RootViewController ()<DouBanTabBarDelegate>

@property (nonatomic,strong)DouBanTabBar *dbTabBar;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    
    UIButton *btn1 = [self creatBtnWithImage:@"paper.png" image:@"paperH.png" title:@"活动"];
    
    UIButton *btn2 = [self creatBtnWithImage:@"video.png" image:@"videoH.png" title:@"电影"];
    
    UIButton *btn3 = [self creatBtnWithImage:@"2image.png" image:@"2imageH.png" title:@"影院"];
    
    UIButton *btn4 = [self creatBtnWithImage:@"person.png" image:@"personH.png" title:@"我的"];
    
    
    
    self.dbTabBar = [[DouBanTabBar alloc] initWithItems:@[btn1,btn2,btn3,btn4] frame:CGRectMake(0, WindowHeight - 49, WindowWidth, 49)];
    
    self.dbTabBar.DouBanDelegate = self;
    
    
    [self.view addSubview:self.dbTabBar];
    
}


- (UIButton *)creatBtnWithImage:(NSString *)img1 image:(NSString *)img2 title:(NSString *)title{

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setImage:[UIImage imageNamed:img1] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:img2] forState:(UIControlStateSelected)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [btn.titleLabel sizeToFit];
    btn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 15, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(btn.imageView.bounds.size.height + 7, -53, 0, 0);
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    
    return btn;
    
}


- (void)DouBanItemDidClicked:(DouBanTabBar *)tabBar{

    self.selectedIndex = tabBar.currentSelected;
    
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
