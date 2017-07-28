//
//  TabbarViewController.m
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/10/12.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewControllers];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置数字样式的badge的位置和大小
    [self.tabBar setNumberBadgeMarginTop:2
                       centerMarginRight:45
                     titleHorizonalSpace:8
                      titleVerticalSpace:2];
    // 设置小圆点样式的badge的位置和大小
    [self.tabBar setDotBadgeMarginTop:5
                    centerMarginRight:45
                           sideLength:10];
    self.tabBar.itemTitleColor = [UIColor colorWithRgb:@"99aaff" :1];
    self.tabBar.itemTitleSelectedColor =  [UIColor colorWithRgb:@"667fff" :1];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:10*SCALEW];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:10*SCALEW];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tongzhi) name:@"new_count" object:nil];
}

- (void)initViewControllers {
    
    
    HomePageViewController  *navController1 = [[HomePageViewController alloc] init];
    //NaviViewController *navController1 = [[NaviViewController alloc] initWithRootViewController:controller1];
    navController1.yp_tabItemTitle = @"主页";
    navController1.yp_tabItemImage = [UIImage imageNamed:@"home nor"];
    navController1.yp_tabItemSelectedImage = [UIImage imageNamed:@"home sel"];
    
    
    StoreViewController *navController2 = [[StoreViewController alloc] init];
    //NaviViewController *navController2 = [[NaviViewController alloc] initWithRootViewController:controller2];
    navController2.yp_tabItemTitle = @"商店";
    navController2.yp_tabItemImage = [UIImage imageNamed:@"write and notes nor"];
    navController2.yp_tabItemSelectedImage = [UIImage imageNamed:@"write and notes sel"];
    
    ShoppingViewController *navController3= [[ShoppingViewController alloc] init];
    //NaviViewController *navController2 = [[NaviViewController alloc] initWithRootViewController:controller2];
    navController3.yp_tabItemTitle = @"购物车";
    navController3.yp_tabItemImage = [UIImage imageNamed:@"write and notes nor"];
    navController3.yp_tabItemSelectedImage = [UIImage imageNamed:@"write and notes sel"];
    
    PersonalViewController *navController4 = [[PersonalViewController alloc] init];
    //NaviViewController *navController2 = [[NaviViewController alloc] initWithRootViewController:controller2];
    navController4.yp_tabItemTitle = @"个人中心";
    navController4.yp_tabItemImage = [UIImage imageNamed:@"write and notes nor"];
    navController4.yp_tabItemSelectedImage = [UIImage imageNamed:@"write and notes sel"];
    
    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:navController1, navController2, navController3, navController4,nil];
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
