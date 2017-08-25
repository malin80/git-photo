//
//  HotelDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HotelDetailViewController.h"
#import "NavigationBar.h"
#import "SDWebImageCache.h"
#import "HotelManager.h"
#import "HotelDetailTableViewCell.h"

@interface HotelDetailViewController () <NavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"婚宴酒店"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    
    [self createTableView];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryHotelDetailSuccess) name:@"queryHotelDetailSuccess" object:nil];
}

- (void)queryHotelDetailSuccess {
    [_tableView reloadData];
}

- (void)createTableView {
    UIView *headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.hotelPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        headerImageView.image = image;
    }];
    [headerBackView addSubview:headerImageView];
    UILabel *hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 200, 50)];
    hotelNameLabel.text = [NSString stringWithFormat:@"%@",self.info.hotelName];
    hotelNameLabel.textColor = [UIColor colorR:110 G:112 B:111 alpha:1];
    hotelNameLabel.font = [UIFont systemFontOfSize:16];
    [headerBackView addSubview:hotelNameLabel];
    UIImageView *gradeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 240, 120, 20)];
    if ([self.info.hotelGrade isEqualToString:@"0星"]) {
        gradeImageView.image = [UIImage imageNamed:@"evalevel0"];
    } else if ([self.info.hotelGrade isEqualToString:@"1星"]) {
        gradeImageView.image = [UIImage imageNamed:@"evalevel1"];
    } else if ([self.info.hotelGrade isEqualToString:@"2星"]) {
        gradeImageView.image = [UIImage imageNamed:@"evalevel2"];
    } else if ([self.info.hotelGrade isEqualToString:@"3星"]) {
        gradeImageView.image = [UIImage imageNamed:@"evalevel3"];
    } else if ([self.info.hotelGrade isEqualToString:@"4星"]) {
        gradeImageView.image = [UIImage imageNamed:@"evalevel4"];
    } else if ([self.info.hotelGrade isEqualToString:@"5星"]) {
        gradeImageView.image = [UIImage imageNamed:@"evalevel5"];
    }
    [headerBackView addSubview:gradeImageView];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 140, 40)];
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.textColor = [UIColor colorR:131 G:131 B:131 alpha:1];
    priceLabel.text = [NSString stringWithFormat:@"¥%ld-%ld/桌",self.info.minPrice,self.info.maxPrice];
    [headerBackView addSubview:priceLabel];
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, 240, 60, 20)];
    commentLabel.text = [NSString stringWithFormat:@"%ld条评论",GET_SINGLETON_FOR_CLASS(HotelManager).hotelCommentList.count];
    commentLabel.textColor = [UIColor colorR:198 G:198 B:198 alpha:1];
    commentLabel.font = [UIFont systemFontOfSize:12];
    [headerBackView addSubview:commentLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableHeaderView = headerBackView;
    [self.view addSubview:_tableView];
}

