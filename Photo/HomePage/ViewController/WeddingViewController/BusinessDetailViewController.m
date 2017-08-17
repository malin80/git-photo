//
//  BusinessDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "NavigationBar.h"
#import "SDWebImageCache.h"
#import "Masonry.h"
#import "PersonalTabelViewCell.h"

#define kScrollViewHeight 160

@interface BusinessDetailViewController () <NavigationBarDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIView *_headerView;
    UITableView *_tableView;
    UITableView *_commentTabelView;
}
@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"商家详情"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    
    [self initView];
}

- (void)initView {
    [self createScrollView];
    [self createHeaderView];
    [self createTableView];
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, kScrollViewHeight)];
    NSArray *temp=[self.info.businessScrollPic componentsSeparatedByString:@";"];
    for (int i=0; i<temp.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, kScrollViewHeight)];
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,temp[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imageView.image = image;
            [_scrollView addSubview:imageView];
        }];
        
    }
    _scrollView.contentSize = CGSizeMake(temp.count*ScreenWidth, kScrollViewHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 190, ScreenWidth, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = temp.count;
    [self.view addSubview:_pageControl];
}

- (void)createHeaderView {
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = self.info.businessName;
    [_headerView addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = [NSString stringWithFormat:@"¥ %ld起",self.info.businessPrice];
    [_headerView addSubview:priceLabel];
    
    UILabel *introLabel = [[UILabel alloc] init];
    introLabel.text = self.info.businessIntroduction;
    [_headerView addSubview:introLabel];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(100));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView);
        make.centerY.equalTo(_headerView).with.offset(-30);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_headerView);
    }];
    
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView);
        make.centerY.equalTo(_headerView).with.offset(30);
    }];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tag = 101;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(160));
    }];
    
    _commentTabelView = [[UITableView alloc] init];
    _commentTabelView.dataSource = self;
    _commentTabelView.delegate = self;
    _commentTabelView.tag = 102;
    _commentTabelView.backgroundColor = [UIColor whiteColor];
    _commentTabelView.showsVerticalScrollIndicator = NO;
    _commentTabelView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _commentTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_commentTabelView];
    
    [_commentTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(self.info.businessCommentCount));
    }];
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
    PersonalTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[PersonalTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    switch (indexPath.row) {
        case 0:
            cell.titleLabel1.text = self.info.businessSubText1;
            cell.titleLabel2.text = self.info.businessSubText2;
            break;
        case 1:
            cell.icon.image = [UIImage imageNamed:@"personal_address"];
            cell.titleLabel.text = self.info.businessAddress;
            break;
        case 2:
            cell.titleLabel.text = self.info.businessPhone;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:
            height = 60;
            break;
        case 1:
            height = 40;
            break;
        case 2:
            height = 40;
            break;
        default:
            break;
    }
    return height;
}

#pragma mark --- UIScrollviewDelegate ---
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(_scrollView.frame);
    NSUInteger page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
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
