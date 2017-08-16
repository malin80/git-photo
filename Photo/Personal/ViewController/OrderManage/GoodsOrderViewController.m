//
//  GoodsOrderViewController.m
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "GoodsOrderViewController.h"

#import "OrderTableViewCell.h"
#import "PersonalManager.h"
#import "GoodsInfo.h"
#import "SDWebImageCache.h"
#import "Masonry.h"
#import "LoginManager.h"

@interface GoodsOrderViewController () <UITableViewDelegate, UITableViewDataSource, OrderTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GoodsOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberOrderGoodsInfoSuccess) name:@"queryMemberOrderGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelMemberOrderGoodsInfoSuccess) name:@"cancelMemberOrderGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backMemberOrderGoodsInfoSuccess) name:@"backMemberOrderGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteMemberOrderGoodsInfoSuccess) name:@"deleteMemberOrderGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberOrderGoodsInfoFaild) name:@"queryMemberOrderGoodsInfoFaild" object:nil];
}

- (void)queryMemberOrderGoodsInfoSuccess {
    if (self.tableView) {
        [self.tableView reloadData];
    } else {
        [self createTableView];
    }
}

- (void)cancelMemberOrderGoodsInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)backMemberOrderGoodsInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)deleteMemberOrderGoodsInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)queryMemberOrderGoodsInfoFaild {
    [self showtext:@"网络异常"];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght - 120) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(PersonalManager).orderGoodsInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.delegate = self;
    GoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).orderGoodsInfos objectAtIndex:indexPath.row];
    cell.goodsNamme.text = info.goodsName;
    cell.goodsParameter.text = info.goodsParamValue;
    cell.goodsNumber.text = info.goodsOrderNum;
    cell.time.text = info.goodsDate;
    cell.goodsCount.text = [NSString stringWithFormat:@"数量：%ld",info.goodsCount];
    cell.goodsPrice.text = [NSString stringWithFormat:@"总价：%ld",info.goodsPrice];
    cell.goodsState.text = info.goodsOrderStatus;
    if ([info.goodsOrderStatus isEqualToString:@"待支付"]) {
        cell.payButton.hidden = NO;
        cell.cancelButton.hidden = NO;
        cell.backButton.hidden = YES;
        cell.deleteButton.hidden = YES;
    } else if ([info.goodsOrderStatus isEqualToString:@"代发货"]) {
        cell.payButton.hidden = YES;
        cell.cancelButton.hidden = YES;
        cell.deleteButton.hidden = YES;
        cell.backButton.hidden = NO;
    } else if ([info.goodsOrderStatus isEqualToString:@"交易关闭"]) {
        cell.deleteButton.hidden = NO;
        cell.payButton.hidden = YES;
        cell.cancelButton.hidden = YES;
        cell.backButton.hidden = YES;
    } else {
        cell.payButton.hidden = YES;
        cell.cancelButton.hidden = YES;
        cell.backButton.hidden = YES;
        cell.deleteButton.hidden = YES;
    }

    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.goodsImage.image = image;
    }];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0] CGColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark --- OrderTableViewCellDelegate ---
- (void)payButtonClick:(UIButton *)sender {
    
}

- (void)cancelButtonClick:(UIButton *)sender {
    GoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).orderGoodsInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) cancelMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withOrderId:info.goodsOrderId];
}

- (void)backButtionClick:(UIButton *)sender {
    GoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).orderGoodsInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) backMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withOrderId:info.goodsOrderId];
}

- (void)deleteButtonClick:(UIButton *)sender {
    GoodsInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).orderGoodsInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) deleteMemberOrderGoodsInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withOrderId:info.goodsOrderId];
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
