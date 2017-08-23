//
//  ClothCollectionViewController.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothCollectionViewController.h"
#import "ClothCollectionViewCell.h"
#import "ClothManager.h"
#import "ClothInfo.h"
#import "SDWebImageCache.h"

@interface ClothCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@end

@implementation ClothCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [GET_SINGLETON_FOR_CLASS(ClothManager) queryClothsWithTypeId:self.typeId];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryClothsSuccess) name:@"queryClothsSuccess" object:nil];
}

- (void)queryClothsSuccess {
    if (_collectionView) {
        [_collectionView removeFromSuperview];
    }
    [self createCollectionView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-100) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[ClothCollectionViewCell class] forCellWithReuseIdentifier:@"ClothCell"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GET_SINGLETON_FOR_CLASS(ClothManager).cloths.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"ClothCell";
    ClothCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ClothInfo *info = GET_SINGLETON_FOR_CLASS(ClothManager).cloths[indexPath.item];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.clothPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.imageView.image = image;
    }];
    cell.clothName.text = info.clothName;
    cell.clothPrice.text = [NSString stringWithFormat:@"¥%ld",info.clothPrice];
    cell.clothOldPrice.text = [NSString stringWithFormat:@"%ld",info.clothOldPrice];
    if (info.isHire) {
        cell.icon2.hidden = NO;
    }
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
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    GoodsInfo *info = [GET_SINGLETON_FOR_CLASS(StoreManager).goodsInfoArray objectAtIndex:indexPath.item];
//    StoreDetailViewController *controller = [[StoreDetailViewController alloc] init];
//    controller.info = info;
//    [self.navigationController pushViewController:controller animated:NO];
//}


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
