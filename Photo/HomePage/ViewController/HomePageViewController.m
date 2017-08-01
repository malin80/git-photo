//
//  HomePageViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageViewController.h"
#import "CameraViewController.h"

#import "HomePageScrollView.h"
#import "HomePageButtonView.h"
#import "HomePageTableViewCell.h"
#import "HomePagePesRequest.h"

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, HomePageButtonViewDelegate>
{
    NSArray *_titleArrays;
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HomePageScrollView *scrollView;
@property (nonatomic, strong) HomePageButtonView *buttonView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleArrays = [NSArray arrayWithObjects:@"婚纱摄影", @"婚庆服务", @"婚车租赁", @"花艺", @"酒店", nil];
    
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.scrollView];
    [self.headerView addSubview:self.buttonView];
    
    [self createTableView];
    
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor darkGrayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = _headerView;
    _tableView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.title.text = [_titleArrays objectAtIndex:indexPath.section];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


#pragma mark --- getters and setters ---
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 410)];
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}

- (HomePageScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[HomePageScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 250) withIsHomePage:YES];
    }
    return _scrollView;
}

- (HomePageButtonView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[HomePageButtonView alloc] initWithFrame:CGRectMake(0, 250, [[UIScreen mainScreen] bounds].size.width, 160)];
        _buttonView.delegate = self;
    }
    return _buttonView;
}

#pragma mark --- HomePageButtonViewDelegate ---
- (void)touchCameraButton {
    CameraViewController *controller = [[CameraViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

@end
