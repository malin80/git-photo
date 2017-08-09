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
#import "ShoppingGoodsInfo.h"
#import "ShoppingManager.h"

@interface ShoppingViewController () <UITableViewDelegate, UITableViewDataSource, ShoppingTableViewCellDelegate, ShoppingBottomViewDelegate>
{
    NSArray *_array;
    NSInteger _index;
    NSMutableArray *_selectedArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ShoppingBottomView *bottomView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos.count > 0) {
        [self createTableView];
        [self createBottomView];
    }
    [self addNotification];
    _selectedArray = [NSMutableArray array];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryShoppingGoodsInfoSuccess) name:@"queryShoppingGoodsInfoSuccess" object:nil];
}

- (void)queryShoppingGoodsInfoSuccess {
    [_tableView reloadData];
}

- (void)createBottomView {
    _bottomView = [[ShoppingBottomView alloc] initWithFrame:CGRectMake(0, ScreenHieght-160, ScreenWidth, 50)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.layer.borderWidth = 1;
    _bottomView.layer.borderColor = [[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0] CGColor];
    _bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-115) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor darkGrayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);

    [self.view addSubview:self.tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos objectAtIndex:indexPath.row];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    ShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[ShoppingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodsName.text = info.goodsName;
    cell.goodsParameter.text = info.goodsParamValue;
    cell.goodsPrice.text = [NSString stringWithFormat:@"%ld",info.goodsPrice];
    cell.goodsCount.text = [NSString stringWithFormat:@"×%ld",info.goodsCount];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic]];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    cell.goodsImage.image = imgFromUrl;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark --- ShoppingTableViewCellDelegate ---
- (void)selectGoodsInfo {
    ShoppingGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos objectAtIndex:_index];
    [_selectedArray addObject:info];
    if (_selectedArray.count == GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos.count) {
        [_bottomView changeSelectViewIconWithSelected:NO];
    }
}

- (void)selectedGoodsInfo {
    ShoppingGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos objectAtIndex:_index];
    [_selectedArray removeObject:info];
    if (_selectedArray.count != GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos.count) {
        [_bottomView changeSelectViewIconWithSelected:YES];
    }
}

#pragma mark --- ShoppingTableViewCellDelegate --- 
- (void)changeSelectedArrayWith:(BOOL)allSelected {

}

@end
