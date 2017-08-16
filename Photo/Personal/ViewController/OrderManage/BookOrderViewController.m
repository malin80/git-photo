//
//  BookOrderViewController.m
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BookOrderViewController.h"
#import "CameraManOrderTableViewCell.h"
#import "PersonalManager.h"
#import "CameraManInfo.h"
#import "Masonry.h"
#import "LoginManager.h"

@interface BookOrderViewController () <UITableViewDelegate, UITableViewDataSource, CameraManOrderTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BookOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCameraManOrderInfoSuccess) name:@"queryCameraManOrderInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelCameraManOrderInfoSuccess) name:@"cancelCameraManOrderInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backCameraManOrderInfoSuccess) name:@"backCameraManOrderInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCameraManOrderInfoSuccess) name:@"deleteCameraManOrderInfoSuccess" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberOrderGoodsInfoFaild) name:@"dCameraManOrderInfoSuccess" object:nil];
}

- (void)queryCameraManOrderInfoSuccess {
    if (GET_SINGLETON_FOR_CLASS(PersonalManager).cameraManOrderInfos.count == 0) {
        if (self.tableView) {
            [self.tableView removeFromSuperview];
        }
    } else {
        if (self.tableView) {
            [self.tableView reloadData];
        } else {
            [self createTableView];
        }
    }
}

- (void)cancelCameraManOrderInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)backCameraManOrderInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)deleteCameraManOrderInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
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
    return GET_SINGLETON_FOR_CLASS(PersonalManager).cameraManOrderInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraManOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraManOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.delegate = self;
    CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).cameraManOrderInfos objectAtIndex:indexPath.row];
    cell.groupNameLabel.text = info.cameraManGroupName;
    cell.orderNumLabel.text = [NSString stringWithFormat:@"订单号 %@",info.cameraManOrderNum];
    cell.orderCameraManNameLabel.text = [NSString stringWithFormat:@"摄影师 %@",info.cameraManName];
    NSString *str = [info.cameraManCreatDate substringWithRange:NSMakeRange(0, 10)];
    cell.orderCreatDateLabel.text = [NSString stringWithFormat:@"下单时间 %@",str];
    cell.orderDateLabel.text = [NSString stringWithFormat:@"拍摄时间 %@",info.cameraManOrderDate];
    cell.orderStatusLabel.text = info.cameraManOrderStatus;
    if ([info.cameraManOrderStatus isEqualToString:@"待支付"]) {
        cell.payButton.hidden = NO;
        cell.cancelButton.hidden = NO;
        cell.backButton.hidden = YES;
        cell.deleteButton.hidden = YES;
    } else if ([info.cameraManOrderStatus isEqualToString:@"代发货"]) {
        cell.payButton.hidden = YES;
        cell.cancelButton.hidden = YES;
        cell.deleteButton.hidden = YES;
        cell.backButton.hidden = NO;
    } else if ([info.cameraManOrderStatus isEqualToString:@"交易关闭"]) {
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

    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0] CGColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

#pragma mark --- OrderTableViewCellDelegate ---
- (void)payButtonClick:(UIButton *)sender {
    
}

- (void)cancelButtonClick:(UIButton *)sender {
    CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).cameraManOrderInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) cancelCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withOrderId:info.cameraManOrderId];
}

- (void)backButtionClick:(UIButton *)sender {
    CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).cameraManOrderInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) backCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withOrderId:info.cameraManOrderId];
}

- (void)deleteButtonClick:(UIButton *)sender {
    CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).cameraManOrderInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) deleteCameraManOrderInfoWithToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue withOrderId:info.cameraManOrderId];
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
