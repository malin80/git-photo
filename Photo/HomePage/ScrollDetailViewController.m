//
//  ScrollDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/10/13.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ScrollDetailViewController.h"
#import "CameraManager.h"
#import "ScrollDetailHeaderView.h"
#import "SDWebImageCache.h"

#define kHeaderViewHeight   300

@interface ScrollDetailViewController () <NavigationBarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ScrollDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    [self addScrollView];
    
    _dataSource = [self.imageInfo.imageSlideUrl componentsSeparatedByString:@";"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:nil];
    bar.delegate = self;
    [self.view addSubview:bar];

    [GET_SINGLETON_FOR_CLASS(CameraManager) queryDressManDetailWithId:self.imageInfo.dressManId];
    [GET_SINGLETON_FOR_CLASS(CameraManager) queryCameraManDetailWithId:self.imageInfo.cameraManId];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDressManDetailWithIdSuccess) name:@"queryDressManDetailWithIdSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCameraManDetailWithIdSuccess) name:@"queryCameraManDetailWithIdSuccess" object:nil];
}

- (void)queryDressManDetailWithIdSuccess {
    if (GET_SINGLETON_FOR_CLASS(CameraManager).cameraManInfo.cameraManPic) {
        [self addHeaderView];
        [self addImages];
    }
}

- (void)queryCameraManDetailWithIdSuccess {
    if (GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo.dressManPic) {
        [self addHeaderView];
        [self addImages];
    }
}

- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght)];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, _dataSource.count*80+kHeaderViewHeight+40);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
}

- (void)addHeaderView {
    if ([self.imageInfo.imageType isEqualToString:@"摄影"]) {
        ScrollDetailHeaderView *headerView = [[ScrollDetailHeaderView alloc] initWithFrame:CGRectMake(0, -64, ScreenWidth, kHeaderViewHeight) withType:ScrollDetailTypeAll];
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,GET_SINGLETON_FOR_CLASS(CameraManager).cameraManInfo.cameraManPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            headerView.cameraManView.image = image;
        }];

        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,GET_SINGLETON_FOR_CLASS(CameraManager).dressManInfo.dressManPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            headerView.dressManView.image = image;
        }];
        [_scrollView addSubview:headerView];
    } else if ([self.imageInfo.imageType isEqualToString:@"跟拍"]) {
        ScrollDetailHeaderView *headerView = [[ScrollDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeaderViewHeight) withType:ScrollDetailTypeCameraMan];
        [_scrollView addSubview:headerView];
    } else {
        ScrollDetailHeaderView *headerView = [[ScrollDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeaderViewHeight) withType:ScrollDetailTypeDressMan];
        [_scrollView addSubview:headerView];
    }
}

- (void)addImages {
    for (NSInteger i=0; i<_dataSource.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240+i*140, ScreenWidth, 140)];
        NSString *imageUrl = _dataSource[i];
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imageView.image = image;
        }];
        [_scrollView addSubview:imageView];
    }
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
