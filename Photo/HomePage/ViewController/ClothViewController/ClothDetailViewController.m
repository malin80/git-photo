//
//  ClothDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothDetailViewController.h"
#import "ClothDetailTableViewCell.h"
#import "SDWebImageCache.h"
#import "NavigationBar.h"
#import "ClothManager.h"
#import "ClothCommentTableViewCell.h"
#import "StoreCommentInfo.h"
#import "BuyClothViewController.h"

@interface ClothDetailViewController () < NavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, ClothCommentTableViewCellDelegate>
{
    NSArray *_picArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ClothDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"婚纱礼服"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];

    [self addNotification];
    [self initPicArray];
    [self createTableView];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHieght-50, ScreenWidth, 50)];
    bottomButton.backgroundColor = [UIColor colorR:255 G:102 B:1 alpha:1];
    [bottomButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(buyClothClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)buyClothClick {
    BuyClothViewController *controller = [[BuyClothViewController alloc] init];
    controller.info = self.info;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryClothDetailSuccess) name:@"queryClothDetailSuccess" object:nil];
}

- (void)queryClothDetailSuccess {
    if (_tableView) {
        [_tableView reloadData];
    }
}

- (void)initPicArray {
    _picArray = [self.info.clothDetailPic componentsSeparatedByString:@";"];
}

- (void)createTableView {
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.clothPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        headerView.image = image;
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-114) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return _picArray.count;
            break;
        case 3:
            return GET_SINGLETON_FOR_CLASS(ClothManager).commentInfos.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
            ClothDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[ClothDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            if (indexPath.row == 0) {
                cell.priceLabel.hidden = NO;
                cell.oldPriceLabel.hidden = NO;
                cell.line.hidden = NO;
                cell.icon1.hidden = NO;
                cell.titleView.hidden = YES;
                cell.titleLabel.hidden = YES;
                cell.clothView.hidden = YES;
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%ld",self.info.clothPrice];
                cell.oldPriceLabel.text = [NSString stringWithFormat:@"%ld",self.info.clothOldPrice];
                if (self.info.isHire) {
                    cell.icon2.hidden = NO;
                }
            } else if (indexPath.row == 1) {
                cell.titleView.hidden = NO;
                cell.titleLabel.hidden = NO;
                cell.priceLabel.hidden = YES;
                cell.oldPriceLabel.hidden = YES;
                cell.line.hidden = YES;
                cell.icon1.hidden = YES;
                cell.icon2.hidden = YES;
                cell.clothView.hidden = YES;
                cell.titleView.image = [UIImage imageNamed:@"personal_address"];
                cell.titleLabel.text = GET_SINGLETON_FOR_CLASS(ClothManager).clothShopInfo.shopAddress;
            } else if (indexPath.row == 2) {
                cell.titleView.hidden = NO;
                cell.titleLabel.hidden = NO;
                cell.titleView.image = [UIImage imageNamed:@"call"];
                cell.titleLabel.text = GET_SINGLETON_FOR_CLASS(ClothManager).clothShopInfo.shopPhone;
                cell.arrow.hidden = NO;
                cell.paramLabel.hidden = YES;
                cell.clothView.hidden = YES;
                cell.priceLabel.hidden = YES;
                cell.oldPriceLabel.hidden = YES;
                cell.icon1.hidden = YES;
                cell.icon2.hidden = YES;
                cell.line.hidden = YES;
            }
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
            ClothDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[ClothDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            NSArray *temp = [self.info.clothParam componentsSeparatedByString:@";"];
            if (indexPath.row == 0) {
                cell.paramLabel.hidden = NO;
                [cell setCommentContentText:temp[0] withCommentImageUrl:nil];
            } else if (indexPath.row == 1) {
                cell.paramLabel.hidden = NO;
                [cell setCommentContentText:temp[1] withCommentImageUrl:nil];
            }
            return cell;
        }
            break;
        case 2:
        {
            NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
            ClothDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[ClothDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            cell.titleView.hidden = YES;
            cell.titleLabel.hidden = YES;
            cell.arrow.hidden = YES;
            cell.paramLabel.hidden = YES;
            cell.clothView.hidden = NO;
            cell.priceLabel.hidden = YES;
            cell.oldPriceLabel.hidden = YES;
            cell.icon1.hidden = YES;
            cell.icon2.hidden = YES;
            cell.line.hidden = YES;
            [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,_picArray[indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                cell.clothView.image = image;
            }];
            return cell;
        }
        case 3:
        {
            NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify1"];
            ClothCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[ClothCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
                cell.delegate = self;
            }
            StoreCommentInfo *info = [GET_SINGLETON_FOR_CLASS(ClothManager).commentInfos objectAtIndex:indexPath.row];
            cell.memberName.text = info.commentName;
            [cell setCommentContentText:info.commentText withCommentImageUrl:info.commentImageUrl];
            [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.commentImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                cell.memberView.image = image;
            }];
            [cell createCommentImageWithUrl:info.commentImageUrl];
            [cell createCommentGradeViewWithGrade:info.commentGrade];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 40;
            break;
        case 1:
            if (indexPath.row == 0) {
                ClothDetailTableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
                return cell.frame.size.height;
            } else {
                return 40;
            }
            break;
        case 2:
            return 200;
            break;
        case 3:
        {
            ClothCommentTableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
            break;
        default:
            break;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    switch (section) {
        case 0:
        {
        }
            return headerView;
            break;
        case 1:
        {
            headerView.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        }
            return headerView;
        case 3:
        {
            headerView.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        }
            return headerView;
        default:
            break;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 20;
            break;
        case 2:
            return 20;
            break;
        case 3:
            return 20;
            break;
        default:
            break;
    }
    return 0;
}


#pragma mark --- NavigationBarDelegate ---
- (void)goBack {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- ClothCommentTableViewCellDelegate ---
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
