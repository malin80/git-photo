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
#import "Masonry.h"
#import "LoginManager.h"
#import "ConfirmOrderViewController.h"
#import "AddressInfo.h"
#import "PersonalManager.h"
#import "SDWebImageCache.h"

@interface ShoppingViewController () <UITableViewDelegate, UITableViewDataSource, ShoppingTableViewCellDelegate, ShoppingBottomViewDelegate>
{
    NSArray *_array;
    NSMutableArray *_selectedArray;
    long _goodsPrice;
    UIView *_noGoodsBackView;
    UIView *_loginOutBackView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ShoppingBottomView *bottomView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
    [self addNotification];
    _selectedArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [GET_SINGLETON_FOR_CLASS(LoginManager) getMemberInfo];
    [GET_SINGLETON_FOR_CLASS(ShoppingManager) queryShoppingGoodsInfoWithSafeCodeValue:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
    if (GET_SINGLETON_FOR_CLASS(LoginManager).loginOut == YES) {
        [self createLoginOutView];
    }
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryShoppingGoodsInfoSuccess) name:@"queryShoppingGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteShoppingGoodsInfoSuccess) name:@"deleteShoppingGoodsInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryShoppingGoodsInfoWithNoData) name:@"queryShoppingGoodsInfoWithNoData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberAddressSuccess) name:@"queryMemberAddressSuccess" object:nil];
}

- (void)queryShoppingGoodsInfoSuccess {
    if (!_tableView) {
        [self createTableView];
        [self createBottomView];
    } else {
        [_tableView reloadData];
    }
}

- (void)deleteShoppingGoodsInfoSuccess {
    [GET_SINGLETON_FOR_CLASS(ShoppingManager) queryShoppingGoodsInfoWithSafeCodeValue:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

- (void)queryShoppingGoodsInfoWithNoData {
    if (_tableView) {
        [_tableView removeFromSuperview];
        [_bottomView removeFromSuperview];
    }
    [self createNoGoodsView];
}

- (void)queryMemberAddressSuccess {
    for (AddressInfo *info in GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos) {
        if (info.status == 1) {
            GET_SINGLETON_FOR_CLASS(PersonalManager).normalAddressInfo = info;
        }
    }
}

- (void)createLoginOutView {
    if (_noGoodsBackView) {
        [_noGoodsBackView removeFromSuperview];
    }
    _loginOutBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght)];
    [self.view addSubview:_loginOutBackView];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"common_no_login"];
    [_loginOutBackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-30);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"你还没有登录哦！";
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [_loginOutBackView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).with.offset(5);
    }];
}

- (void)createNoGoodsView {
    if (_loginOutBackView) {
        [_loginOutBackView removeFromSuperview];
    }
    _noGoodsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght)];
    [self.view addSubview:_noGoodsBackView];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"shopping_no_goods"];
    [_noGoodsBackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-30);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"购物车没有商品，去逛逛";
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [_noGoodsBackView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).with.offset(5);
    }];
}

- (void)createBottomView {
    _bottomView = [[ShoppingBottomView alloc] initWithFrame:CGRectMake(0, ScreenHieght-180, ScreenWidth, 50)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.layer.borderWidth = 1;
    _bottomView.layer.borderColor = [[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0] CGColor];
    _bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-135) style:UITableViewStyleGrouped];
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
    cell.selectedView.selected = info.isSelected;
    cell.selectedView.tag = indexPath.row;
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.goodsImage.image = image;
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark --- ShoppingTableViewCellDelegate ---
- (void)selectGoodsInfo:(UIButton *)sender {
    ShoppingGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos objectAtIndex:sender.tag];
    [_selectedArray addObject:info];
    if (_selectedArray.count == GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos.count) {
        [_bottomView changeSelectViewIconWithSelected:NO];
    }
    _goodsPrice = _goodsPrice + info.goodsPrice;
    _bottomView.price.text = [NSString stringWithFormat:@"%ld",_goodsPrice];
}

- (void)selectedGoodsInfo:(UIButton *)sender {
    ShoppingGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos objectAtIndex:sender.tag];
    [_selectedArray removeObject:info];
    if (_selectedArray.count != GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos.count) {
        [_bottomView changeSelectViewIconWithSelected:YES];
    }
 
    _goodsPrice = _goodsPrice - info.goodsPrice;
    _bottomView.price.text = [NSString stringWithFormat:@"%ld",_goodsPrice];
}

- (void)deleteGoodsInfo:(UIButton *)sender {
    ShoppingGoodsInfo *info = [GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos objectAtIndex:sender.tag];
    [GET_SINGLETON_FOR_CLASS(ShoppingManager) deleteShoppingGoodsInfoWithCartId:info.goodsCartId withToken:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.safeCodeValue];
}

#pragma mark --- ShoppingBottomViewDelegate ---
- (void)changeSelectedArrayWith:(BOOL)allSelected {
    if (allSelected) {
        for (ShoppingGoodsInfo *info in GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos) {
            info.isSelected = NO;
            [_tableView reloadData];
            _goodsPrice = 0;
            _bottomView.price.text = [NSString stringWithFormat:@"%ld",_goodsPrice];
            [_selectedArray removeAllObjects];
        }
    } else {
        _goodsPrice = 0;
        for (ShoppingGoodsInfo *info in GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos) {
            info.isSelected = YES;
            [_tableView reloadData];
            _goodsPrice = _goodsPrice+info.goodsPrice;
            _bottomView.price.text = [NSString stringWithFormat:@"%ld",_goodsPrice];
            [_selectedArray addObject:info];
        }
    }
}

- (void)buyButtonClick {
    ConfirmOrderViewController *controller = [[ConfirmOrderViewController alloc] init];
    controller.goodsInfos = _selectedArray;
    [self.navigationController pushViewController:controller animated:NO];
}

@end
