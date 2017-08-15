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
}

- (void)initViewControllers {
    HomePageViewController  *navController1 = [[HomePageViewController alloc] init];
    //NaviViewController *navController1 = [[NaviViewController alloc] initWithRootViewController:controller1];
    navController1.yp_tabItemTitle = @"主页";
    UIImage *image1 = [UIImage imageNamed:@"tabbar_homepage_black"];
    UIImage *selectedImage1 = [UIImage imageNamed:@"tabbar_homepage_red"];
    UIImage *subImage1 = [self originImage:image1 scaleToSize:CGSizeMake(30, 30)];
    UIImage *subSelectedImage1 = [self originImage:selectedImage1 scaleToSize:CGSizeMake(30, 30)];
    navController1.yp_tabItemImage = subImage1;
    navController1.yp_tabItemSelectedImage = subSelectedImage1;
    
    StoreViewController *navController2 = [[StoreViewController alloc] init];
    //NaviViewController *navController2 = [[NaviViewController alloc] initWithRootViewController:controller2];
    navController2.yp_tabItemTitle = @"商店";
    UIImage *image2 = [UIImage imageNamed:@"tabbar_store_black"];
    UIImage *selectedImage2 = [UIImage imageNamed:@"tabbar_store_red"];
    UIImage *subImage2 = [self originImage:image2 scaleToSize:CGSizeMake(30, 30)];
    UIImage *subSelectedImage2 = [self originImage:selectedImage2 scaleToSize:CGSizeMake(30, 30)];
    navController2.yp_tabItemImage = subImage2;
    navController2.yp_tabItemSelectedImage = subSelectedImage2;
    
    ShoppingViewController *navController3= [[ShoppingViewController alloc] init];
    //NaviViewController *navController2 = [[NaviViewController alloc] initWithRootViewController:controller2];
    navController3.yp_tabItemTitle = @"购物车";
    UIImage *image3 = [UIImage imageNamed:@"tabbar_shopping_black"];
    UIImage *selectedImage3 = [UIImage imageNamed:@"tabbar_shopping_red"];
    UIImage *subImage3 = [self originImage:image3 scaleToSize:CGSizeMake(30, 30)];
    UIImage *subSelectedImage3 = [self originImage:selectedImage3 scaleToSize:CGSizeMake(30, 30)];
    navController3.yp_tabItemImage = subImage3;
    navController3.yp_tabItemSelectedImage = subSelectedImage3;
    
    PersonalViewController *navController4 = [[PersonalViewController alloc] init];
    //NaviViewController *navController2 = [[NaviViewController alloc] initWithRootViewController:controller2];
    navController4.yp_tabItemTitle = @"个人中心";
    UIImage *image4 = [UIImage imageNamed:@"tabbar_personal_black"];
    UIImage *selectedImage4 = [UIImage imageNamed:@"tabbar_personal_red"];
    UIImage *subImage4 = [self originImage:image4 scaleToSize:CGSizeMake(30, 30)];
    UIImage *subSelectedImage4 = [self originImage:selectedImage4 scaleToSize:CGSizeMake(30, 30)];
    navController4.yp_tabItemImage = subImage4;
    navController4.yp_tabItemSelectedImage = subSelectedImage4;
    
    self.viewControllers = [NSMutableArray arrayWithObjects:navController1, navController2, navController3, navController4,nil];
}

-(UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
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
