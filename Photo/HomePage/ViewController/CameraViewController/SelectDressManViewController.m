//
//  SelectDressManViewController.m
//  Photo
//
//  Created by malin  on 2017/8/14.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "SelectDressManViewController.h"
#import "NavigationBar.h"
#import "CameraManager.h"
#import "CameraManTableViewCell.h"
#import "DressManInfo.h"
#import "CameraManDetailViewController.h"
#import "SDWebImageCache.h"

@interface SelectDressManViewController () <NavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SelectDressManViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"选择化妆师"];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
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
    return GET_SINGLETON_FOR_CLASS(CameraManager).dressMans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraManTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraManTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    DressManInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).dressMans objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.dressManPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.cameraManImage.image = image;
    }];
    cell.name.text = info.dressManName;
    cell.content.text = info.dressManContent;
    cell.works.text = [NSString stringWithFormat:@"作品 %ld",info.worksOfDressMan];
    cell.subscribeCount.text = [NSString stringWithFormat:@"预约 %ld",info.subscribeCount];
    cell.commentCount.text = [NSString stringWithFormat:@"评论 %ld",info.commentCount];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DressManInfo *dressManInfo = [GET_SINGLETON_FOR_CLASS(CameraManager).dressMans objectAtIndex:indexPath.row];
    GET_SINGLETON_FOR_CLASS(CameraManager).selectedDressManInfo = dressManInfo;
    [GET_SINGLETON_FOR_CLASS(CameraManager) queryDressManDetailWithId:dressManInfo.dressManId];
    CameraManDetailViewController *controller = [[CameraManDetailViewController alloc] init];
    CameraManInfo *info = [GET_SINGLETON_FOR_CLASS(CameraManager).cameraMans objectAtIndex:indexPath.row];
    controller.cameraManInfo = info;
    controller.isSelectController = YES;
    [self.navigationController pushViewController:controller animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
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
