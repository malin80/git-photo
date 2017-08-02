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

@interface StoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    titleView.backgroundColor =[ UIColor redColor];
    [self.view addSubview:titleView];
    [self createCollectionView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 20;
    
//    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 20);
//    flowLayout.footerReferenceSize = CGSizeMake(ScreenWidth, 9);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreeHieght) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[StoreCollectionViewCell class] forCellWithReuseIdentifier:@"MedalCell"];
    
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
//    
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [self.view addSubview:_collectionView];
//    [_collectionView reloadData];
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
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://101.201.122.173/%@",info.goodsPic]];
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


@end
