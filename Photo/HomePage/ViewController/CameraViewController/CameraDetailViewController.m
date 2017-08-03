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

#import "HomePageManager.h"
#import "CameraTeamInfo.h"

@interface CameraDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CameraDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    if (GET_SINGLETON_FOR_CLASS(HomePageManager).cameraTeams.count >0) {
        [self createTableView];
    }
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryCameraTeamWithGroupIdSuccess) name:@"queryCameraTeamWithGroupIdSuccess" object:nil];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, ScreenHieght) style:UITableViewStyleGrouped];
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
    return GET_SINGLETON_FOR_CLASS(HomePageManager).cameraTeams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    CameraTeamInfo *info = [GET_SINGLETON_FOR_CLASS(HomePageManager).cameraTeams objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://101.201.122.173/%@",info.teamPic]];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    cell.teamImageView.image = imgFromUrl;
    cell.teamNameLabel.text = info.teamName;
    cell.teamDetailLabel.text = info.teamDetail;
    cell.teamPriceLabel.text = [NSString stringWithFormat:@"服务费¥%ld起",info.teamPrice];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CameraTeamInfo *info = [GET_SINGLETON_FOR_CLASS(HomePageManager).cameraTeams objectAtIndex:indexPath.row];
    CameraTeamViewController *controller = [[CameraTeamViewController alloc] init];
    controller.info = info;
    [self.navigationController pushViewController:controller animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark --- notification ---
- (void)queryCameraTeamWithGroupIdSuccess {
    if (!_tableView) {
        [self createTableView];
    }
    [_tableView reloadData];
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
