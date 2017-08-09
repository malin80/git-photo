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
#import "PersonalManager.h"
#import "LoginManager.h"
#import "Masonry.h"
#import "AddressInfo.h"

@interface AddressViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate, AddressTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];

    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"管理收货地址"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self addNotifiCation];
}

- (void)addNotifiCation {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberAddressWithNoAddress) name:@"queryMemberAddressWithNoAddress" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMemberAddressSuccess) name:@"addMemberAddressSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMemberAddressSuccess) name:@"updateMemberAddressSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberAddressSuccess) name:@"queryMemberAddressSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteMemberAddressSuccess) name:@"deleteMemberAddressSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeAddressDefaultSuccess) name:@"makeAddressDefaultSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAddressDefaultSuccess) name:@"cancelAddressDefaultSuccess" object:nil];
}

- (void)queryMemberAddressSuccess {
    if (!_tableView) {
        [self createTableView];
    } else {
        [_tableView reloadData];
    }
    [self createBottomButton];
}

- (void)queryMemberAddressWithNoAddress {
    [self createNoAddressView];
}

- (void)addMemberAddressSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
}

- (void)updateMemberAddressSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
}

- (void)deleteMemberAddressSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
}

- (void)makeAddressDefaultSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
}

- (void)cancelAddressDefaultSuccess {
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
}

- (void)createNoAddressView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"personal_no_address"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(60));
        make.height.equalTo(@(80));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"还没有收货地址哦";
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).with.offset(5);
    }];
    
    [self createBottomButton];
}

- (void)createBottomButton {
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght- 40, ScreenWidth, 40)];
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
    return GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressInfo *info = GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos[indexPath.row];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = info.name;
    cell.phoneLabel.text = info.phone;
    cell.addressLabel.text = info.address;
    cell.selectedView.selected = info.status;
    if (cell.selectedView.selected == 0) {
        cell.normalAddressLabel.text = @"设为默认";
    } else {
        cell.normalAddressLabel.text = @"取消默认";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    //之前选中的cell
//    AddressTableViewCell *lastCell = [tableView viewWithTag:1];
//    lastCell.tag = 0;
//    lastCell.normalAddressLabel.text = @"设为默认";
//    lastCell.selectedView.selected = NO;
//    //目前选中的cell
//    AddressTableViewCell *nowCell = [tableView cellForRowAtIndexPath:indexPath];
//    nowCell.tag = 1;
//    nowCell.normalAddressLabel.text = @"默认地址";
//    nowCell.selectedView.selected = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- AddressTableViewCellDelegate ---
- (void)editAddressWithAddressName:(NSString *)name {
    for (AddressInfo *info in GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos) {
        if ([info.name isEqualToString:name]) {
            EditAddressViewController *controller = [[EditAddressViewController alloc] init];
            controller.info = info;
            [self.navigationController pushViewController:controller animated:NO];
        }
    }
}

- (void)deleteAddressWithAddressName:(NSString *)name {
    for (AddressInfo *info in GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos) {
        if ([info.name isEqualToString:name]) {
            [GET_SINGLETON_FOR_CLASS(PersonalManager) deleteMemberAddressWithAddressId:info.addressId];
        }
    }
}

- (void)makeAddressDefaultWithAddressName:(NSString *)name {
    for (AddressInfo *info in GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos) {
        if ([info.name isEqualToString:name]) {
            [GET_SINGLETON_FOR_CLASS(PersonalManager) makeAddressDefaultWithAddressId:info.addressId];
        }
    }
}

- (void)cancelAddressDefaultWithAddressName:(NSString *)name {
    for (AddressInfo *info in GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos) {
        if ([info.name isEqualToString:name]) {
            [GET_SINGLETON_FOR_CLASS(PersonalManager) cancelAddressDefaultWithAddressId:info.addressId];
        }
    }
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
