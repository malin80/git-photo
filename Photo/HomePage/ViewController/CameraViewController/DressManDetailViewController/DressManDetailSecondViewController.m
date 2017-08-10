//
//  DressManDetailSecondViewController.m
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "DressManDetailSecondViewController.h"

@interface DressManDetailSecondViewController ()

@end

@implementation DressManDetailSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, ScreenHieght-200)];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [[UIColor redColor] CGColor];
    [self.view addSubview:backView];
    
    NSArray *temp=[self.dressManInfo.dressManSynopsis componentsSeparatedByString:@";"];
    for (int i = 0; i < temp.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, i*40+20, 100, 100)];
        label.text = temp[i];
        [label sizeToFit];
        [backView addSubview:label];
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
