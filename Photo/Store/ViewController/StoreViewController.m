//
//  StoreViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreViewController.h"
#import "StoreDetailViewController.h"
#import "StoreCollectionViewCell.h"

#import "StoreManager.h"
#import "GoodsInfo.h"
#import "Masonry.h"
#import "SDWebImageCache.h"

@interface StoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    UICollectionView *_collectionView;
    BOOL _isClicked1;
    BOOL _isClicked2;
    NSArray *_array;
    
    long _goodsType;
    NSString *_sortName;
}

@property (nonatomic, strong) UITableView *classifyTableView;
@property (nonatomic, strong) UITableView *sortTableView1;
@property (nonatomic, strong) UITableView *sortTableView2;

@property (nonatomic, strong) UILabel *classifyLabel;
@property (nonatomic, strong) UIImageView *classifyView;
@property (nonatomic, strong) UILabel *sortLabel;
@property (nonatomic, strong) UIImageView *sortView;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    [self createCollectionView];
    [self initView];
    _isClicked1 = NO;
    _array = [NSArray arrayWithObjects:@"产品销量升序", @"产品销量降序", nil];
    
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryGoodsInfoWithTypeSuccess) name:@"queryGoodsInfoWithTypeSuccess" object:nil];
}

- (void)queryGoodsInfoWithTypeSuccess {
    [_collectionView reloadData];
}

- (void)initView {
    [self.view addSubview:self.classifyTableView];
    [self.view addSubview:self.sortTableView1];
    [self.view addSubview:self.sortTableView2];

    UIButton *classifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 30)];
    [classifyBtn addTarget:self action:@selector(clickClassifyBtn) forControlEvents:UIControlEventTouchUpInside];
    classifyBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:classifyBtn];
    
    [classifyBtn addSubview:self.classifyLabel];
    [classifyBtn addSubview:self.classifyView];
    
    [_classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(classifyBtn);
        make.left.equalTo(@(10));
    }];
    [_classifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(classifyBtn);
        make.left.equalTo(_classifyLabel.mas_right).with.offset(5);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    UIButton *sortBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 30)];
    [sortBtn addTarget:self action:@selector(clickSortBtn) forControlEvents:UIControlEventTouchUpInside];
    sortBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sortBtn];
    
    [sortBtn addSubview:self.sortLabel];
    [sortBtn addSubview:self.sortView];
    
    [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sortBtn);
        make.left.equalTo(@(10));
    }];
    [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sortBtn);
        make.left.equalTo(_sortLabel.mas_right).with.offset(5);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    UIButton *reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth/3)*2, 0, ScreenWidth/3, 30)];
    [reloadBtn setTitle:@"重置参数" forState:UIControlStateNormal];
    reloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    reloadBtn.backgroundColor = [UIColor whiteColor];
    [reloadBtn setTitleColor:[UIColor colorR:83 G:87 B:85 alpha:1] forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(clickReloadBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reloadBtn];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line1.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, 0.5)];
    line2.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:line2];
}

- (void)clickClassifyBtn {
    if (!_isClicked1) {
        _classifyTableView.hidden = NO;
        _sortTableView1.hidden = YES;
        _sortTableView2.hidden = YES;
        _isClicked1 = YES;
        _classifyView.image = [UIImage imageNamed:@"store_less"];
        _sortView.image = [UIImage imageNamed:@"store_more"];
    } else {
        _classifyTableView.hidden = YES;
        _isClicked1 = NO;
        _classifyView.image = [UIImage imageNamed:@"store_more"];
    }
}

- (void)clickSortBtn {
    if (!_isClicked2) {
        _sortTableView1.hidden = NO;
        _sortTableView2.hidden = NO;
        _classifyTableView.hidden = YES;
        _isClicked2 = YES;
        _sortView.image = [UIImage imageNamed:@"store_less"];
        _classifyView.image = [UIImage imageNamed:@"store_more"];
    } else {
        _sortTableView1.hidden = YES;
        _sortTableView2.hidden = YES;
        _isClicked2 = NO;
        _sortView.image = [UIImage imageNamed:@"store_more"];
    }
}

