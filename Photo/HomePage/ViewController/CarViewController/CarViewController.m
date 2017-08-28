//
//  CarViewController.m
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CarViewController.h"
#import "CarManager.h"
#import "CarCollectionViewCell.h"
#import "SDWebImageCache.h"
#import "CarInfo.h"

@interface CarViewController () <NavigationBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"婚车"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [GET_SINGLETON_FOR_CLASS(CarManager) queryAllCar];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCarssSuccess) name:@"queryCarssSuccess" object:nil];
}

- (void)queryCarssSuccess {
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
    
    [_collectionView registerClass:[CarCollectionViewCell class] forCellWithReuseIdentifier:@"ClothCell"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GET_SINGLETON_FOR_CLASS(CarManager).carInfos.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"ClothCell";
    CarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    CarInfo *info = [GET_SINGLETON_FOR_CLASS(CarManager).carInfos objectAtIndex:indexPath.item];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.carPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.carView.image = image;
    }];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@",info.carAddress];
    cell.phoneLabel.text = [NSString stringWithFormat:@"%@",info.carPhone];

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
