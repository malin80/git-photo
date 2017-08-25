//
//  HotelViewController.m
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HotelViewController.h"
#import "NavigationBar.h"
#import "HotelTableViewCell.h"
#import "SDWebImageCache.h"
#import "HotelManager.h"
#import "HotelInfo.h"
#import "SDWebImageCache.h"
#import "HotelDetailViewController.h"

@interface HotelViewController () <NavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"婚宴酒店"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryHotelSuccess) name:@"queryHotelSuccess" object:nil];
}

- (void)queryHotelSuccess {
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [GET_SINGLETON_FOR_CLASS(HotelManager) queryAllHotel];
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
    return GET_SINGLETON_FOR_CLASS(HotelManager).hotelInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    HotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[HotelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    HotelInfo *info = [GET_SINGLETON_FOR_CLASS(HotelManager).hotelInfos objectAtIndex:indexPath.row];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl, info.hotelHeadImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.titleView.image = image;
    }];
    cell.nameLabel.text = info.hotelName;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%ld-%ld/桌",info.minPrice,info.maxPrice];
    cell.contailLabel.text = [NSString stringWithFormat:@"容纳:%ld桌",info.containCount];
    cell.typeLabel.text = info.hotelType;
    cell.addressLabel.text = info.hotelAddress;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotelInfo *info = [GET_SINGLETON_FOR_CLASS(HotelManager).hotelInfos objectAtIndex:indexPath.row];
    HotelDetailViewController *controller = [[HotelDetailViewController alloc] init];
    controller.info = info;
    [GET_SINGLETON_FOR_CLASS(HotelManager) queryHotelWithId:info.hotelId];
    [self.navigationController pushViewController:controller animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
