//
//  SelectAddressViewController.m
//  Photo
//
//  Created by malin  on 2017/8/11.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "SelectAddressViewController.h"
#import "NavigationBar.h"
#import "SelectAddressTableViewCell.h"
#import "PersonalManager.h"
#import "AddressInfo.h"
#import "AddressViewController.h"

@interface SelectAddressViewController () <NavigationBarDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"确认订单"];
    [bar setRightButtonTitle:@"管理"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64.0f - 80.0f) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"confirmOrderTabelView"];
    SelectAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[SelectAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    AddressInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos objectAtIndex:indexPath.row];
    cell.nameLabel.text = info.name;
    cell.phoneLabel.text = info.phone;
    if (info.status == 1) {
        cell.addressLabel.text = [NSString stringWithFormat:@"【默认地址】%@",info.address];
    } else {
        cell.addressLabel.text = info.address;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressInfo *info = [GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos objectAtIndex:indexPath.row];
    GET_SINGLETON_FOR_CLASS(PersonalManager).normalAddressInfo = info;
    [self.navigationController popViewControllerAnimated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)completeClick {
    AddressViewController *controller = [[AddressViewController alloc] init];
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
