//
//  CameraManViewController.m
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManViewController.h"
#import "CameraManDetailViewController.h"

#import "CameraManager.h"
#import "CameraManTableViewCell.h"
#import "CameraManInfo.h"
#import "SDWebImageCache.h"

@interface CameraManViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CameraManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCameraManSuccess) name:@"queryCameraManSuccess" object:nil];
}

- (void)queryCameraManSuccess {
    if (GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans.count > 0) {
        [self createTableView];
    } else {
        [self createNoDataView];
    }
}

- (void)createNoDataView {
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo((@(ScreenWidth)));
    }];
    
    UIImageView *nodataView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"homepage_no_order"];
    nodataView.image = image;
    [backView addSubview:nodataView];
    
    [nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
        make.height.equalTo(@(100));
        make.width.equalTo(@(70));
    }];
    
    UILabel *content = [[UILabel alloc] init];
    content.text = @"团队还没有摄影师！";
    content.font = [UIFont systemFontOfSize:12];
    [content sizeToFit];
    [backView addSubview:content];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.equalTo(nodataView.mas_bottom);
    }];
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
    return GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraManTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraManTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.cameraManPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.cameraManImage.image = image;
    }];

    cell.name.text = info.cameraManName;
    cell.content.text = info.cameraManContent;
    cell.works.text = [NSString stringWithFormat:@"作品 %ld",info.worksOfCameraMan];
    cell.subscribeCount.text = [NSString stringWithFormat:@"预约 %ld",info.subscribeCount];
    cell.commentCount.text = [NSString stringWithFormat:@"评论 %ld",info.commentCount];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CameraManDetailViewController *controller = [[CameraManDetailViewController alloc] init];
    NSArray *array = GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans;
    if (GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans.count > 0) {
        CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans objectAtIndex:indexPath.row];
        controller.cameraManInfo = info;
        controller.isSelectController = NO;
        [GET_SINGLETON_FOR_CLASS(CameraManager) queryCameraManDetailWithId:info.cameraManId];
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
