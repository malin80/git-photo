//
//  UserDataViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "UserDataViewController.h"

#import "NavigationBar.h"
#import "EntrySection.h"
#import "EntryItem.h"
#import "UserDataTableViewCell.h"

@interface UserDataViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate>
{
    NSMutableArray<EntrySection *> *_sections;
    
    EntryItem *_avatarEntryItem;
    EntryItem *_phoneNumberEntryItem;
    EntryItem *_nickNameEntryItem;
    EntryItem *_sexEntryItem;
    EntryItem *_birthdayEntryItem;
    EntryItem *_userNameEntryItem;
    EntryItem *_timeEntryItem;
    EntryItem *_passwordEntryItem;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:@"个人信息"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self updateSections];
    [self createTableView];
}

- (void)updateSections {
    _sections = [NSMutableArray array];
    EntrySection *section1 = [[EntrySection alloc] init];
    EntrySection *section2 = [[EntrySection alloc] init];
    EntrySection *section3 = [[EntrySection alloc] init];

    //头像
    _avatarEntryItem = [EntryItem title:@"头像" content:nil subtitle:nil selector:@selector(gotoAvatarViewController)];
    [section1.items addObject:_avatarEntryItem];
    
    //手机
    NSString *phoneNumber = @"13885229434";
    _phoneNumberEntryItem = [EntryItem title:@"手机" content:phoneNumber subtitle:nil selector:@selector(gotoAvatarViewController)];
    [section1.items addObject:_phoneNumberEntryItem];
    
    //昵称
    NSString *nickName = @"member_123456";
    _nickNameEntryItem = [EntryItem title:@"昵称" content:nickName subtitle:@"修改" selector:@selector(gotoAvatarViewController)];
    [section1.items addObject:_nickNameEntryItem];
    
    //性别
    _sexEntryItem = [EntryItem title:@"性别" content:nil subtitle:@"修改" selector:@selector(gotoAvatarViewController)];
    [section1.items addObject:_sexEntryItem];
    
    //生日
    _avatarEntryItem = [EntryItem title:@"生日" content:nil subtitle:@"修改" selector:@selector(gotoAvatarViewController)];
    [section2.items addObject:_avatarEntryItem];
    
    //姓名
    _userNameEntryItem = [EntryItem title:@"姓名" content:nil subtitle:@"修改" selector:@selector(gotoAvatarViewController)];
    [section2.items addObject:_userNameEntryItem];
    
    //婚期
    _timeEntryItem = [EntryItem title:@"婚期" content:nil subtitle:@"设置" selector:@selector(gotoAvatarViewController)];
    [section2.items addObject:_timeEntryItem];
    
    //密码
    _passwordEntryItem = [EntryItem title:@"密码" content:nil subtitle:@"修改" selector:@selector(gotoAvatarViewController)];
    [section3.items addObject:_passwordEntryItem];
    
    [_sections addObject:section1];
    [_sections addObject:section2];
    [_sections addObject:section3];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 70.0f) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor darkGrayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    UserDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UserDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    EntryItem *item = _sections[indexPath.section].items[indexPath.row];
    cell.title.text = item.title;
    cell.content.text = item.content;
    cell.subtitle.text = item.subtitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_sections[indexPath.section].items[indexPath.row].title isEqualToString:@"头像"]) {
        return 80;
    } else {
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    footerView.backgroundColor = [UIColor grayColor];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
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
