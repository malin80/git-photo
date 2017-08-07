//
//  CameraManDetailSecondViewController.m
//  Photo
//
//  Created by malin  on 2017/8/7.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManDetailSecondViewController.h"

@interface CameraManDetailSecondViewController ()

@end

@implementation CameraManDetailSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, ScreenHieght-200)];
    label.layer.borderWidth = 1;
    label.layer.borderColor = [[UIColor redColor] CGColor];
    label.text = self.cameraManInfo.cameraManSynopsis;
    [self.view addSubview:label];
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
