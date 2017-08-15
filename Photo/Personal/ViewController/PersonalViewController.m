//
//  PersonalViewController.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalViewController.h"
#import "UserDataViewController.h"
#import "OrderManageViewController.h"
#import "AddressViewController.h"
#import "CollectViewController.h"
#import "LoginViewController.h"

#import "Masonry.h"
#import "PersonalTabelViewCell.h"
#import "PersonalHeaderView.h"
#import "EntrySection.h"
#import "EntryItem.h"
#import "MemberInfo.h"

#import "LoginManager.h"
#import "PersonalManager.h"

@interface PersonalViewController () <UITableViewDelegate, UITableViewDataSource, LoginViewControllerDelegate>
{
    EntrySection *_section;

    EntryItem *_orderEntryItem;
    EntryItem *_shareEntryItem;
    EntryItem *_aboutEntryItem;
    EntryItem *_collectEntryItem;
    EntryItem *_addressEntryItem;
    EntryItem *_clearEntryItem;
    EntryItem *_updateEntryItem;
}
@property (nonatomic, strong) PersonalHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) loginBlock block;
@property (nonatomic, strong) LoginViewController *controller;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self createHeaderView];
    [self createTableView];
    [self updateSections];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }    
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
}

- (void)loginSuccess {
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    [self createHeaderView];
}

- (void)updateSections
{
    _section = EntrySection.new;
    _orderEntryItem = nil;
    _shareEntryItem = nil;
    _aboutEntryItem = nil;
    _collectEntryItem = nil;
    _addressEntryItem = nil;
    _clearEntryItem = nil;
    _updateEntryItem = nil;
    
    // 订单
    _orderEntryItem = [EntryItem iconName:@"personal_order"
                                      title:@"订  单"
                                   selector:@selector(gotoOrderViewController)];
    [_section.items addObject:_orderEntryItem];
    
    //分享
    _shareEntryItem = [EntryItem iconName:@"personal_shareapp"
                                    title:@"分  享"
                                 selector:@selector(gotoShareViewController)];
    [_section.items addObject:_shareEntryItem];
    
    //关于
    _aboutEntryItem = [EntryItem iconName:@"personal_about"
                                    title:@"关  于"
                                 selector:@selector(gotoAboutViewController)];
    [_section.items addObject:_aboutEntryItem];

    // 收藏
    _collectEntryItem = [EntryItem iconName:@"personal_shoucang"
                                    title:@"收  藏"
                                 selector:@selector(gotoCollectViewController)];
    [_section.items addObject:_collectEntryItem];

    // 收货地址
    _addressEntryItem = [EntryItem iconName:@"personal_address"
                                    title:@"收货地址"
                                 selector:@selector(gotoAddressViewController)];
    [_section.items addObject:_addressEntryItem];

    // 清除缓存
    _clearEntryItem = [EntryItem iconName:@"personal_celercacher"
                                    title:@"清空缓存"
                                 selector:@selector(gotoClearDataViewController)];
    [_section.items addObject:_clearEntryItem];

    // 检查更新
    _updateEntryItem = [EntryItem iconName:@"personal_update"
                                    title:@"软件检查更新"
                                 selector:@selector(updateApp)];
    [_section.items addObject:_updateEntryItem];
}


- (void)createHeaderView {
    _headerView = [[PersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140) withIsLoginOut:GET_SINGLETON_FOR_CLASS(LoginManager).loginOut];
    if (!GET_SINGLETON_FOR_CLASS(LoginManager).loginOut) {
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeaderView)];
        [_headerView addGestureRecognizer:tapGesturRecognizer];
    }
    [self.view addSubview:_headerView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64.0f - 80.0f) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"cellIdentify"];
    PersonalTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[PersonalTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    EntryItem *item = _section.items[indexPath.row];
    cell.icon.image = item.icon;
    cell.titleLabel.text = item.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryItem *item = _section.items[indexPath.row];
    [self performSelectorOnMainThread:item.selector withObject:nil waitUntilDone:YES];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --- gotoViewController ---
- (void)clickHeaderView {
    UserDataViewController *controller = [[UserDataViewController alloc] init];
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)gotoOrderViewController {
    if (GET_SINGLETON_FOR_CLASS(LoginManager).loginOut) {
        self.controller = [[LoginViewController alloc] init];
        self.controller.delegate = self;
        self.controller.block = ^{
            [self.controller dismissViewControllerAnimated:YES completion:nil];
            if (_headerView) {
                [_headerView removeFromSuperview];
            }
            [self createHeaderView];
        };
        [self presentViewController:self.controller animated:NO completion:^{
            
        }];
    } else {
        OrderManageViewController *viewController = [[OrderManageViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:NO];
    }
}

- (void)gotoShareViewController {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = @"http://mobile.umeng.com/social";
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }];
}

- (void)gotoAboutViewController {
    
}

- (void)gotoCollectViewController {
    if (GET_SINGLETON_FOR_CLASS(LoginManager).loginOut) {
        self.controller = [[LoginViewController alloc] init];
        self.controller.delegate = self;
        self.controller.block = ^{
            [self.controller dismissViewControllerAnimated:YES completion:nil];
            if (_headerView) {
                [_headerView removeFromSuperview];
            }
            [self createHeaderView];
        };
        [self presentViewController:self.controller animated:NO completion:^{
            
        }];
    } else {
        CollectViewController *controller = [[CollectViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)gotoAddressViewController {
    if (GET_SINGLETON_FOR_CLASS(LoginManager).loginOut) {
        self.controller = [[LoginViewController alloc] init];
        self.controller.delegate = self;
        self.controller.block = ^{
            [self.controller dismissViewControllerAnimated:YES completion:nil];
            if (_headerView) {
                [_headerView removeFromSuperview];
            }
            [self createHeaderView];
        };
        [self presentViewController:self.controller animated:NO completion:^{
            
        }];
    } else {
        AddressViewController *controller = [[AddressViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)gotoClearDataViewController {
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    [self showtext:@"清理成功"];
}

- (void)updateApp {
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    [GET_SINGLETON_FOR_CLASS(PersonalManager) updateApp];
}

#pragma loginViewControllerDelegate ---
- (void)loginViewControllerGoBack {
    [self.controller dismissViewControllerAnimated:NO completion:^{

    }];
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
