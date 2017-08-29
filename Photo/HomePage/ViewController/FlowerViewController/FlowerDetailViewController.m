//
//  FlowerDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "FlowerDetailViewController.h"
#import "BusinessCaseDetailTableViewCell.h"
#import "SDWebImageCache.h"

@interface FlowerDetailViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *pics;

@end

@implementation FlowerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:[NSString stringWithFormat:@"花艺-%@详情",self.info.flowerName]];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    
    [self initDataSource];
    [self createBottomButton];
    [self createTableView];
}

- (void)initDataSource {
    self.pics = [self.info.flowerDetailPic componentsSeparatedByString:@";"];
}

- (void)createBottomButton {
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght- 40, ScreenWidth, 40)];
    [bottomButton setTitle:@"联系方式" forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor redColor];
//    [bottomButton addTarget:self action:@selector(gotoAddAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}


- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 104) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    BusinessCaseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BusinessCaseDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    NSString *picString = [self.pics objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,picString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.iconView.image = image;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
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
