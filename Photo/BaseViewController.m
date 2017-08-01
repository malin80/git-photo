//
//  BaseViewController.m
//  Photo
//
//  Created by malin  on 2017/7/26.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)showtext:(NSString *)test{
    [self show];
    self.hub1.label.text = test;
    self.hub1.mode = MBProgressHUDModeText;
    [self.hub1 hideAnimated:YES afterDelay:1.5];
}
- (void)showlongtext:(NSString *)str{
    self.hub1.labelText = str;
    self.hub1.mode=MBProgressHUDModeIndeterminate;
    [self.hub1 show:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:_hub1];
    //[self.view addSubview:_hub1];
}
- (void)show:(NSString *)test{
    [self show];
    self.hub1.label.text = test;
    
    [self.hub1 hideAnimated:YES afterDelay:1.5];
}

- (void)show{
    self.hub1.label.text = nil;
    self.hub1.mode=MBProgressHUDModeIndeterminate;
    [self.hub1 showAnimated:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:_hub1];
}


- (void)hiddenHub1{
    [self.hub1 hideAnimated:YES];
}
#pragma mark 懒加载
- (MBProgressHUD *)hub1{
    
    if (_hub1 == nil) {
        
        _hub1 = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    }
    return _hub1;
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
