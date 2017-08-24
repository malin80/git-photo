//
//  ClothOrderViewController.m
//  Photo
//
//  Created by malin  on 2017/8/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothOrderViewController.h"

@interface ClothOrderViewController ()

@end

@implementation ClothOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)createNodataView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"personal_order"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(60));
        make.height.equalTo(@(80));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"还没有该类订单，去逛逛";
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).with.offset(5);
    }];
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
