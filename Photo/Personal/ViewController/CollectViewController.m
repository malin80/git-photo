//
//  CollectViewController.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CollectViewController.h"

#import "NavigationBar.h"
#import "CollectTableViewCell.h"
#import "PersonalManager.h"
#import "CollectGoodsInfo.h"
#import "Masonry.h"
#import "StoreDetailViewController.h"
#import "StoreManager.h"

@interface CollectViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate, CollectTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCollectGoodsInfo];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"我的收藏"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self addNotification];
    [self createTableView];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCollectGoodsInfoSuccess) name:@"deleteCollectGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCollectGoodsInfoSuccess) name:@"queryCollectGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCollectGoodsInfoWithNoData) name:@"queryCollectGoodsInfoWithNoData" object:nil];
}

- (void)queryCollectGoodsInfoSuccess {
    if (!_tableView) {
        [self createTableView];
    } else {
        [_tableView reloadData];
    }}

- (void)deleteCollectGoodsInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCollectGoodsInfo];
}

- (void)queryCollectGoodsInfoWithNoData {
    if (_tableView) {
        [_tableView removeFromSuperview];
    }
    [self createNoCollectGoodsView];
}

- (void)createNoCollectGoodsView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"shopping_no_collection"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(60));
        make.height.equalTo(@(80));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"还没有收藏的商品哦，去逛逛";
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).with.offset(5);
    }];
    
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(PersonalManager).collectGoodsInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).collectGoodsInfos objectAtIndex:indexPath.row];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CollectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.delegate = self;
    }
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0] CGColor];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic]];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    cell.goodsImage.image = imgFromUrl;
    cell.goodsNamme.text = info.goodsName;
    cell.goodsSales.text = [NSString stringWithFormat:@"产品销量 %ld",info.goodsCount];
    cell.goodsPrice.text = [NSString stringWithFormat:@"产品价格 ¥%ld",info.goodsPrice];
    cell.time.text = [NSString stringWithFormat:@"收藏时间 %@",info.colletDate];
    cell.cancelCollectButton.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)cancelColletGoodsInfo:(UIButton *)sender {
    CollectGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).collectGoodsInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) deleteCollectGoodsInfoWithCollectId:info.collectId];
}

- (void)lookUpButtonClick:(UIButton *)sender {
    CollectGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).collectGoodsInfos objectAtIndex:sender.tag];
    for (GoodsInfo *goodsInfo in GET_SINGLETON_FOR_CLASS(StoreManager).goodsInfoArray) {
        if (goodsInfo.goodsId == info.goodsId) {
            StoreDetailViewController *controller = [[StoreDetailViewController alloc] init];
            controller.info = goodsInfo;
            [self.navigationController pushViewController:controller animated:NO];
        }
    }
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
