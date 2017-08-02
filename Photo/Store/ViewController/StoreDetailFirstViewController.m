//
//  StoreDetailFirstViewController.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreDetailFirstViewController.h"

@interface StoreDetailFirstViewController () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}

@end

@implementation StoreDetailFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createScrollView];
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, 250);
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.contentSize = CGSizeMake(self.info.goodsSlideUrls.count*ScreenWidth, 250);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    [self createImageView];
}

- (void)createImageView {
//    [self stopTimer];
    for (int i = 0; i < self.info.goodsSlideUrls.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, 250)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://101.201.122.173/%@",self.info.goodsSlideUrls[i]]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        imageView.image = imgFromUrl;
        [_scrollView addSubview:imageView];
    }
//    _currentPage = 0;
//    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(_scrollView.frame);
    NSUInteger page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    _pageControl.currentPage = page;
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
