//
//  CameraManDetailFourViewController.m
//  Photo
//
//  Created by malin  on 2017/8/7.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManDetailFourViewController.h"

@interface CameraManDetailFourViewController ()

@end

@implementation CameraManDetailFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    calendar.daili=self;
    calendar.frame=CGRectMake(0, 0, ScreenWidth, 400);
    [self.view addSubview:calendar];
}
-(void)showData:(NSString *)riqi{
    NSLog(@"%@",riqi);
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
