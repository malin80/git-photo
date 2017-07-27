//
//  AddressViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "AddressViewController.h"
#import "EditAddressViewController.h"
#import "AddAddressViewController.h"

#import "NavigationBar.h"
#import "AddressTableViewCell.h"

@interface AddressViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate, AddressTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"管理收货地址"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self createTableView];
    [self createBottomButton];
}

- (void)createBottomButton {
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreeHieght- 40, ScreenWidth, 40)];
    [bottomButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    bottomButton.backgroundColor = UIColorFromRGB(255, 102, 1, 1);
    [bottomButton addTarget:self action:@selector(gotoAddAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //之前选中的cell
    AddressTableViewCell *lastCell = [tableView viewWithTag:1];
    lastCell.tag = 0;
    lastCell.normalAddressLabel.text = @"设为默认";
    lastCell.selectedView.selected = NO;
    //目前选中的cell
    AddressTableViewCell *nowCell = [tableView cellForRowAtIndexPath:indexPath];
    nowCell.tag = 1;
    nowCell.normalAddressLabel.text = @"默认地址";
    nowCell.selectedView.selected = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- AddressTableViewCellDelegate ---
- (void)editAddress {
    EditAddressViewController *controller = [[EditAddressViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoAddAddress {
    AddAddressViewController *controller = [[AddAddressViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
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
