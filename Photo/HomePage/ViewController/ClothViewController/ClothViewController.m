//
//  ClothViewController.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothViewController.h"
#import "NavigationBar.h"
#import "ClothManager.h"
#import "DLTabedSlideView.h"
#import "ClothInfo.h"
#import "ClothCollectionViewController.h"

@interface ClothViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate>
{
    NSMutableArray *_slideViews;
}
@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end

@implementation ClothViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:@"婚纱礼服"];
    bar.delegate = self;
    bar.line.hidden=YES;
    [self.view addSubview:bar];
    
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [GET_SINGLETON_FOR_CLASS(ClothManager) queryClothTypes];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryClothTypesSuccess) name:@"queryClothTypesSuccess" object:nil];
}

- (void)queryClothTypesSuccess {
    [self initView];
}

- (void)initView {
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-64)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    _slideViews = [NSMutableArray array];
    for (int i = 0; i < GET_SINGLETON_FOR_CLASS(ClothManager).clothTypes.count; i++) {
        ClothInfo *info = GET_SINGLETON_FOR_CLASS(ClothManager).clothTypes[i];
        DLTabedbarItem *item = [DLTabedbarItem itemWithTitle:[NSString stringWithFormat:@"%@",info.clothTypeName] image:nil selectedImage:nil];
        [_slideViews addObject:item];
    }
    self.tabedSlideView.tabbarItems = _slideViews;
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    [self.view addSubview:self.tabedSlideView];
}

#pragma mark --- DLTabedSlideViewDelegate ---
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender {
    return _slideViews.count;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    ClothCollectionViewController *controller = [[ClothCollectionViewController alloc] init];
    ClothInfo *info = [GET_SINGLETON_FOR_CLASS(ClothManager).clothTypes objectAtIndex:index];
    controller.typeId = info.clothTypeId;
    return controller;
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
