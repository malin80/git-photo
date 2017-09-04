//
//  WeddingMapViewController.m
//  Photo
//
//  Created by malin  on 2017/9/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "WeddingMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeddingManager.h"

@interface WeddingMapViewController () <NavigationBarDelegate, CLLocationManagerDelegate>
{
    double Locationlatitude;//纬度
    double Locationlongitude;//经度
    
}
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationM;

@end

@implementation WeddingMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:nil];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght)];

    //    MKMapTypeStandard = 0, // 标准地图
    //    MKMapTypeSatellite, // 卫星云图
    //    MKMapTypeHybrid, // 混合(在卫星云图上加了标准地图的覆盖层)
    //    MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0), // 3D立体
    //    MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0), // 3D混合
    // 设置地图显示样式(必须注意,设置时 注意对应的版本)
    self.mapView.mapType = MKMapTypeStandard;
    
    
    // 设置地图的控制项
    // 是否可以滚动
    //    self.mapView.scrollEnabled = NO;
    // 缩放
    //    self.mapView.zoomEnabled = NO;
    // 旋转
    //    self.mapView.rotateEnabled = NO;
    
    
    // 设置地图的显示项(注意::版本适配)
    // 显示建筑物
    self.mapView.showsBuildings = YES;
    // 指南针
    self.mapView.showsCompass = YES;
    // 兴趣点
    self.mapView.showsPointsOfInterest = YES;
    // 比例尺
    self.mapView.showsScale = YES;
    // 交通
    self.mapView.showsTraffic = YES;
    
    // 显示用户位置
    [self locationM];
    // 显示用户位置, 但是地图并不会自动放大到合适比例
       self.mapView.showsUserLocation = YES;
    
    /**
     *  MKUserTrackingModeNone = 0, 不追踪
     MKUserTrackingModeFollow,  追踪
     MKUserTrackingModeFollowWithHeading, 带方向的追踪
     */
    // 不但显示用户位置, 而且还会自动放大地图到合适的比例(也要进行定位授权)
    // 不灵光
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    [self.view addSubview:self.mapView];
    
    [self test];
}

- (void)test {
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//
//    float latitude = 39.9517880000;
//    float longitude = 116.4904600000;
//    
//    CLLocationCoordinate2D center = {latitude,longitude};
//    
//    CLLocation *locationCe = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
//    
//    //反地理编码  (根据经纬度获取地理名称)
//    [geocoder reverseGeocodeLocation: locationCe completionHandler:^(NSArray *placemarks, NSError * _Nullable error) {
//        
//        //放错处理
//        if (placemarks.count == 0 || error) {
//            
//            NSLog(@"定位错误");
//            return ;
//        }
//        
//        for (CLPlacemark *placemark in placemarks) {
//            NSString *weizhi = [NSString stringWithFormat:@"%@%@", placemark.locality, placemark.subLocality];
//            NSLog(@"位置是=%@",weizhi);
//        }
//    }];
    CLLocationCoordinate2D coor ;
    coor.latitude = GET_SINGLETON_FOR_CLASS(WeddingManager).businessLatitude;
    coor.longitude = GET_SINGLETON_FOR_CLASS(WeddingManager).businessLongitude;
    
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    
    pointAnnotation.coordinate = coor;
    //设置地图的定位中心点坐标
    self.mapView.centerCoordinate = coor;
    //将点添加到地图上，即所谓的大头针
    [self.mapView addAnnotation:pointAnnotation];
}


-(CLLocationManager *)locationM
{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        _locationM.delegate = self;
        _locationM.desiredAccuracy = kCLLocationAccuracyBest;
        _locationM.distanceFilter = 10;
        [_locationM startUpdatingLocation];
        // 版本适配
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_locationM requestAlwaysAuthorization];
        }
        
    }
    return _locationM;
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
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
