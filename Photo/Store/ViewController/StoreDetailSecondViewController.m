//
//  StoreDetailSecondViewController.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreDetailSecondViewController.h"

@interface StoreDetailSecondViewController ()

@end

@implementation StoreDetailSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    NSArray *temp=[self.info.goodsDetailPic componentsSeparatedByString:@";"];

    for (int i=0; i<temp.count; i++) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,temp[i]]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*180, ScreenWidth, 180)];
        imageView.image = imgFromUrl;
        [self.view addSubview:imageView];
    }
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