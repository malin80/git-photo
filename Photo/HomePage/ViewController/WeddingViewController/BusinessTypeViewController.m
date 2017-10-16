//
//  BusinessTypeViewController.m
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BusinessTypeViewController.h"
#import "WeddingManager.h"
#import "BusinessTypesTableViewCell.h"
#import "SDWebImageCache.h"
#import "BusinessDetailViewController.h"

@interface BusinessTypeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BusinessTypeViewController

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
    return GET_SINGLETON_FOR_CLASS(WeddingManager).businessTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    BusinessTypesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[BusinessTypesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    NSDictionary *dict = GET_SINGLETON_FOR_CLASS(WeddingManager).businessTypes[indexPath.row];
    cell.priceLabel.hidden = NO;
    cell.countLabel.hidden = NO;
    cell.titleLabel.text = [dict objectForKey:@"businessSetName"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"businessSetPreferentialPrice"]];
    cell.countLabel.text = [NSString stringWithFormat:@"已售：%@",[dict objectForKey:@"businessSetSoldNumber"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,[dict objectForKey:@"businessSetPic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.iconView.image = image;
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessDetailViewController *controller = [[BusinessDetailViewController alloc] init];
    controller.isSubViewController = YES;
    controller.info = [GET_SINGLETON_FOR_CLASS(WeddingManager).bussinessInfos objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
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
