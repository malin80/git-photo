//
//  VideoWorksViewController.m
//  Photo
//
//  Created by malin  on 2017/9/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "VideoWorksViewController.h"
#import "VideoManager.h"
#import "CeremonyTableViewCell.h"
#import "SDWebImageCache.h"
#import "VideoWorkInfo.h"
#import "VKVideoPlayerViewController.h"

@interface VideoWorksViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation VideoWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryVideoAuthorDetailSuccess) name:@"queryVideoAuthorDetailSuccess" object:nil];
}

- (void)queryVideoAuthorDetailSuccess {
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, ScreenHieght) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(VideoManager).videoWorkInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CeremonyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CeremonyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    VideoWorkInfo *info = [GET_SINGLETON_FOR_CLASS(VideoManager).videoWorkInfos objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.worksImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.titleView.image = image;
    }];
    
    cell.titleLabel.text = info.worksName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VKVideoPlayerViewController *viewController = [[VKVideoPlayerViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
    VideoWorkInfo *info = [GET_SINGLETON_FOR_CLASS(VideoManager).videoWorkInfos objectAtIndex:indexPath.row];
    [viewController playVideoWithStreamURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",baseUrl,info.worksVideo]]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
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
