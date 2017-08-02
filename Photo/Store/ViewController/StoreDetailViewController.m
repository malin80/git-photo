//
//  StoreDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreDetailViewController.h"
#import "NavigationBar.h"
#import "DLTabedSlideView.h"
#import "StoreDetailFirstViewController.h"
#import "StoreDetailSecondViewController.h"

@interface StoreDetailViewController () <NavigationBarDelegate, DLSlideTabbarDelegate>

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:[NSString stringWithFormat:@"%@ 详情",self.info.goodsName]];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self initView];
}

- (void)initView {
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreeHieght-64)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"商品" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"详情" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"评价" image:nil selectedImage:nil];

    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 3;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    switch (index) {
        case 0:
        {
            StoreDetailFirstViewController *controller = [[StoreDetailFirstViewController alloc] init];
            controller.info = self.info;
            return controller;
        }
        case 1:
        {
            StoreDetailSecondViewController *controller = [[StoreDetailSecondViewController alloc] init];
            controller.info = self.info;
            return controller;
        }
        case 2:
        {
            StoreDetailFirstViewController *controller = [[StoreDetailFirstViewController alloc] init];
            return controller;
        }
            
        default:
            return nil;
    }
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index {
    
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