#pragma mark --- tableView delegate ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return GET_SINGLETON_FOR_CLASS(HotelManager).hotelHalls.count;
            break;
        case 3:
            return GET_SINGLETON_FOR_CLASS(HotelManager).hotelFoodMenus.count+1;
            break;
        case 4:
            return GET_SINGLETON_FOR_CLASS(HotelManager).hotelCommentList.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = @"";
    switch (indexPath.section) {
        case 0:
        {
            cellIdentify = [NSString stringWithFormat:@"HotelDetailTableViewCell"];
            HotelDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[HotelDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.info.hotelOrderDesc];
            return cell;
        }
            break;
        case 1:
        {
            cellIdentify = [NSString stringWithFormat:@"HotelDetailSecondTableViewCell"];
            HotelDetailSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[HotelDetailSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            switch (indexPath.row) {
                case 0:
                    cell.titleIcon.image = [UIImage imageNamed:@"personal_address"];
                    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.info.hotelAddress];
                    break;
                case 1:
                    cell.titleIcon.image = [UIImage imageNamed:@"personal_order"];
                    cell.titleLabel.text = [NSString stringWithFormat:@"酒店描述：%@",self.info.hotelDesc];
                    break;
                case 2:
                    cell.titleIcon.image = [UIImage imageNamed:@"call"];
                    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.info.hotelPhone];
                    cell.subTitle.hidden = NO;
                    cell.subTitle.text = @"联系商家";
                    break;
                default:
                    break;
            }
            return cell;
        }
            break;
        case 2:
        {
            cellIdentify = [NSString stringWithFormat:@"HotelDetailThirdTableViewCell"];
            HotelDetailThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[HotelDetailThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            for (NSDictionary *dict in GET_SINGLETON_FOR_CLASS(HotelManager).hotelHalls) {
                cell.titleLabel.text = [NSString stringWithFormat:@"宴会厅（%ld）",GET_SINGLETON_FOR_CLASS(HotelManager).hotelHalls.count];
                [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,[dict objectForKey:@"banquetHallPic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    cell.hallImageView.image = image;
                }];
                cell.hallNameLabel.text = [dict objectForKey:@"banquetHallName"];
                cell.hallContainLabel.text = [NSString stringWithFormat:@"桌数：%ld",[[dict objectForKey:@"banquetHallContainCount"] unsignedLongValue]];
                cell.hallHeight.text = [NSString stringWithFormat:@"层高：%ld",[[dict objectForKey:@"banquetHallFloorHeight"] unsignedLongValue]];
            }
            return cell;
        }
            break;
        case 3:
        {
            cellIdentify = [NSString stringWithFormat:@"HotelDetailFourthTableViewCell"];
            HotelDetailFourthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[HotelDetailFourthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            NSArray *array = GET_SINGLETON_FOR_CLASS(HotelManager).hotelFoodMenus;
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"婚宴菜单";
                cell.arrow.hidden = YES;
            } else {
                NSDictionary *dict = [array objectAtIndex:indexPath.row-1];
                cell.titleLabel.text = [dict objectForKey:@"menuName"];
                cell.subTitle.text = [NSString stringWithFormat:@"¥%@/桌",[dict objectForKey:@"menuPrice"]];
            }
            return cell;
        }
        case 4:
        {
            cellIdentify = [NSString stringWithFormat:@"HotelDetailFifthTableViewCell"];
            HotelDetailFifthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
            if (!cell) {
                cell = [[HotelDetailFifthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            }
            NSDictionary *dict = [GET_SINGLETON_FOR_CLASS(HotelManager).hotelCommentList objectAtIndex:indexPath.row];
            NSDictionary *memberDetail = [dict objectForKey:@"memberDetail"];
            cell.memberName.text = [memberDetail objectForKey:@"memberName"];;
            [cell setCommentContentText:[dict objectForKey:@"hotelCommentText"] withCommentImageUrl:[dict objectForKey:@"hotelCommentPic"]];
            [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,[memberDetail objectForKey:@"memberPic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                cell.memberView.image = image;
            }];
            [cell createCommentImageWithUrl:[dict objectForKey:@"hotelCommentPic"]];
            [cell createCommentGradeViewWithGrade:[dict objectForKey:@"hotelCommentGrade"]];
            return cell;
        }
            break;
        default:
            break;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 40;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 120;
            break;
        case 3:
            return 40;
            break;
        case 4:
        {
            HotelDetailFifthTableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
            CGFloat height = cell.frame.size.height;
            NSLog(@"height ===%f",height);
            return cell.frame.size.height;
            break;
        }
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    switch (section) {
        case 1:
        {
            headerView.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        }
            return headerView;
        case 2:
        {
            headerView.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        }
            return headerView;
        case 3:
        {
            headerView.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        }
            return headerView;
        case 4:
        {
            headerView.backgroundColor = [UIColor colorR:238 G:238 B:238 alpha:1];
        }
            return headerView;
        default:
            break;
    }
    return nil;
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
        case 4:
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
