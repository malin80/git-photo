//
//  ShoppingViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingTableViewCell.h"
#import "ShoppingBottomView.h"

@interface ShoppingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ShoppingBottomView *bottomView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self createBottomView];
}

- (void)createBottomView {
    _bottomView = [[ShoppingBottomView alloc] initWithFrame:CGRectMake(0, ScreeHieght-180, ScreenWidth, 100)];
    _bottomView.layer.borderWidth = 1;
    _bottomView.layer.borderColor = [[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0] CGColor];
    [self.view addSubview:self.bottomView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor darkGrayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    ShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[ShoppingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end
