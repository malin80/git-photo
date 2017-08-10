//
//  DressManDetailFirstViewController.m
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "DressManDetailFirstViewController.h"

@interface DressManDetailFirstViewController ()

@end

@implementation DressManDetailFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDressManDetailWithIdSuccess) name:@"queryDressManDetailWithIdSuccess" object:nil];
}

- (void)queryDressManDetailWithIdSuccess {
    [self initView];
}

- (void)initView {
    NSMutableArray *images = [NSMutableArray array];
    NSArray *worksList = self.dressManInfo.worksList;
    for (NSDictionary *dict in worksList) {
        NSString *pic = [dict objectForKey:@"worksOfDresserPics"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,pic]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        [images addObject:imgFromUrl];
    }
    if (images.count > 0) {
        for (int i = 0; i<images.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*60, ScreenWidth, 200)];
            imageView.image = images[i];
            [self.view addSubview:imageView];
        }
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
