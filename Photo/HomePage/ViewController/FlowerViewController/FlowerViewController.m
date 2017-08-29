//
//  FlowerViewController.m
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "FlowerViewController.h"
#import "FlowerManager.h"
#import "FlowerCollectionViewCell.h"
#import "SDWebImageCache.h"
#import "FlowerInfo.h"
#import "FlowerDetailViewController.h"

@interface FlowerViewController () <NavigationBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}

@end

@implementation FlowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"花艺"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [GET_SINGLETON_FOR_CLASS(FlowerManager) queryAllFlower];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryFlowerSuccess) name:@"queryFlowerSuccess" object:nil];
}

- (void)queryFlowerSuccess {
    if (!_collectionView) {
        [self createCollectionView];
    } else {
        [_collectionView reloadData];
    }
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-100) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [_collectionView registerClass:[FlowerCollectionViewCell class] forCellWithReuseIdentifier:@"ClothCell"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GET_SINGLETON_FOR_CLASS(FlowerManager).flowerInfos.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"ClothCell";
    FlowerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    FlowerInfo *info = [GET_SINGLETON_FOR_CLASS(FlowerManager).flowerInfos objectAtIndex:indexPath.item];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.flowerPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.flowerView.image = image;
    }];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@",info.flowerAddress];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",info.flowerName];
    cell.descLabel.text = [NSString stringWithFormat:@"%@",info.flowerDesc];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥ %ld",info.flowerPrice];
    cell.oldPriceLabel.text = [NSString stringWithFormat:@"门市价：%ld",info.flowerOldPrice];
    
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
    FlowerDetailViewController *controller = [[FlowerDetailViewController alloc] init];
    FlowerInfo *info = [GET_SINGLETON_FOR_CLASS(FlowerManager).flowerInfos objectAtIndex:indexPath.item];
    controller.info = info;
    [self.navigationController pushViewController:controller animated:NO];
}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    self.navigationController.navigationBar.hidden = NO;
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
