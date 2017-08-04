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

#import "StoreManager.h"
#import "HomePageManager.h"
#import "LoginManager.h"
#import "ShoppingManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)createViewController{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isfirst"] length]>0) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] length]>0) {
            TabbarViewController *controller = [[TabbarViewController alloc] init];
            UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:controller];
            self.window.rootViewController = na;
        } else {
            LoginViewController *login=[[LoginViewController alloc]init];
            login.block = ^{
                TabbarViewController *controller = [[TabbarViewController alloc] init];
                UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:controller];
                self.window.rootViewController = na;
            };
            self.window.rootViewController =login;
        }
    }else{
        LeadViewController *lead=[[LeadViewController alloc]init];
        lead.block = ^{
            LoginViewController *login=[[LoginViewController alloc]init];
            self.window.rootViewController =login;
            [[NSUserDefaults standardUserDefaults] setObject:@"sss" forKey:@"isfirst"];
        };
        self.window.rootViewController =lead;
    }
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    
    
    
    
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self createViewController];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [GET_SINGLETON_FOR_CLASS(StoreManager) queryAllGoodsInfo];
        [GET_SINGLETON_FOR_CLASS(StoreManager) queryGoodsClassify];
        [GET_SINGLETON_FOR_CLASS(HomePageManager) queryCameraGroup];
        [GET_SINGLETON_FOR_CLASS(LoginManager) getMemberInfo];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] length]>0) {
            [GET_SINGLETON_FOR_CLASS(ShoppingManager) queryShoppingGoodsInfoWithSafeCodeValue:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
        }
    });
    
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
