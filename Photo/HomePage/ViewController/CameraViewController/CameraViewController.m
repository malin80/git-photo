//
//  CameraViewController.m
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraViewController.h"
#import "CameraDetailViewController.h"

#import "HomePageScrollView.h"
#import "NavigationBar.h"
#import "CameraManager.h"
#import "HomePageCameraGroupInfo.h"

@interface CameraViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate>
{
    NSMutableArray *_slideViews;
}

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;
@property (nonatomic, strong) HomePageScrollView *scrollView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"摄影"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    
    
    [self initView];
}

- (void)initView {
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;

    _slideViews = [NSMutableArray array];
    for (int i = 0; i < GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups.count; i++) {
        HomePageCameraGroupInfo *info = GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups[i];
        DLTabedbarItem *item = [DLTabedbarItem itemWithTitle:[NSString stringWithFormat:@"%@",info.cameraGroupName] image:nil selectedImage:nil];
        [_slideViews addObject:item];
    }
    self.tabedSlideView.tabbarItems = _slideViews;
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];

    [self.view addSubview:self.scrollView];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return _slideViews.count;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    HomePageCameraGroupInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraGroups objectAtIndex:index];
    [GET_SINGLETON_FOR_CLASS(CameraManager).cameraTeams removeAllObjects];
    CameraDetailViewController *controller = [[CameraDetailViewController alloc] init];
    controller.groupId = info.cameraGroupId;
    return controller;
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index {
    
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- getters and setters ---
- (HomePageScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[HomePageScrollView alloc] initWithFrame:CGRectMake(0, 120, ScreenWidth, 250) withIsHomePage:NO];
    }
    return _scrollView;
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
