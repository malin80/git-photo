//
//  CeremonyIntroViewController.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyIntroViewController.h"
#import "CeremonyManager.h"

@interface CeremonyIntroViewController ()

@end

@implementation CeremonyIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, ScreenHieght-200)];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [[UIColor colorR:235 G:235 B:235 alpha:1] CGColor];
    [self.view addSubview:backView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth-40, 100)];
    label.numberOfLines = 10;
    label.text = GET_SINGLETON_FOR_CLASS(CeremonyManager).ceremonyInfo.ceremonySynopsis;
    [label sizeToFit];
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
