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
#import "WeddingManager.h"
#import "BusinessCommentTableViewCell.h"
#import "DLTabedSlideView.h"
#import "BusinessCaseViewController.h"
#import "BusinessTypeViewController.h"
#import "BusinessTypeSubViewController.h"
#import "WeddingMapViewController.h"

#define kScrollViewHeight 160

@interface BusinessDetailViewController () <NavigationBarDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, DLTabedSlideViewDelegate, BusinessCommentTableViewCellDelegate>
{
    UIScrollView *_backView;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIView *_headerView;
    UITableView *_tableView;
    UITableView *_commentTabelView;
    DLTabedSlideView *_tabedSlideView;
    
}
@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"商家详情"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    
    [self initView];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryWeddingBusinessWithIdSuceess) name:@"queryWeddingBusinessWithIdSuceess" object:nil];
}

- (void)queryWeddingBusinessWithIdSuceess {
    if (!_isSubViewController) {
        [self createCommentTableView];
    }
    [self createSlideView];
}

- (void)initView {
    _backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 600)];
    _backView.showsHorizontalScrollIndicator = NO;
    _backView.showsVerticalScrollIndicator = NO;
    _backView.contentSize = CGSizeMake(ScreenWidth, 1000);
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.delegate = self;
    _backView.scrollEnabled = YES;
    [self.view addSubview:_backView];
    
    [self createScrollView];
    [self createHeaderView];
    [self createTableView];
    if (_isSubViewController) {
        [self createSlideView];
    }
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kScrollViewHeight)];
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
    [_backView addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 130, ScreenWidth, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = temp.count;
    [_backView addSubview:_pageControl];
}

- (void)createHeaderView {
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_headerView];
    
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
        make.left.equalTo(_backView.mas_left);
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
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_backView addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(_backView.mas_left);
        make.height.equalTo(@(160));
    }];
}

- (void)createCommentTableView {
    _commentTabelView = [[UITableView alloc] init];
    _commentTabelView.dataSource = self;
    _commentTabelView.delegate = self;
    _commentTabelView.tag = 102;
    _commentTabelView.backgroundColor = [UIColor whiteColor];
    _commentTabelView.showsVerticalScrollIndicator = NO;
    _commentTabelView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _commentTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_backView addSubview:_commentTabelView];
    
    [_commentTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).with.offset(10);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(_backView.mas_left);
        make.height.equalTo(@(self.info.businessCommentCount*300));
    }];
}

- (void)createSlideView {
    _tabedSlideView = [[DLTabedSlideView alloc] init];
    _tabedSlideView.baseController = self;
    _tabedSlideView.delegate=self;
    _tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    _tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    _tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    _tabedSlideView.tabbarBottomSpacing = 3.0;
    if (!_isSubViewController) {
        DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"商家案例" image:nil selectedImage:nil];
        DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"热门套系" image:nil selectedImage:nil];
        _tabedSlideView.tabbarItems = @[item1, item2];
    } else {
        DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"套系详情" image:nil selectedImage:nil];
        DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"参考案例" image:nil selectedImage:nil];
        _tabedSlideView.tabbarItems = @[item1, item2];
    }

    [_tabedSlideView buildTabbar];
    _tabedSlideView.selectedIndex = 0;
    [_backView addSubview:_tabedSlideView];
    
    if (_isSubViewController) {
        [_tabedSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableView.mas_bottom).with.offset(10);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(320));
            make.left.equalTo(_backView.mas_left);
        }];
    } else {
        [_tabedSlideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentTabelView.mas_bottom).with.offset(-40);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(320));
            make.left.equalTo(_backView.mas_left);
        }];
    }
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 2;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    if (!_isSubViewController) {
        switch (index) {
            case 0:
            {
                BusinessCaseViewController *controller = [[BusinessCaseViewController alloc] init];
                return controller;
            }
            case 1:
            {
                BusinessTypeViewController *controller = [[BusinessTypeViewController alloc] init];
                return controller;
            }
            default:
                return nil;
        }
    } else {
        switch (index) {
            case 0:
            {
                BusinessTypeSubViewController *controller = [[BusinessTypeSubViewController alloc] init];
                return controller;
            }
            case 1:
            {
                BusinessTypeViewController *controller = [[BusinessTypeViewController alloc] init];
                return controller;
            }
            default:
                return nil;
        }
    }
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index {
    
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 101) {
        if (!_isSubViewController) {
            return 3;
        } else {
            return 2;
        }
    } else {
        return GET_SINGLETON_FOR_CLASS(WeddingManager).businessComments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 101) {
        NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify1"];
        PersonalTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[PersonalTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                cell.titleLabel1.text = self.info.businessSubText1;
                cell.titleLabel2.text = self.info.businessSubText2;
                break;
            case 1:
                if (!_isSubViewController) {
                    cell.icon.image = [UIImage imageNamed:@"personal_address"];
                    cell.titleLabel.text = self.info.businessAddress;
                } else {
                    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.businessPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        cell.subIcon.image = image;
                    }];
                    cell.subTitleLabel.text = self.info.businessName;
                    cell.subAddress.text = self.info.businessAddress;
                }
                break;
            case 2:
                cell.titleLabel.text = self.info.businessPhone;
                break;
            default:
                break;
        }
        return cell;
    } else {
        NSDictionary *dict = [GET_SINGLETON_FOR_CLASS(WeddingManager).businessComments objectAtIndex:indexPath.row];
        NSDictionary *memberDetail = [dict objectForKey:@"memberDetail"];
        NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify2"];
        BusinessCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[BusinessCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.delegate = self;
        }
        [cell setCommentContentText:[dict objectForKey:@"businessCommentText"] withCommentImageUrl:[dict objectForKey:@"businessCommentPic"]];
        cell.memberName.text = [memberDetail objectForKey:@"memberName"];;
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,[memberDetail objectForKey:@"memberPic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            cell.memberView.image = image;
        }];
        [cell createCommentImageWithUrl:[dict objectForKey:@"businessCommentPic"]];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 101) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
            {
                WeddingMapViewController *controller = [[WeddingMapViewController alloc] init];
                [self.navigationController pushViewController:controller animated:NO];
            }
                break;
            case 2:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.info.businessPhone]]];
                    break;
            default:
                break;
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (tableView.tag == 101) {
        if (!_isSubViewController) {
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
        } else {
            switch (indexPath.row) {
                case 0:
                    height = 60;
                    break;
                case 1:
                    height = 80;
                    break;
                default:
                    break;
            }
        }
    } else {
        BusinessCommentTableViewCell *cell = [self tableView:_commentTabelView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 102) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 40)];
        label.text = @"顾客评价";
        [view addSubview:label];
        view.backgroundColor = [UIColor clearColor];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView.tag == 102) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        view.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 102) {
        return 20;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 102) {
        return 40;
    } else {
        return 0;
    }
}


#pragma mark --- UIScrollviewDelegate ---
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(_scrollView.frame);
    NSUInteger page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- StoreCommentTableViewCellDelegate ---
- (void)touchCommentImage:(NSArray *)imageUrl select:(int)index{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imageUrl.count; i++) {
        // Get the large image url
        NSString *url = [imageUrl[i] stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
        UIImageView *imageView =[[UIImageView alloc]init];
        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:imageView imageUrl:[NSURL URLWithString:url]];
        [items addObject:item];
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:index];
    [browser showFromViewController:self];
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
