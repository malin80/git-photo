//
//  HomePageViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageViewController.h"
#import "CameraViewController.h"

#import "HomePageScrollView.h"
#import "HomePageButtonView.h"
#import "HomePageTableViewCell.h"
#import "HomePageManager.h"
#import "ImageInfo.h"
#import "SDWebImageCache.h"

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, HomePageButtonViewDelegate>
{
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HomePageScrollView *scrollView;
@property (nonatomic, strong) HomePageButtonView *buttonView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.scrollView];
    [self.headerView addSubview:self.buttonView];
    [GET_SINGLETON_FOR_CLASS(HomePageManager) loadRecommendImages];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadRecommendImagesSuccess) name:@"loadRecommendImagesSuccess" object:nil];
}

- (void)loadRecommendImagesSuccess {
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght - 100) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor darkGrayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = _headerView;
    _tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.estimatedRowHeight = 100;//很重要保障滑动流畅性

    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return GET_SINGLETON_FOR_CLASS(HomePageManager).recommendImages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageInfo *info = GET_SINGLETON_FOR_CLASS(HomePageManager).recommendImages[indexPath.section];
    NSArray *images = GET_SINGLETON_FOR_CLASS(HomePageManager).singleRecommendImages[indexPath.section];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.title.text = info.imageName;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, ScreenWidth, 140);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(images.count*ScreenWidth, 140);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [cell.scrollView addSubview:scrollView];
    
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth-20, 140)];
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,images[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imageView.image = image;
        }];
        [scrollView addSubview:imageView];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


#pragma mark --- getters and setters ---
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 410)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (HomePageScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[HomePageScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200) withIsHomePage:YES];
    }
    return _scrollView;
}

- (HomePageButtonView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[HomePageButtonView alloc] initWithFrame:CGRectMake(0, 250, [[UIScreen mainScreen] bounds].size.width, 160)];
        _buttonView.delegate = self;
    }
    return _buttonView;
}

#pragma mark --- HomePageButtonViewDelegate ---
- (void)touchCameraButton {
    CameraViewController *controller = [[CameraViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}

@end
