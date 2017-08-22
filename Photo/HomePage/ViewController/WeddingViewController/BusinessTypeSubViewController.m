//
//  BusinessTypeSubViewController.m
//  Photo
//
//  Created by malin  on 2017/8/22.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BusinessTypeSubViewController.h"
#import "WeddingManager.h"
#import "WeddingBusinessInfo.h"
#import "PersonalTabelViewCell.h"
#import "SDWebImageCache.h"

@interface BusinessTypeSubViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BusinessTypeSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-360) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(WeddingManager).businessTypeDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeddingBusinessInfo *info = [GET_SINGLETON_FOR_CLASS(WeddingManager).businessTypeDetail objectAtIndex:indexPath.row];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    PersonalTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[PersonalTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.icon.backgroundColor = [UIColor redColor];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@：%@",info.businessTypeDetailName,info.businessTypeDetailDes];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.businessTypeDetailPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.icon.image = image;
    }];
    cell.arrow.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
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
