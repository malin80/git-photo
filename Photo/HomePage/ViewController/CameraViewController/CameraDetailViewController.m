//
//  CameraDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraDetailViewController.h"
#import "CameraDetailTableViewCell.h"
#import "CameraTeamViewController.h"

#import "CameraManager.h"
#import "CameraTeamInfo.h"
#import "SDWebImageCache.h"
#import "Masonry.h"

@interface CameraDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CameraDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [GET_SINGLETON_FOR_CLASS(CameraManager) queryCameraTeamWithGroupId:self.groupId];
    });
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCameraTeamWithGroupIdSuccess) name:@"queryCameraTeamWithGroupIdSuccess" object:nil];
}

- (void)createNodataView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHieght-358)];
    [self.view addSubview:backView];

    UIImageView *nodataView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"homepage_no_sheying"];
    nodataView.image = image;
    [backView addSubview:nodataView];

    [nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
        make.height.equalTo(@(160));
        make.width.equalTo(@(50));
    }];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHieght-358) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    [self.view addSubview:_tableView];

}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GET_SINGLETON_FOR_CLASS(CameraManager).cameraTeams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    CameraTeamInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraTeams objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.teamPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.teamImageView.image = image;
    }];

    cell.teamNameLabel.text = info.teamName;
    cell.teamDetailLabel.text = info.teamDetail;
    cell.teamPriceLabel.text = [NSString stringWithFormat:@"服务费¥%ld起",info.teamPrice];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CameraTeamInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraTeams objectAtIndex:indexPath.row];
    CameraTeamViewController *controller = [[CameraTeamViewController alloc] init];
    controller.info = info;
    [GET_SINGLETON_FOR_CLASS(CameraManager) queryCameraManWithTeamId:info.teamId];
    [GET_SINGLETON_FOR_CLASS(CameraManager) queryDressManWithTeamId:info.teamId];
    [self.navigationController pushViewController:controller animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark --- notification ---
- (void)queryCameraTeamWithGroupIdSuccess {
    if (GET_SINGLETON_FOR_CLASS(CameraManager).cameraTeams.count >0) {
        [self createTableView];
    } else {
        if (_tableView) {
            [_tableView removeFromSuperview];
        }
        [self createNodataView];
    }
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