- (void)clickReloadBtn {
    _classifyLabel.text = @"商品分类";
    _classifyView.image = [UIImage imageNamed:@"store_more"];
    _sortLabel.text = @"产品销量";
    _sortView.image = [UIImage imageNamed:@"store_more"];
    [GET_SINGLETON_FOR_CLASS(StoreManager) queryAllGoodsInfo];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 30);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-100) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[StoreCollectionViewCell class] forCellWithReuseIdentifier:@"MedalCell"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GET_SINGLETON_FOR_CLASS(StoreManager).goodsInfoArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MedalCell";
    StoreCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    GoodsInfo *info = GET_SINGLETON_FOR_CLASS(StoreManager).goodsInfoArray[indexPath.item];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.imageView.image = image;
    }];
    cell.goodsName.text = info.goodsName;
    cell.goodsPrice.text = [NSString stringWithFormat:@"特价：¥%ld",info.goodsPrice];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-30)/2, 260);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsInfo *info = [GET_SINGLETON_FOR_CLASS(StoreManager).goodsInfoArray objectAtIndex:indexPath.item];
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] init];
    controller.info = info;
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray.count;
    } else if (tableView.tag == 11) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    if (tableView.tag == 1) {
 
        NSArray *array = GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray;
        GoodsInfo *info = [[GoodsInfo alloc] init];
        info = array[indexPath.row];
        cell.textLabel.text = info.goodsTypeName;
        return cell;
    } else if (tableView.tag == 11) {
        NSArray *array = [NSArray arrayWithObjects:@"产品销量", @"产品价格", @"上架时间", nil];
        cell.textLabel.text = array[indexPath.row];
        return cell;
    } else {
        cell.textLabel.text = _array[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        NSArray *array = GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray;
        GoodsInfo *info = [[GoodsInfo alloc] init];
        info = array[indexPath.row];
        [GET_SINGLETON_FOR_CLASS(StoreManager) queryGoodsInfoWithGoodsType:info.goodsTypeId withSortName:@"" withSortOrder:@""];
        _goodsType = info.goodsTypeId;
        _classifyTableView.hidden = YES;
        _classifyView.image = [UIImage imageNamed:@"store_more"];
        _isClicked1 = NO;
        _classifyLabel.text = info.goodsTypeName;
    } else if (tableView.tag == 11) {
        switch (indexPath.row) {
            case 0:
                _array = [NSArray arrayWithObjects:@"产品销量升序", @"产品销量降序", nil];
                [_sortTableView2 reloadData];
                _sortName = @"GoodsCount";
                break;
            case 1:
                _array = [NSArray arrayWithObjects:@"产品价格升序", @"产品价格降序", nil];
                [_sortTableView2 reloadData];
                _sortName = @"GoodsPrice";
                break;
            case 2:
                _array = [NSArray arrayWithObjects:@"上架时间升序", @"上架时间降序", nil];
                [_sortTableView2 reloadData];
                _sortName = @"GoodsDate";
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
//                if (_goodsType == nil) {
//                    _goodsType = @"";
//                }
                if (_sortName == nil) {
                    _sortName = @"GoodsCount";
                }
                [GET_SINGLETON_FOR_CLASS(StoreManager) queryGoodsInfoWithGoodsType:_goodsType withSortName:_sortName withSortOrder:@"asc"];
                _sortTableView1.hidden = YES;
                _sortTableView2.hidden = YES;
                _isClicked2 = NO;
                _sortView.image = [UIImage imageNamed:@"store_more"];
                if ([_sortName isEqualToString:@"GoodsCount"] || [_sortName isEqualToString:@""]) {
                    _sortLabel.text = @"产品销量";
                } else if ([_sortName isEqualToString:@"GoodsPrice"]) {
                    _sortLabel.text = @"产品价格";
                } else {
                    _sortLabel.text = @"上架时间";
                }
                break;
            case 1:
                [GET_SINGLETON_FOR_CLASS(StoreManager) queryGoodsInfoWithGoodsType:_goodsType withSortName:_sortName withSortOrder:@"desc"];
                _sortTableView1.hidden = YES;
                _sortTableView2.hidden = YES;
                _isClicked2 = NO;
                _sortView.image = [UIImage imageNamed:@"store_more"];
                _sortLabel.text = _sortName;
                if ([_sortName isEqualToString:@"GoodsCount"] || [_sortName isEqualToString:@""]) {
                    _sortLabel.text = @"产品销量";
                } else if ([_sortName isEqualToString:@"GoodsPrice"]) {
                    _sortLabel.text = @"产品价格";
                } else {
                    _sortLabel.text = @"上架时间";
                }
                break;
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark --- getters and setters ---
- (UITableView *)classifyTableView {
    if (!_classifyTableView) {
        _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray.count*40-60) style:UITableViewStyleGrouped];
        _classifyTableView.dataSource = self;
        _classifyTableView.delegate = self;
        _classifyTableView.backgroundColor = [UIColor whiteColor];
        _classifyTableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _classifyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _classifyTableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
        _classifyTableView.tag = 1;
        _classifyTableView.hidden = YES;
    }
    return _classifyTableView;
}

- (UITableView *)sortTableView1 {
    if (!_sortTableView1) {
        _sortTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth/2, 120) style:UITableViewStyleGrouped];
        _sortTableView1.dataSource = self;
        _sortTableView1.delegate = self;
        _sortTableView1.backgroundColor = [UIColor whiteColor];
        _sortTableView1.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _sortTableView1.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _sortTableView1.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
        _sortTableView1.tag = 11;
        _sortTableView1.hidden = YES;
    }
    return _sortTableView1;
}

- (UITableView *)sortTableView2 {
    if (!_sortTableView2) {
        _sortTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth/2, 30, ScreenWidth, 80) style:UITableViewStyleGrouped];
        _sortTableView2.dataSource = self;
        _sortTableView2.delegate = self;
        _sortTableView2.backgroundColor = [UIColor whiteColor];
        _sortTableView2.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _sortTableView2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _sortTableView2.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
        _sortTableView2.tag = 12;
        _sortTableView2.hidden = YES;
    }
    return _sortTableView2;
}

- (UILabel *)classifyLabel {
    if (!_classifyLabel) {
        _classifyLabel = [[UILabel alloc] init];
        _classifyLabel.text = @"商品分类";
        [_classifyLabel sizeToFit];
        _classifyLabel.textColor = [UIColor colorR:83 G:87 B:85 alpha:1];
        _classifyLabel.font = [UIFont systemFontOfSize:14];
    }
    return _classifyLabel;
}

- (UIImageView *)classifyView {
    if (!_classifyView) {
        _classifyView = [[UIImageView alloc] init];
        _classifyView.image = [UIImage imageNamed:@"store_more"];

    }
    return _classifyView;
}

- (UILabel *)sortLabel {
    if (!_sortLabel) {
        _sortLabel = [[UILabel alloc] init];
        _sortLabel.text = @"产品销量";
        [_sortLabel sizeToFit];
        _sortLabel.textColor = [UIColor colorR:83 G:87 B:85 alpha:1];
        _sortLabel.font = [UIFont systemFontOfSize:14];
    }
    return _sortLabel;
}

- (UIImageView *)sortView {
    if (!_sortView) {
        _sortView = [[UIImageView alloc] init];
        _sortView.image = [UIImage imageNamed:@"store_more"];
    }
    return _sortView;
}

@end
