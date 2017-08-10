//
//  DressManDetailThirdViewController.m
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "DressManDetailThirdViewController.h"
#import "CameraManDetailTableViewCell.h"

#import "CameraManager.h"

@interface DressManDetailThirdViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CameraManDetailTableViewCell *tableViewCell;

@end

@implementation DressManDetailThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght-180) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dressManInfo.commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.dressManInfo.commentList objectAtIndex:indexPath.row];
    GET_SINGLETON_FOR_CLASS(CameraManager).commentImages = [dict objectForKey:@"commentImgs"];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    CameraManDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CameraManDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    self.tableViewCell = cell;
    NSDictionary *memberDetail = [dict objectForKey:@"memberDetail"];
    cell.memberName.text = [memberDetail objectForKey:@"pickName"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,[memberDetail objectForKey:@"memberPic"]]];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    cell.memberView.image = imgFromUrl;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CameraManDetailTableViewCell *cell = self.tableViewCell;
    NSDictionary *dict = [self.dressManInfo.commentList objectAtIndex:indexPath.row];
    CGFloat height = [cell calculateCellHeight:dict];
    return height;
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
