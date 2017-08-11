//
//  StoreDetailThirdViewController.m
//  Photo
//
//  Created by malin  on 2017/8/11.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreDetailThirdViewController.h"
#import "StoreCommentInfo.h"
#import "StoreManager.h"
#import "TableViewCellCalculator.h"
#import "StoreCommentTableViewCell.h"

@interface StoreDetailThirdViewController () <UITableViewDelegate, UITableViewDataSource>
{
    TableViewCellCalculator *heightCalculator;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) StoreCommentTableViewCell *prototypeCell;

@end

@implementation StoreDetailThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght - 190) style:UITableViewStyleGrouped];
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
    return GET_SINGLETON_FOR_CLASS(StoreManager).storeComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreCommentInfo *info = [GET_SINGLETON_FOR_CLASS(StoreManager).storeComments objectAtIndex:indexPath.row];
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    StoreCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];

    if (!cell) {
        cell = [[StoreCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    self.prototypeCell = cell;
    [cell setCommentContentText:info.commentText withCommentImageUrl:info.commentImageUrl];
    cell.memberName.text = info.commentName;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,info.commentImage]];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    cell.memberView.image = imgFromUrl;
    cell.backgroundColor = [UIColor darkGrayColor];
    [cell createCommentImageWithUrl:info.commentImageUrl];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreCommentTableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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
