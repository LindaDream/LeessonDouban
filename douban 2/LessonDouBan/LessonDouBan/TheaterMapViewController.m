//
//  TheaterMapViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "TheaterMapViewController.h"
// 显示地图
#import <BaiduMapAPI_map/BMKMapComponent.h>
// 地图编码
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenheight [UIScreen mainScreen].bounds.size.height
@interface TheaterMapViewController ()<BMKGeoCodeSearchDelegate,BMKMapViewDelegate>

@property(strong,nonatomic)BMKMapView *mapView;

@property(strong,nonatomic)BMKGeoCodeSearch *searcher;

@end

@implementation TheaterMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenheight)];
    self.view = _mapView;
    
    // 缩放比例
    _mapView.zoomLevel = 15;
    
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= self.model.cityName;
    geoCodeSearchOption.address = self.model.address;
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}



- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{

    NSLog(@"%@",result);
    // 大头针
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    
    // 设置经纬度
    pointAnnotation.coordinate = result.location;
    pointAnnotation.title = result.address;
    [_mapView addAnnotation:pointAnnotation];
    // 设置当前地点为中心点
    _mapView.centerCoordinate = result.location;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{

    // 当做大头针视图的标识符
    NSString *annotationViewID = @"annotationID";
    // 根据标识符，查找一个可以复用的大头针
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
        // 设置颜色
        ((BMKPinAnnotationView *)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置动画效果（从天而降）
        ((BMKPinAnnotationView *)annotationView).animatesDrop = YES;
    }
    
    annotationView.annotation = annotation;
    // 设置点击大头针弹出提示信息
    annotationView.canShowCallout = YES;
    return annotationView;
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    // 设置代理
    _mapView.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    
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
