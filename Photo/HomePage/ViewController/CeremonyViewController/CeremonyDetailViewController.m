//
//  CeremonyDetailViewController.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyDetailViewController.h"
#import "DLTabedSlideView.h"
#import "CeremonyWorksViewController.h"
#import "CeremonyIntroViewController.h"

@interface CeremonyDetailViewController () <NavigationBarDelegate, DLTabedSlideViewDelegate>

@property (nonatomic, strong) DLTabedSlideView *tabedSlideView;

@end

@implementation CeremonyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    NavigationBar *bar = [[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) withTitle:[NSString stringWithFormat:@"司仪-%@",self.info.ceremonyName]];
    bar.delegate = self;
    bar.line.hidden = NO;
    [self.view addSubview:bar];
    
    [self initView];
}

- (void)initView {
    self.tabedSlideView = [[DLTabedSlideView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHieght-200)];
    self.tabedSlideView.baseController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"作品" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"简介" image:nil selectedImage:nil];
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
            CeremonyWorksViewController *controller = [[CeremonyWorksViewController alloc] init];
            return controller;
        }
        case 1:
        {
            CeremonyIntroViewController *controller = [[CeremonyIntroViewController alloc] init];
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
