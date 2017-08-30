//
//  CeremonyWorksViewController.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyWorksViewController.h"
#import "SDWebImageCache.h"
#import "CeremonyManager.h"

@interface CeremonyWorksViewController ()

@end

@implementation CeremonyWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCeremonyDetailSuccess) name:@"queryCeremonyDetailSuccess" object:nil];
}

- (void)queryCeremonyDetailSuccess {
    
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
