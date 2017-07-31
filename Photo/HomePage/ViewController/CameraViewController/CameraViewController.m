//
//  CameraViewController.m
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraViewController.h"
#import "BookOrderViewController.h"
#import "GoodsOrderViewController.h"

#import "NavigationBar.h"
#import "DLTabedSlideView.h"

@interface CameraViewController () <NavigationBarDelegate>

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

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
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 40)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;

//    NSArray *array = [NSArray arrayWithObjects:@"跟拍", @"跟拍", @"跟拍", @"跟拍", @"跟拍", @"跟拍", @"跟拍", @"跟拍", nil];
//    NSMutableArray *mutableArray = [NSMutableArray array];
//    for (int i = 0; i < array.count; i++) {
//        DLTabedbarItem *item = [DLTabedbarItem itemWithTitle:[NSString stringWithFormat:@"%@",array[i]] image:nil selectedImage:nil];
//        [mutableArray addObject:item];
//        self.tabedSlideView.selectedIndex = 0;
//    }
//    self.tabedSlideView.tabbarItems = mutableArray;
//    [self.tabedSlideView buildTabbar];
//
//    [self.view addSubview:self.tabedSlideView];

    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"商品订单" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"预约订单" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
//    [self.view addSubview:self.tabedSlideView];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 2;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    switch (index) {
        case 0:
        {
            GoodsOrderViewController *controller = [[GoodsOrderViewController alloc] init];
            return controller;
        }
        case 1:
        {
            BookOrderViewController *controller = [[BookOrderViewController alloc] init];
            return controller;
        }

        default:
            return nil;
    }
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
