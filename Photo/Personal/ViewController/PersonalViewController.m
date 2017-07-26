//
//  PersonalViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalViewController.h"
#import "UserDataViewController.h"
#import "OrderManageViewController.h"
#import "AddressViewController.h"
#import "CollectViewController.h"

#import "Masonry.h"
#import "PersonalTabelViewCell.h"
#import "PersonalHeaderView.h"
#import "EntrySection.h"
#import "EntryItem.h"
#import "CustomActionSheet.h"

@interface PersonalViewController () <UITableViewDelegate, UITableViewDataSource, CustomActionSheetDelegate>
{
    EntrySection *_section;

    EntryItem *_orderEntryItem;
    EntryItem *_shareEntryItem;
    EntryItem *_aboutEntryItem;
    EntryItem *_collectEntryItem;
    EntryItem *_addressEntryItem;
    EntryItem *_clearEntryItem;
    EntryItem *_updateEntryItem;
}
@property (nonatomic, strong) PersonalHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self createHeaderView];
    [self createTableView];
    [self updateSections];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)updateSections
{
    _section = EntrySection.new;
    _orderEntryItem = nil;
    _shareEntryItem = nil;
    _aboutEntryItem = nil;
    _collectEntryItem = nil;
    _addressEntryItem = nil;
    _clearEntryItem = nil;
    _updateEntryItem = nil;
    
    // 订单
    _orderEntryItem = [EntryItem iconName:@"personal_order"
                                      title:@"订单"
                                   selector:@selector(gotoOrderViewController)];
    [_section.items addObject:_orderEntryItem];
    
    //分享
    _shareEntryItem = [EntryItem iconName:@"personal_shareapp"
                                    title:@"分享"
                                 selector:@selector(gotoShareViewController)];
    [_section.items addObject:_shareEntryItem];
    
    //关于
    _aboutEntryItem = [EntryItem iconName:@"personal_about"
                                    title:@"关于"
                                 selector:@selector(gotoAboutViewController)];
    [_section.items addObject:_aboutEntryItem];

    // 收藏
    _collectEntryItem = [EntryItem iconName:@"personal_shoucang"
                                    title:@"收藏"
                                 selector:@selector(gotoCollectViewController)];
    [_section.items addObject:_collectEntryItem];

    // 收货地址
    _addressEntryItem = [EntryItem iconName:@"personal_address"
                                    title:@"收货地址"
                                 selector:@selector(gotoAddressViewController)];
    [_section.items addObject:_addressEntryItem];

    // 清除缓存
    _clearEntryItem = [EntryItem iconName:@"personal_celercacher"
                                    title:@"清空缓存"
                                 selector:@selector(gotoClearDataViewController)];
    [_section.items addObject:_clearEntryItem];

    // 检查更新
    _updateEntryItem = [EntryItem iconName:@"personal_update"
                                    title:@"软件检查更新"
                                 selector:@selector(gotoUpdateViewController)];
    [_section.items addObject:_updateEntryItem];
}


- (void)createHeaderView {
    _headerView = [[PersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 140)];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderView)];
    [_headerView addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:_headerView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64.0f - 80.0f) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    PersonalTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[PersonalTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    EntryItem *item = _section.items[indexPath.row];
    cell.icon.image = item.icon;
    cell.titleLabel.text = item.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryItem *item = _section.items[indexPath.row];
    [self performSelectorOnMainThread:item.selector withObject:nil waitUntilDone:YES];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --- gotoViewController ---
- (void)clickHeaderView {
    UserDataViewController *controller = [[UserDataViewController alloc] init];
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoOrderViewController {
    OrderManageViewController *viewController = [[OrderManageViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (void)gotoShareViewController {
    CustomActionSheet *action = [CustomActionSheet createShareActionSheet];
    action.delegate = self;
}

- (void)gotoAboutViewController {
    
}

- (void)gotoCollectViewController {
    CollectViewController *controller = [[CollectViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoAddressViewController {
    AddressViewController *controller = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoClearDataViewController {
    
}

- (void)gotoUpdateViewController {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showActionSheet {
    
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
