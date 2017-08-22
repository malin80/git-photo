//
//  BusinessCaseDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/22.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BusinessCaseDetailViewController.h"
#import "BusinessCaseDetailTableViewCell.h"
#import "SDWebImageCache.h"
#import "NavigationBar.h"
#import "BusinessDetailViewController.h"

@interface BusinessCaseDetailViewController () <UITableViewDelegate, UITableViewDataSource, NavigationBarDelegate>
{
    NSArray *_picArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BusinessCaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"摄影"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];

    [self initDataSource];
    [self createHeaderView];
    [self createTableView];
}

- (void)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel *caseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 140, 60)];
    caseNameLabel.text = self.info.businessName;
    caseNameLabel.textColor = [UIColor colorR:68 G:72 B:70 alpha:1];
    caseNameLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:caseNameLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 120, 20, 80, 20)];
    [button setTitle:@"进入店铺" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorR:227 G:209 B:184 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor colorR:227 G:209 B:184 alpha:1] CGColor];
    button.layer.cornerRadius = 10;
    [button addTarget:self action:@selector(enterStore) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
}

- (void)enterStore {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)initDataSource {
    _picArray = [self.info.businessCasePic componentsSeparatedByString:@";"];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 128, ScreenWidth, ScreenHieght-128) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _picArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    BusinessCaseDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BusinessCaseDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    NSString *picString = [_picArray objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,picString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.iconView.image = image;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    titleLabel.text = self.info.businessTypeName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorR:68 G:72 B:70 alpha:1];
    [footerView addSubview:titleLabel];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80, 40, 200, 40)];
    priceLabel.text = [NSString stringWithFormat:@"¥%ld",self.info.businessCasePrice];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor colorR:68 G:72 B:70 alpha:1];
    [footerView addSubview:priceLabel];
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+40, 40, 200, 40)];
    countLabel.text = [NSString stringWithFormat:@"已售：%ld",self.info.businessTypeSoldNumber];
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.textColor = [UIColor colorR:68 G:72 B:70 alpha:1];
    [footerView addSubview:countLabel];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    UILabel *styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth, 40)];
    styleLabel.text = [NSString stringWithFormat:@"风格：%@",self.info.businessTypeStyle];
    styleLabel.font = [UIFont systemFontOfSize:14];
    styleLabel.textColor = [UIColor colorR:68 G:72 B:70 alpha:1];
    [headerView addSubview:styleLabel];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, ScreenWidth, 40)];
    priceLabel.text = [NSString stringWithFormat:@"参考价：%ld",self.info.businessCasePrice];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor colorR:68 G:72 B:70 alpha:1];
    [headerView addSubview:priceLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
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
