//
//  AppDelegate.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "StoreViewController.h"
#import "ShoppingViewController.h"
#import "PersonalViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)createViewController{
    
    HomePageViewController *vc1 = [[HomePageViewController alloc] init];
    vc1.title = @"主页";
    StoreViewController * vc2 = [[StoreViewController alloc]init];
    vc2.title = @"商店";
    ShoppingViewController * vc3 = [[ShoppingViewController alloc]init];
    vc3.title = @"购物车";
    PersonalViewController * vc4 = [[PersonalViewController alloc]init];
    vc4.title = @"个人中心";

    UINavigationController * navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController * navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController * navi3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController * navi4 = [[UINavigationController alloc] initWithRootViewController:vc4];

    //创建了一个UITabBarController
    UITabBarController * tbc = [[UITabBarController alloc]init];
    //在UITabBarController装入所有你要显示的viewController的数组
    tbc.viewControllers = @[navi1,navi2,navi3,navi4];
    //把它设为rootViewController
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc]initWithFrame:frame];
    
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //tbc.delegate = self;
    
}

- (void)setTabBar{
    
    UITabBarController * tbc = (id)self.window.rootViewController;
    
    tbc.tabBar.hidden = NO;
    tbc.tabBar.translucent = YES;
    //设置颜色
    tbc.tabBar.tintColor  = [UIColor redColor];
    tbc.tabBar.barStyle =  UIBarStyleDefault ;
}

- (void)setTabBarItem{
    
    UITabBarController * tbc = (id)self.window.rootViewController;
    
    HomePageViewController *vc1 = tbc.viewControllers[0];
    StoreViewController *vc2 = tbc.viewControllers[1];
    ShoppingViewController *vc3 = tbc.viewControllers[2];
    PersonalViewController *vc4 = tbc.viewControllers[3];
    
//    [vc1.tabBarItem setImage:[UIImage imageNamed:@"tabbar_homepage_black"]];
//    [vc2.tabBarItem setImage:[UIImage imageNamed:@"personal_address"]];
//    [vc3.tabBarItem setImage:[UIImage imageNamed:@"tabbar_shopping_black"]];
//    [vc4.tabBarItem setImage:[UIImage imageNamed:@"tabbar_personal_black"]];
    
    vc1.tabBarItem.titlePositionAdjustment =  UIOffsetMake(10,-3);
    vc2.tabBarItem.titlePositionAdjustment =  UIOffsetMake(10,-3);
    vc3.tabBarItem.titlePositionAdjustment =  UIOffsetMake(10,-3);
    vc4.tabBarItem.titlePositionAdjustment =  UIOffsetMake(10,-3);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self createViewController];
    [self setTabBar];
    [self setTabBarItem];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
