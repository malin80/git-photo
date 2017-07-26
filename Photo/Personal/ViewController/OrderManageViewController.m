//
//  OrderManageViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "OrderManageViewController.h"

#import "NavigationBar.h"

@interface OrderManageViewController () <NavigationBarDelegate>

@end

@implementation OrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"订单管理"];
    bar.delegate = self;
    [self.view addSubview:bar];
}

- (void)createSubNavigationBar {
//    UILabel *
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
