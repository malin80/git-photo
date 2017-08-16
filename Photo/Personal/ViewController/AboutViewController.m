//
//  AboutViewController.m
//  Photo
//
//  Created by malin  on 2017/8/16.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "AboutViewController.h"
#import "NavigationBar.h"

@interface AboutViewController () <NavigationBarDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"关于"];
    bar.delegate = self;
    [self.view addSubview:bar];
    UIImage *image = [UIImage imageNamed:@"common_introduct.jpg"];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght)];
    scrollView.contentSize = CGSizeMake(ScreenWidth, image.size.height);
    [self.view addSubview:scrollView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght)];
    imageView.image = [UIImage imageNamed:@"common_introduct.jpg"];
    [scrollView addSubview:imageView];
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
