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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor darkGrayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = _headerView;
    _tableView.showsVerticalScrollIndicator = NO;

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
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.title.text = info.imageName;
//    NSArray *array = GET_SINGLETON_FOR_CLASS(HomePageManager).singleRecommendImages;
//    cell.scrollView.contentSize = CGSizeMake(array.count*ScreenWidth, 140);
//    cell.scrollView.backgroundColor = [UIColor orangeColor];
//    for (int i = 0; i<GET_SINGLETON_FOR_CLASS(HomePageManager).singleRecommendImages.count; i++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, 140)];
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,GET_SINGLETON_FOR_CLASS(HomePageManager).singleRecommendImages[i]]];
//        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
//        imageView.image = imgFromUrl;
//        [cell.scrollView addSubview:imageView];
//    }

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
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}

- (HomePageScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[HomePageScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 250) withIsHomePage:YES];
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
