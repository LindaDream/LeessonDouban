//
//  DouBanTabBar.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

@class DouBanTabBar;
@protocol DouBanTabBarDelegate <NSObject>

- (void)DouBanItemDidClicked:(DouBanTabBar *)tabBar;

@end



#import <UIKit/UIKit.h>

@interface DouBanTabBar : UITabBar


// 当前选中的tabbar的下标
@property (nonatomic,assign)int currentSelected;

// 当前选中的item
@property (nonatomic,strong)UIButton *currentSelectedItem;

// tabbar上所有的item
@property (nonatomic,strong)NSArray *allItems;

// 自定义代理
@property (nonatomic,weak)id <DouBanTabBarDelegate> DouBanDelegate;

// 初始化item
- (instancetype)initWithItems:(NSArray *)items frame:(CGRect)frame;

@end
