//
//  CameraViewController.m
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraViewController.h"
#import "CameraDetailViewController.h"
#import "NavigationBar.h"
#import "CameraManager.h"
#import "HomePageCameraGroupInfo.h"
#import "HomePageScrollView.h"
@interface CameraViewController () <NavigationBarDelegate>
@property (nonatomic, strong) HomePageScrollView *scrollView;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"摄影"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    [self addTabPageBar];
    [self addPagerController];
    
    [self loadData];
}
- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.dataSource = self;
    tabBar.delegate = self;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:tabBar];
    
    _tabBar = tabBar;
}

- (void)addPagerController {
    TYPagerController *pagerController = [[TYPagerController alloc]init];
    pagerController.layout.prefetchItemCount = 1;
    //pagerController.layout.autoMemoryCache = NO;
    // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    [self.view addSubview:self.scrollView];
    _pagerController = pagerController;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, 64, ScreenWidth, 44);
    _pagerController.view.frame = CGRectMake(0, 110, ScreenWidth, ScreenHieght-110);
}

- (void)loadData {
    
    _sringArry = [[NSMutableArray alloc]init];
    for (int i = 0; i < GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups.count; i++) {
        HomePageCameraGroupInfo *info = GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups[i];
        [_sringArry addObject:info.cameraGroupName];
    }
    
    
    [self reloadData];
}

#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = _sringArry[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = _sringArry[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    return GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups.count;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    HomePageCameraGroupInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups objectAtIndex:index];
    CameraDetailViewController *controller = [[CameraDetailViewController alloc] init];
    controller.groupId = info.cameraGroupId;
    controller.view.backgroundColor=[UIColor whiteColor];
    return controller;
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)reloadData {
    [_tabBar reloadData];
    [_pagerController reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//-(void)setupAllChildViewController
//{
//    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64)];
//
//    self.sliderView.delegate = self;
//    [self.view addSubview:self.sliderView];
//     [self.view addSubview:self.scrollView];
//}
//- (NSInteger)numberOfItemsInYJSliderView:(YJSliderView *)sliderView {
//    return GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups.count;
//}
//
//- (UIView *)yj_SliderView:(YJSliderView *)sliderView viewForItemAtIndex:(NSInteger)index {
//    HomePageCameraGroupInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups objectAtIndex:index];
//    [GET_SINGLETON_FOR_CLASS(CameraManager).cameraTeams removeAllObjects];
//    CameraDetailViewController *controller = [[CameraDetailViewController alloc] init];
//    controller.groupId = info.cameraGroupId;
//    controller.view.backgroundColor=[UIColor whiteColor];
//    return controller.view;
//}
//
//- (NSString *)yj_SliderView:(YJSliderView *)sliderView titleForItemAtIndex:(NSInteger)index {
//    HomePageCameraGroupInfo *info = GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups[index];
//    return info.cameraGroupName;
//}
//
//- (NSInteger)initialzeIndexFoYJSliderView:(YJSliderView *)sliderView {
//    return 0;
//}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}



#pragma mark --- getters and setters ---
- (HomePageScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[HomePageScrollView alloc] initWithFrame:CGRectMake(0, 110, ScreenWidth, 250) withIsHomePage:NO];
    }
    return _scrollView;
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
