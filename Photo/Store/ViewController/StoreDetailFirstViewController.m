//
//  StoreDetailFirstViewController.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreDetailFirstViewController.h"

#import "StoreDetailTableViewCell.h"

#define kScrollViewHeight 230

@interface StoreDetailFirstViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *_scrollView;
    UILabel *_pageLabel;
    UILabel *_goodsCountLabel;
    UILabel *_goodsPriceLabel;
    UITableView *_tableView;
}

@end

@implementation StoreDetailFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createScrollView];
    [self initView];
    [self createTableView];
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, kScrollViewHeight);
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.contentSize = CGSizeMake(self.info.goodsSlideUrls.count*ScreenWidth, kScrollViewHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    [self createImageView];
}

- (void)createImageView {
//    [self stopTimer];
    for (int i = 0; i < self.info.goodsSlideUrls.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth+10, 0, ScreenWidth-20, kScrollViewHeight)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.goodsSlideUrls[i]]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        imageView.image = imgFromUrl;
        [_scrollView addSubview:imageView];
    }
//    _currentPage = 0;
//    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(_scrollView.frame);
    NSUInteger page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageLabel.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)page+1,(unsigned long)self.info.goodsSlideUrls.count];
}

- (void)initView {
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-80, 180, 50, 50)];
    _pageLabel.layer.masksToBounds = YES;
    _pageLabel.layer.cornerRadius = 50/2;
    _pageLabel.backgroundColor= [UIColor blackColor];
    _pageLabel.alpha = 0.5;
    _pageLabel.textColor = [UIColor orangeColor];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.text = [NSString stringWithFormat:@"1/%lu",self.info.goodsSlideUrls.count];
    [self.view addSubview:_pageLabel];
    
    _goodsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScrollViewHeight+10, 20, 20)];
    _goodsCountLabel.text = [NSString stringWithFormat:@"已售%ld件",self.info.goodsCount];
    _goodsCountLabel.textColor = [UIColor colorR:83 G:88 B:88 alpha:1];
    _goodsCountLabel.font = [UIFont systemFontOfSize:14];
    [_goodsCountLabel sizeToFit];
    [self.view addSubview:_goodsCountLabel];
    
    _goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-90, kScrollViewHeight+10, 40, 20)];
    _goodsPriceLabel.text = [NSString stringWithFormat:@"¥%ld",self.info.goodsPrice];
    _goodsPriceLabel.textColor = [UIColor colorR:254 G:155 B:0 alpha:1];
    _goodsPriceLabel.font = [UIFont systemFontOfSize:14];
    [_goodsPriceLabel sizeToFit];
    [self.view addSubview:_goodsPriceLabel];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScrollViewHeight+50, ScreenWidth, 180) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    _tableView.scrollEnabled = NO;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    StoreDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[StoreDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    switch (indexPath.row) {
        case 0:
            cell.title.text = @"产品名称";
            cell.content.text = [NSString stringWithFormat:@"%@",self.info.goodsName];
            break;
        case 1:
            cell.title.text = @"上架时间";
            cell.content.text = [NSString stringWithFormat:@"%@",self.info.goodsDate];
            break;
        case 2:
            cell.title.text = [NSString stringWithFormat:@"%@",self.info.goodsParamKey];
            cell.content.text = [NSString stringWithFormat:@"%@",self.info.goodsParamValue];
            break;
        default:
            break;
    }
    return cell;
}

//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 50, 50)];
    title.text = @"产品参数/DETAILS";
    title.textColor = [UIColor colorR:149 G:149 B:151 alpha:1];
    title.font = [UIFont systemFontOfSize:14];
    [title sizeToFit];
//    title.backgroundColor = [UIColor redColor];
    [view addSubview:title];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
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
