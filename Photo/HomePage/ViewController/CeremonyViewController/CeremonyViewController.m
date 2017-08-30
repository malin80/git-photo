//
//  CeremonyViewController.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyViewController.h"
#import "DLTabedSlideView.h"
#import "CeremonyManViewController.h"
#import "CeremonyWomenViewController.h"
#import "CeremonyManager.h"

@interface CeremonyViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate>

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end

@implementation CeremonyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GET_SINGLETON_FOR_CLASS(CeremonyManager) queryAllCeremony];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"司仪"];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    
    [self addNotification];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryAllCeremonySuccess) name:@"queryAllCeremonySuccess" object:nil];
}

- (void)queryAllCeremonySuccess {
    [self initView];
}

- (void)initView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 100)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
//    title.text = [NSString stringWithFormat:@"团队价格¥ %ld起",self.info.teamPrice];
    title.text = @"还没做";
    [title sizeToFit];
    [titleView addSubview:title];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 100, 30)];
//    content.text = [NSString stringWithFormat:@"%@",self.info.teamDetail];
    [content sizeToFit];
    [titleView addSubview:content];
    
    titleView.backgroundColor = [UIColor colorR:153 G:167 B:176 alpha:1];
    [self.view addSubview:titleView];
    
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 164, ScreenWidth, ScreenHieght-200)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"男司仪" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"女司仪" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];
    
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return 2;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    switch (index) {
        case 0:
        {
            CeremonyManViewController *controller = [[CeremonyManViewController alloc] init];
            return controller;
        }
        case 1:
        {
            CeremonyWomenViewController *controller = [[CeremonyWomenViewController alloc] init];
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
