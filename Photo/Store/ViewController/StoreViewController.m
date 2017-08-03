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

@interface StoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    UICollectionView *_collectionView;
}

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 30);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-80) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[StoreCollectionViewCell class] forCellWithReuseIdentifier:@"MedalCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,info.goodsPic]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        cell.imageView.image = imgFromUrl;
        cell.goodsName.text = info.goodsName;
        cell.goodsPrice.text = [NSString stringWithFormat:@"特价：¥%ld",info.goodsPrice];
    });
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter]){
        reuseIdentifier = @"footerView";
    }else{
        reuseIdentifier = @"headerView";
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        view.backgroundColor = [UIColor redColor];
        UIButton *classifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 30)];
        classifyBtn.backgroundColor = [UIColor orangeColor];
        [classifyBtn addTarget:self action:@selector(clickClassifyBtn) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:classifyBtn];
        UIButton *sortBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 30)];
        sortBtn.backgroundColor = [UIColor blackColor];
        [view addSubview:sortBtn];
        UIButton *reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth/3)*2, 0, ScreenWidth/3, 30)];
        reloadBtn.backgroundColor = [UIColor yellowColor];
        [view addSubview:reloadBtn];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
    }
    return view;
}

- (void)clickClassifyBtn {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth, GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray.count*30) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    NSArray *array = GET_SINGLETON_FOR_CLASS(StoreManager).goodsClassifyArray;
    GoodsInfo *info = [[GoodsInfo alloc] init];
    info = array[indexPath.row];
    cell.textLabel.text = info.goodsTypeName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}


@end
