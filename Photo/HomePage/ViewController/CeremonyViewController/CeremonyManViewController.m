//
//  CeremonyManViewController.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyManViewController.h"
#import "CeremonyManager.h"
#import "CameraManTableViewCell.h"
#import "CeremonyInfo.h"
#import "SDWebImageCache.h"
#import "CeremonyDetailViewController.h"

@interface CeremonyManViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CeremonyManViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    return GET_SINGLETON_FOR_CLASS(CeremonyManager).ceremonyManInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraManTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraManTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    CeremonyInfo *info = [GET_SINGLETON_FOR_CLASS(CeremonyManager).ceremonyManInfos objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.ceremonyPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.cameraManImage.image = image;
    }];
    
    cell.name.text = info.ceremonyName;
//    cell.content.text = info.cameraManContent;
//    cell.works.text = [NSString stringWithFormat:@"作品 %ld",info.worksOfCameraMan];
//    cell.subscribeCount.text = [NSString stringWithFormat:@"预约 %ld",info.subscribeCount];
//    cell.commentCount.text = [NSString stringWithFormat:@"评论 %ld",info.commentCount];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CeremonyDetailViewController *controller = [[CeremonyDetailViewController alloc] init];
    CeremonyInfo *info = [GET_SINGLETON_FOR_CLASS(CeremonyManager).ceremonyManInfos objectAtIndex:indexPath.row];
    controller.info = info;
    [GET_SINGLETON_FOR_CLASS(CeremonyManager) queryCeremonyDetailWithId:info.ceremonyId];
    [self.navigationController pushViewController:controller animated:NO];
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
