//
//  HomePageScrollView.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageScrollView.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface HomePageScrollView() <UIScrollViewDelegate>
{
    NSArray *_dataSource;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

@end

@implementation HomePageScrollView

-(id)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        _dataSource = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
        [self createScrollView];
    }
    return self;
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.contentSize = CGSizeMake(_dataSource.count*SCREEN_WIDTH, 250);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    [self createImageView];
    [self createPageView];
}

- (void)createImageView {
    for (int i = 0; i <= _dataSource.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, 250)];
        imageView.image = [UIImage imageNamed:@"main_my_bg.jpeg"];
        [_scrollView addSubview:imageView];
    }
}

- (void)createPageView {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 220, ScreenWidth, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _dataSource.count;
    [self addSubview:_pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(_scrollView.frame);
    NSUInteger page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

@end
