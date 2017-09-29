//
//  WeddingViewController.m
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "WeddingViewController.h"
#import "NavigationBar.h"
#import "WeddingManager.h"
#import "WeddingTableViewCell.h"
#import "WeddingBusinessInfo.h"
#import "SDWebImageCache.h"
#import "BusinessDetailViewController.h"

@interface WeddingViewController () <NavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WeddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    [GET_SINGLETON_FOR_CLASS(WeddingManager) queryAllWeddingBusiness];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"婚礼策划"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryAllBusinessSuceess) name:@"queryAllBusinessSuceess" object:nil];
}

- (void)queryAllBusinessSuceess {
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64) style:UITableViewStyleGrouped];
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
    NSArray *array = GET_SINGLETON_FOR_CLASS(WeddingManager).bussinessInfos;
    return GET_SINGLETON_FOR_CLASS(WeddingManager).bussinessInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeddingBusinessInfo *info = [GET_SINGLETON_FOR_CLASS(WeddingManager).bussinessInfos objectAtIndex:indexPath.row];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    WeddingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[WeddingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.titleLabel.text = info.businessName;
    cell.priceLabel.text = [NSString stringWithFormat:@"%ld",info.businessPrice];
    cell.detailLabel.text = [NSString stringWithFormat:@"套系 %ld/ 案例 %ld/ 评论 %ld",info.businessTypeCount,info.businessCaseCount,info.businessCommentCount];
    cell.subTitle1Label.text = info.businessSubText1;
    cell.subTitle2Label.text = info.businessSubText2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.businessPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.icon.image = image;
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeddingBusinessInfo *info = [GET_SINGLETON_FOR_CLASS(WeddingManager).bussinessInfos objectAtIndex:indexPath.row];
    [GET_SINGLETON_FOR_CLASS(WeddingManager) queryWeddingBusinessWithId:info.businessId];
    BusinessDetailViewController *controller = [[BusinessDetailViewController alloc] init];
    controller.info = info;
    [self.navigationController pushViewController:controller animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    self.navigationController.navigationBar.hidden = NO;
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
