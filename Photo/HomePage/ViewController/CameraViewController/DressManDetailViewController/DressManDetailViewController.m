//
//  DressManDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "DressManDetailViewController.h"
#import "DressManDetailFirstViewController.h"
#import "DressManDetailSecondViewController.h"
#import "DressManDetailThirdViewController.h"
#import "DressManDetailFourViewController.h"

#import "NavigationBar.h"
#import "DLTabedSlideView.h"
#import "CameraManager.h"

@interface DressManDetailViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate>

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end

@implementation DressManDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"预约化妆师 化妆师"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght-60, ScreenWidth, 60)];
    bottomButton.backgroundColor = [UIColor redColor];
    [bottomButton setTitle:@"立即预约" forState:UIControlStateNormal];
    [self.view addSubview:bottomButton];
    
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-200)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"作品" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"简介" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"评价" image:nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"档期" image:nil selectedImage:nil];
    
    self.tabedSlideView.tabbarItems = @[item1, item2, item3, item4];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 4;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    switch (index) {
        case 0:
        {
            DressManDetailFirstViewController *controller = [[DressManDetailFirstViewController alloc] init];
            controller.dressManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo;
            return controller;
        }
        case 1:
        {
            DressManDetailSecondViewController *controller = [[DressManDetailSecondViewController alloc] init];
            controller.dressManInfo = self.dressManInfo;
            return controller;
        }
        case 2:
        {
            DressManDetailThirdViewController *controller = [[DressManDetailThirdViewController alloc] init];
            controller.dressManInfo = GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo;
            return controller;
        }
        case 3:
        {
            DressManDetailFourViewController *controller = [[DressManDetailFourViewController alloc] init];
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
