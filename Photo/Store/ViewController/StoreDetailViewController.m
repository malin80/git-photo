//
//  StoreDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreDetailViewController.h"
#import "StoreDetailFirstViewController.h"
#import "StoreDetailSecondViewController.h"
#import "StoreDetailThirdViewController.h"
#import "AddGoodsToShoppingViewController.h"

#import "StoreManager.h"
#import "LoginManager.h"
#import "NavigationBar.h"
#import "DLTabedSlideView.h"
#import "PersonalManager.h"
#import "AddressInfo.h"

@interface StoreDetailViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate>

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    [GET_SINGLETON_FOR_CLASS(PersonalManager) queryMemberAddressWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId];
    [GET_SINGLETON_FOR_CLASS(StoreManager) queryGoodsDetailInfoWithGoodsId:self.info.goodsId];

    self.navigationController.navigationBarHidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64) withTitle:[NSString stringWithFormat:@"%@ 详情",self.info.goodsName]];
    bar.delegate = self;
    [self.view addSubview:bar];
    
    [self initView];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberAddressSuccess) name:@"queryMemberAddressSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectGoodsSuccess) name:@"collectGoodsSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addGoodsToShoppingSuccess) name:@"addGoodsToShoppingSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryMemberAddressWithNoAddress) name:@"queryMemberAddressWithNoAddress" object:nil];
}

- (void)addGoodsToShoppingSuccess {
    [self showtext:@"添加成功"];
}

- (void)queryMemberAddressSuccess {
    for (AddressInfo *info in GET_SINGLETON_FOR_CLASS(PersonalManager).addressInfos) {
        if (info.status == 1) {
            GET_SINGLETON_FOR_CLASS(PersonalManager).normalAddressInfo = info;
        }
    }
}

- (void)queryMemberAddressWithNoAddress {
    GET_SINGLETON_FOR_CLASS(PersonalManager).normalAddressInfo = nil;
}

- (void)collectGoodsSuccess {
    [self showtext:@"收藏成功"];
}

- (void)initView {
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"商品" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"详情" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"评价" image:nil selectedImage:nil];

    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHieght-60, ScreenWidth, 60)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UIButton *collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.2, 60)];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor colorR:250 G:250 B:250 alpha:1] forState:UIControlStateNormal];
    collectBtn.backgroundColor= [UIColor colorR:128 G:128 B:128 alpha:1];
    [collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectBtn];
    
    UIButton *addCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth*0.2, 0, ScreenWidth*0.4, 60)];
    [addCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addCarBtn setTitleColor:[UIColor colorR:248 G:246 B:230 alpha:1] forState:UIControlStateNormal];
    addCarBtn.backgroundColor = [UIColor colorR:254 G:224 B:51 alpha:1];
    [addCarBtn addTarget:self action:@selector(addCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addCarBtn];
    
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth*0.6, 0, ScreenWidth*0.4, 60)];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor colorR:248 G:246 B:230 alpha:1] forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor colorR:255 G:51 B:52 alpha:1];
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyBtn];
}

#pragma mark --- button method ---
- (void)collectBtnClick {
    [GET_SINGLETON_FOR_CLASS(StoreManager) collectGoodsWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId withGoodsId:self.info.goodsId];
}

- (void)addCarBtnClick {
    AddGoodsToShoppingViewController *controller = [[AddGoodsToShoppingViewController alloc] init];
    controller.info = self.info;
    controller.isBuy = NO;
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)buyBtnClick {
    AddGoodsToShoppingViewController *controller = [[AddGoodsToShoppingViewController alloc] init];
    controller.info = self.info;
    controller.isBuy = YES;
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 3;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    switch (index) {
        case 0:
        {
            StoreDetailFirstViewController *controller = [[StoreDetailFirstViewController alloc] init];
            controller.info = self.info;
            return controller;
        }
        case 1:
        {
            StoreDetailSecondViewController *controller = [[StoreDetailSecondViewController alloc] init];
            controller.info = self.info;
            return controller;
        }
        case 2:
        {
            StoreDetailThirdViewController *controller = [[StoreDetailThirdViewController alloc] init];
            return controller;
        }
            
        default:
            return nil;
    }
}

- (void)DLSlideTabbar:(id)sender selectAt:(NSInteger)index {
    
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
