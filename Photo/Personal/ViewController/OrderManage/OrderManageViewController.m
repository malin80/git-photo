//
//  OrderManageViewController.m
//  Photo
//
//  Created by 陈炳文 on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "OrderManageViewController.h"
#import "PersonalManager.h"
#import "LoginManager.h"
#import "ClothOrderViewController.h"

@interface OrderManageViewController ()

@end

@implementation OrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"订单管理"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    
    [self initView];
}

-(void)initView {
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"商品订单" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"预约订单" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"婚纱订单" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
}

#pragma mark --- DLTabedSlideView
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 3;
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
        case 2:
        {
            ClothOrderViewController *controller = [[ClothOrderViewController alloc] init];
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
